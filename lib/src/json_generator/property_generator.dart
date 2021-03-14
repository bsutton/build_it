// @dart = 2.10

part of '../json_generator.dart';

class PropertyGenerator extends Generator<Field> with CommentsGenerator {
  final bool checkNullSafety;

  final int index;

  final bool immutable;

  final String objectName;

  final Property property;

  PropertyGenerator(
      {@required this.checkNullSafety,
      @required this.immutable,
      @required this.index,
      @required this.objectName,
      @required this.property});

  @override
  Field generate() {
    return Field((b) {
      _addComments(b);
      _addAnnotations(b);
      _setName(b);
      _setType(b);
      _setMutability(b);
      _addJsonKeyAnnotation(b);
    });
  }

  void _addAnnotation(FieldBuilder b, Expression annotation) {
    b.annotations.add(annotation);
  }

  void _addAnnotations(FieldBuilder b) {
    for (final annotation in property.annotations) {
      _addAnnotation(b, refer(annotation));
    }
  }

  void _addComments(FieldBuilder b) {
    if (property.comments != null) {
      b.docs.addAll(toDocComments(property.comments));
    }
  }

  void _addJsonKeyAnnotation(FieldBuilder b) {
    final namedArguments = <String, Expression>{};
    if (property.key != null) {
      namedArguments['name'] = literalString(property.key);
    }

    final defaultValue = _getDefaultValue();
    if (defaultValue != null) {
      namedArguments['defaultValue'] = defaultValue;
    } else {
      final type = property.type.trim();
      final isNullable = type.endsWith('?');
      if (!isNullable && _needCheckNullSafety()) {
        final name = _getFullName(true);
        throw StateError(
            'No default value specified for non-nullable property \'$name\'');
      }
    }

    if (namedArguments.isNotEmpty) {
      final annotation = refer('JsonKey').call([], namedArguments);
      _addAnnotation(b, annotation);
    }
  }

  Expression _getDefaultValue() {
    final defaultValue = property.defaultValue;
    if (defaultValue == null) {
      return null;
    }

    if (property.defaultValue != null) {
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
        final type = property.type.trim().replaceAll(' ', '');
        if (type == 'String' || type == 'String?') {
          return literalString(defaultValue);
        }

        if (defaultValue.trim().isEmpty) {
          final name = _getFullName(true);
          throw StateError(
              'The default value specified for property \'$name\' must not be empty');
        }

        return CodeExpression(Code(defaultValue));
      }
    }

    return null;
  }

  String _getFullName(bool withType) {
    if (withType) {
      return '${property.type} $objectName.${property.name}';
    }

    return '$objectName.${property.name}';
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
    final name = getField(property.name,
        'The name of the property with index $index of JSON object \'$objectName\' is not specified');
    b.name = name;
  }

  void _setType(FieldBuilder b) {
    final name = _getFullName(false);
    final type = getField(
        property.type, 'The type of property \'$name}\' is not specified.');
    b.type = refer(type);
  }
}
