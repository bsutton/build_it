// @dart = 2.10

part of '../json_generator.dart';

class JsonFieldGenerator extends Generator<_code_builder.Field>
    with CommentsGenerator {
  final bool checkNullSafety;

  final Field field;

  final int index;

  final bool immutable;

  final String objectName;

  JsonFieldGenerator(
      {@required this.checkNullSafety,
      @required this.field,
      @required this.immutable,
      @required this.index,
      @required this.objectName});

  @override
  _code_builder.Field generate() {
    return _code_builder.Field((b) {
      _addComments(b);
      _addAnnotations(b);
      _setName(b);
      _setType(b);
      _setMutability(b);
      if (field.jsonKey != null) {
        _addJsonKeyAnnotation(b, field.jsonKey);
      }

      if (_needCheckNullSafety()) {
        _checkNullSafety();
      }
    });
  }

  void _addAnnotation(FieldBuilder b, Expression annotation) {
    b.annotations.add(annotation);
  }

  void _addAnnotations(FieldBuilder b) {
    for (final annotation in field.annotations) {
      _addAnnotation(b, refer(annotation));
    }
  }

  void _addComments(FieldBuilder b) {
    if (field.comments != null) {
      b.docs.addAll(toDocComments(field.comments));
    }
  }

  void _addJsonKeyAnnotation(FieldBuilder b, JsonKeyAnnotation jsonKey) {
    final namedArguments = <String, Expression>{};
    final map = {
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
      _addAnnotation(b, annotation);
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
            'No default value specified for non-nullable property \'$name\'');
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
      return '${field.type} $objectName.${field.name}';
    }

    return '$objectName.${field.name}';
  }

  bool _needCheckNullSafety() {
    return checkNullSafety == true;
  }

  void _setMutability(FieldBuilder b) {
    if (immutable == true) {
      b.modifier = FieldModifier.final$;
    }
  }

  void _setName(FieldBuilder b) {
    final name = getField(field.name,
        'The name of the property with index $index of JSON object \'$objectName\' is not specified');
    b.name = name;
  }

  void _setType(FieldBuilder b) {
    final name = _getFullName(false);
    final type = getField(
        field.type, 'The type of property \'$name}\' is not specified.');
    b.type = refer(type);
  }
}
