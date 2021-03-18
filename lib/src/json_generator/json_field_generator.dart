// @dart = 2.10

part of '../json_generator.dart';

class JsonFieldGenerator extends Generator<_code_builder.Field>
    with DocsAndAnnotationsGenerator {
  final bool checkNullSafety;

  final String className;

  final Field field;

  final int index;

  final bool immutable;

  JsonFieldGenerator(
      {@required this.checkNullSafety,
      @required this.className,
      @required this.field,
      @required this.immutable,
      @required this.index});

  @override
  _code_builder.Field generate() {
    return _code_builder.Field((fieldBuilder) {
      addComments(fieldBuilder, field.comments);
      _addAnnotations(fieldBuilder);
      _setName(fieldBuilder);
      _setType(fieldBuilder);
      _setMutability(fieldBuilder);
      if (field.jsonKey != null) {
        _addJsonKeyAnnotation(fieldBuilder, field.jsonKey);
      }

      if (_needCheckNullSafety()) {
        _checkNullSafety();
      }
    });
  }

  void _addAnnotations(FieldBuilder fieldBuilder) {
    final annotations = field.annotations;
    for (final annotation in annotations) {
      addAnnotation(fieldBuilder, refer(annotation));
    }
  }

  void _addJsonKeyAnnotation(
      FieldBuilder fieldBuilder, JsonKeyAnnotation jsonKey) {
    final namedArguments = <String, Expression>{};
    final map = {
      'defaultValue': jsonKey.defaultValue,
      'disallowNullValue': jsonKey.disallowNullValue,
      'fromJson': jsonKey.fromJson$,
      'ignore': jsonKey.ignore,
      'includeIfNull': jsonKey.includeIfNull,
      'name': jsonKey.name,
      'required': jsonKey.required,
      'toJson': jsonKey.toJson$,
      'unknownEnumValue': jsonKey.unknownEnumValue,
    };

    for (final key in map.keys) {
      final value = map[key];
      if (value != null) {
        namedArguments[key] = literal(value);
      }
    }

    if (namedArguments.isNotEmpty) {
      final annotation = refer('JsonKey').call([], namedArguments);
      addAnnotation(fieldBuilder, annotation);
    }
  }

  void _checkNullSafety() {
    final defaultValue = _getDefaultValue();
    if (defaultValue == null) {
      final type = field.type.trim();
      final isNullable = type.endsWith('?');
      if (!isNullable && _needCheckNullSafety()) {
        final name = _getFullName(true);
        throw StateError(
            'No default value specified for non-nullable field \'$name\'');
      }
    }
  }

  Expression _getDefaultValue() {
    if (field.jsonKey == null) {
      return null;
    }

    final defaultValue = field.jsonKey.defaultValue;
    if (defaultValue == null) {
      return null;
    }

    if (defaultValue is bool) {
      return literalBool(defaultValue);
    }

    if (defaultValue is double) {
      return literal(defaultValue);
    }

    if (defaultValue is int) {
      return literal(defaultValue);
    }

    if (defaultValue is List) {
      return literalList(defaultValue);
    }

    if (defaultValue is Map) {
      return literalMap(defaultValue);
    }

    if (defaultValue is String) {
      final type = field.type.trim().replaceAll(' ', '');
      if (type == 'String' || type == 'String?') {
        return literalString(defaultValue);
      }

      if (defaultValue.trim().isEmpty) {
        final name = _getFullName(true);
        throw StateError(
            'The default value specified for field \'$name\' must not be empty');
      }

      return CodeExpression(Code(defaultValue));
    }

    return null;
  }

  String _getFullName(bool withType) {
    if (withType) {
      return '${field.type} $className.${field.name}';
    }

    return '$className.${field.name}';
  }

  bool _needCheckNullSafety() {
    return checkNullSafety == true;
  }

  void _setMutability(FieldBuilder fieldBuilder) {
    if (immutable == true) {
      fieldBuilder.modifier = FieldModifier.final$;
    }
  }

  void _setName(FieldBuilder fieldBuilder) {
    final name = getField(field.name,
        'The name of the field with index $index of JSON class \'$className\' is not specified');
    fieldBuilder.name = name;
  }

  void _setType(FieldBuilder fieldBuilder) {
    final name = _getFullName(false);
    final type =
        getField(field.type, 'The type of field \'$name}\' is not specified.');
    fieldBuilder.type = refer(type);
  }
}
