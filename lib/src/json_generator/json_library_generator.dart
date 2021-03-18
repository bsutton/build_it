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
    _generateJsonClasses();
    _generateJsonEnums();
    _generateCode();
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

  void _generateCode() {
    if (library.code != null) {
      specs.add(Code(library.code));
    }
  }

  void _generateJsonClasses() {
    final classes = library.classes;
    for (var i = 0; i < classes.length; i++) {
      final element = classes[i];
      final g = JsonClassGenerator(
          clazz: element,
          immutable: library.immutable,
          index: i,
          checkNullSafety: library.checkNullSafety);
      final result = g.generate();
      specs.add(result);
    }
  }

  void _generateJsonEnums() {
    final enums = library.enums;
    for (var i = 0; i < enums.length; i++) {
      final element = enums[i];
      final g = JsonEnumGenerator(enum$: element, index: i);
      final result = g.generate();
      specs.add(result);
    }
  }
}
