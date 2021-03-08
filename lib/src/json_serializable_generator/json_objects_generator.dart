// @dart = 2.10

part of '../json_serializable_generator.dart';

class JsonObjectsGenerator extends Generator<void> with DirectivesGenerator {
  final List<Spec> declarations;

  final JsonObjects jsonObjects;

  JsonObjectsGenerator(
      {@required this.declarations, @required this.jsonObjects});

  @override
  void generate(StageBuilder builder) {
    builder.build('JSON objects', () => _build(builder));
  }

  void _addImportJsonAnnotation(StageBuilder b) {
    const url = 'package:json_annotation/json_annotation.dart';
    declarations.add(Directive.import(url));
  }

  void _build(StageBuilder b) {
    _addImportJsonAnnotation(b);
    addDirectives(declarations, DirectiveType.export, jsonObjects.exports);
    addDirectives(declarations, DirectiveType.import, jsonObjects.imports);
    addDirectives(declarations, DirectiveType.part, jsonObjects.parts);
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
    declarations.addAll(result);
  }
}
