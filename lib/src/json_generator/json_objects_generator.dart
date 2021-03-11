// @dart = 2.10

part of '../json_generator.dart';

class JsonObjectsGenerator extends Generator<void> {
  final List<Directive> directives;

  final JsonObjects jsonObjects;

  final List<Spec> specs;

  JsonObjectsGenerator(
      {@required this.directives,
      @required this.jsonObjects,
      @required this.specs});

  @override
  void generate() {
    _addImportJsonAnnotation();
    _addDirectives('export', jsonObjects.exports);
    _addDirectives('import', jsonObjects.imports);
    _addDirectives('part', jsonObjects.parts);
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
    final list = jsonObjects.jsonObjects;
    for (var i = 0; i < list.length; i++) {
      final element = list[i];
      final g = JsonObjectGenerator(
          jsonObject: element,
          immutable: jsonObjects.immutable,
          index: i,
          checkNullSafety: jsonObjects.checkNullSafety);

      final result = g.generate();
      specs.add(result);
    }
  }
}
