// @dart = 2.10

part of '../json_generator.dart';

class JsonEnumGenerator extends Generator<_code_builder.Enum>
    with DocsAndAnnotationsGenerator {
  final Enum enum$;

  final int index;

  JsonEnumGenerator({@required this.enum$, @required this.index});

  @override
  _code_builder.Enum generate() {
    return _code_builder.Enum((enumBuilder) {
      addComments(enumBuilder, enum$.comments);
      addAnnotations(enumBuilder, enum$.annotations);
      _setName(enumBuilder);
      _addValues(enumBuilder);
    });
  }

  void _addValues(EnumBuilder enumBuilder) {
    final values = enum$.values;
    if (values.isEmpty) {
      throw StateError('JSON enumeration \'${enum$.name}\' must have values');
    }

    for (var i = 0; i < values.length; i++) {
      final element = values[i];
      final g = JsonEnumValueGenerator(
          enumName: enum$.name, enumValue: element, index: i);
      final result = g.generate();
      enumBuilder.values.add(result);
    }
  }

  void _setName(EnumBuilder enumBuilder) {
    final name = getField(
        enum$.name, 'The name of JSON enum with index $index is not specified');
    enumBuilder.name = name;
  }
}
