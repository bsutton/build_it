// @dart = 2.10

part of '../json_generator.dart';

class JsonLibraryGenerator extends Generator<void> {
  final List<Directive> directives;

  final Library library;

  final List<Spec> specs;

  JsonLibraryGenerator(
      {@required this.directives,
      @required this.library,
      @required this.specs});

  @override
  void generate() {
    _addImportJsonAnnotation();
    _addDirectives('export', library.exports);
    _addDirectives('import', library.imports);
    _addDirectives('part', library.parts);
    _generateJsonObjects();
  }

  void _addDirectives(String type, List<String> urls) {
    if (urls == null) {
      return;
    }

    for (final url in urls) {
      final directive = Directive(type: type, url: url);
      directives.add(directive);
    }
  }

  void _addImportJsonAnnotation() {
    const url = 'package:json_annotation/json_annotation.dart';
    final directive = Directive(type: 'import', url: url);
    directives.add(directive);
  }

  void _generateJsonObjects() {
    final list = library.classes;
    for (var i = 0; i < list.length; i++) {
      final element = list[i];
      final g = JsonClassGenerator(
          clazz: element,
          immutable: library.immutable,
          index: i,
          checkNullSafety: library.checkNullSafety);

      final result = g.generate();
      specs.add(result);
    }
  }
}
