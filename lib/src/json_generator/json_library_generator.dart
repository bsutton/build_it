// @dart = 2.10

part of '../json_generator.dart';

class JsonLibraryGenerator extends Generator<void> {
  final List<Directive> directives;

  final Library element;

  final List<Spec> specs;

  JsonLibraryGenerator(
      {@required this.directives,
      @required this.element,
      @required this.specs});

  @override
  void generate() {
    _addImportJsonAnnotation();
    _addDirectives('export', element.exports);
    _addDirectives('import', element.imports);
    _addDirectives('part', element.parts);
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
    if (element.code != null) {
      specs.add(const Code('\n'));
      specs.add(Code(element.code));
    }
  }

  void _generateJsonClasses() {
    final classes = element.classes;
    for (var i = 0; i < classes.length; i++) {
      final clazz = classes[i];
      final g = JsonClassGenerator(element: clazz, index: i, parent: element);
      final result = g.generate();
      specs.add(result);
    }
  }

  void _generateJsonEnums() {
    final enums = element.enums;
    for (var i = 0; i < enums.length; i++) {
      final element = enums[i];
      final g = JsonEnumGenerator(enum$: element, index: i);
      final result = g.generate();
      specs.add(result);
    }
  }
}
