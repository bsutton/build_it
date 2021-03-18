// @dart = 2.10

import 'package:build_it/build_it_models.dart';
import 'package:code_builder/code_builder.dart'
    hide Class, Directive, Field, Library;
import 'package:code_builder/code_builder.dart' as _code_builder;
import 'package:meta/meta.dart' hide literal;
import 'package:path/path.dart' as _path;

import 'generators.dart';
import 'json_models/json_models.g.dart';

part 'json_generator/json_class_generator.dart';
part 'json_generator/json_library_generator.dart';
part 'json_generator/json_field__generator.dart';

class JsonGenerator {
  final List<Directive> directives;

  final String input;

  final Library library;

  final String output;

  JsonGenerator(
      {@required this.directives,
      @required this.input,
      @required this.library,
      @required this.output});

  String generate() {
    final specs = <Spec>[];
    final g = JsonLibraryGenerator(
        directives: directives, library: library, specs: specs);
    g.generate();
    final fullPath = false;
    final basename = _path.basenameWithoutExtension(output);
    final segments = _path.split(output);
    var path = basename + '.g' + _path.extension(output);
    if (fullPath) {
      segments[segments.length - 1] = basename + '.g' + _path.extension(output);
      path = _path.joinAll(segments);
    }

    final partDirective = Directive(type: 'part', url: path);
    directives.add(partDirective);
    final library$ = _code_builder.Library((b) {
      b.body.addAll(specs);
    });

    final emitter = DartEmitter(Allocator.simplePrefixing());
    final result = '${library$.accept(emitter)}';
    return result;
  }
}
