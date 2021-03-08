// @dart = 2.10

import 'dart:collection';
import 'dart:convert';

import 'package:build_it/src/generators.dart';
import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart' as _yaml;

import 'src/json_serializable_generator.dart';

class BuildItGenerator extends Generator with PartGenererator {
  final String input;

  final String output;

  final String source;

  BuildItGenerator(
      {@required this.input, @required this.output, @required this.source});

  @override
  String generate(StageBuilder builder) {
    final yamlDocuments = _yaml.loadYamlDocuments(source);
    if (yamlDocuments.length % 2 != 0) {
      return null;
    }

    final specs = <Spec>[];
    final directives = <Directive>[];
    for (var i = 0; i < yamlDocuments.length; i += 2) {
      final generatorName = _getGeneratorName(yamlDocuments[i]);
      if (generatorName == null) {
        return null;
      }

      specs.add(const Code(
          '// **************************************************************************\n'));
      specs.add(Code('// build_it: $generatorName\n'));
      specs.add(const Code(
          '// **************************************************************************\n'));
      specs.add(const Code('\n'));

      final declarations = <Spec>[];
      final json = _toJson(yamlDocuments[i + 1].contents);
      switch (generatorName) {
        case 'JsonSerializable':
          final generator =
              JsonSerializableGenerator(declarations: declarations, json: json);
          generator.generate(builder);
          break;
        default:
          throw FormatException(
              'An unknown generator \'$generatorName\' was specified: \'$input\'');
      }

      specs.addAll(declarations.where((e) => e is! Directive));
      directives.addAll(declarations.whereType());
    }

    final prologue = <Spec>[];
    prologue.add(const Code('// GENERATED CODE - DO NOT MODIFY BY HAND\n'));
    prologue.add(const Code('\n'));

    directives.add(Directive.part(getPartUrl(output, false)));
    _addDirectives(prologue, directives, DirectiveType.import);
    _addDirectives(prologue, directives, DirectiveType.export);
    _addDirectives(prologue, directives, DirectiveType.part);

    specs.insertAll(0, prologue);

    final library = Library((b) {
      b.body.addAll(specs);
    });

    final emitter = DartEmitter(Allocator.simplePrefixing(), true);
    final result = '${library.accept(emitter)}';
    return result;
  }

  void _addDirectives(
      List<Spec> specs, List<Directive> directives, DirectiveType type) {
    final filtered = directives.where((e) => e.type == type);
    final hashSeth =
        HashSet<Directive>(equals: (x, y) => x.equalsTo(y), hashCode: (e) => 0);
    hashSeth.addAll(filtered);
    specs.addAll(hashSeth);
    specs.add(const Code('\n'));
    if (hashSeth.isNotEmpty) {
      specs.add(const Code('\n'));
    }
  }

  String _getGeneratorName(_yaml.YamlDocument document) {
    final contents = document.contents;
    if (contents is! Map) {
      return null;
    }

    final map = contents as Map;
    final format = map['format'];
    if (format is Map) {
      if (format['name'] == 'build_it') {
        final generator = format['generator'];
        if (generator is Map) {
          if (generator['name'] is String) {
            return generator['name'] as String;
          }
        }
      }
    }

    return null;
  }

  Map<String, dynamic> _toJson(object) {
    if (object is! Map) {
      throw FormatException('Incorrect configuration format');
    }

    final encoded = jsonEncode(object);
    final decoded = jsonDecode(encoded);
    return (decoded as Map).cast();
  }
}

extension _DirectiveExt on Directive {
  bool equalsTo(Directive other) {
    if (identical(this, other)) {
      return true;
    }

    if (type != other.type || url != other.url) {
      return false;
    }

    if (!hide.equalsTo(other.hide) || !show.equalsTo(other.show)) {
      return false;
    }

    return deferred != other.deferred;
  }
}

extension _ListExt<E> on List<E> {
  bool equalsTo(List<E> other) {
    if (identical(this, other)) {
      return true;
    }

    if (length != other.length) {
      return false;
    }

    return !toSet().equalsTo(other.toSet());
  }
}

extension _SetExt<E> on Set<E> {
  bool equalsTo(Set<E> other) {
    if (identical(this, other)) {
      return true;
    }

    for (final value in this) {
      if (!other.contains(value)) {
        return false;
      }
    }

    return true;
  }
}
