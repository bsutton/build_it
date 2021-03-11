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
  void generate(StageBuilder builder) {
    builder.build('JSON objects', () => _build(builder));
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

  void _addImportJsonAnnotation(StageBuilder b) {
    const url = 'package:json_annotation/json_annotation.dart';
    final directive = Directive(type: 'import', url: url);
    directives.add(directive);
  }

  void _build(StageBuilder b) {
    _addImportJsonAnnotation(b);
    _addDirectives('export', jsonObjects.exports);
    _addDirectives('import', jsonObjects.imports);
    _addDirectives('part', jsonObjects.parts);
    _generateJsonObjects(b);
  }

  Class _generateJsonObject(StageBuilder b, JsonObject jsonObject) {
    final generator = JsonObjectGenerator(
        jsonObject: jsonObject, immutable: jsonObjects.immutable);
    return generator.generate(b);
  }

  void _generateJsonObjects(StageBuilder b) {
    final result = ItemsGenerator(
        stage: 'JSON object',
        input: jsonObjects.jsonObjects,
        build: (JsonObject jsonObject) =>
            _generateJsonObject(b, jsonObject)).generate(b);
    specs.addAll(result);
  }
}
