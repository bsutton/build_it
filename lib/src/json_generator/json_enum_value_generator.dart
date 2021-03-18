// @dart = 2.10

part of '../json_generator.dart';

class JsonEnumValueGenerator extends Generator<_code_builder.EnumValue>
    with DocsAndAnnotationsGenerator {
  EnumValue enumValue;

  String enumName;

  int index;

  JsonEnumValueGenerator(
      {@required this.enumName,
      @required this.enumValue,
      @required this.index});

  @override
  _code_builder.EnumValue generate() {
    return _code_builder.EnumValue((enumValueBuilder) {
      addComments(enumValueBuilder, enumValue.comments);
      addAnnotations(enumValueBuilder, enumValue.annotations);
      _setName(enumValueBuilder);
      if (enumValue.jsonValue != null) {
        _addJsonValueAnnotation(enumValueBuilder, enumValue.jsonValue);
      }
    });
  }

  void _addJsonValueAnnotation(
      EnumValueBuilder enumValueBuilder, JsonValueAnnotation jsonValue) {
    final annotation = refer('JsonValue').call([literal(jsonValue.value)]);
    addAnnotation(enumValueBuilder, annotation);
  }

  void _setName(EnumValueBuilder enumValueBuilder) {
    final name = getField(enumValue.name,
        'The name of the enum value with index $index of JSON enum \'$enumName\' is not specified');
    enumValueBuilder.name = name;
  }
}
