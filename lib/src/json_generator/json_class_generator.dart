// @dart = 2.10

part of '../json_generator.dart';

class JsonClassGenerator extends Generator<_code_builder.Class>
    with DocsAndAnnotationsGenerator {
  final bool checkNullSafety;

  final Class clazz;

  final bool immutable;

  final int index;

  final JsonSerializableAnnotation jsonSerializable;

  JsonClassGenerator(
      {@required this.checkNullSafety,
      @required this.clazz,
      @required this.index,
      @required this.immutable,
      this.jsonSerializable});

  @override
  _code_builder.Class generate() {
    return _code_builder.Class((classBuilder) {
      addComments(classBuilder, clazz.comments);
      addAnnotations(classBuilder, clazz.annotations);
      _setName(classBuilder);
      _addFields(classBuilder);
      _addContructor(classBuilder);
      _addFactoryFromJson(classBuilder);
      _addMethodToJson(classBuilder);
      _addJsonSerializableAnnotation(classBuilder);
    });
  }

  void _addContructor(ClassBuilder classBuilder) {
    final result = Constructor((constructorBuilder) {
      final properties = clazz.fields;
      for (final property in properties) {
        constructorBuilder.optionalParameters.add(Parameter((parameterBuilder) {
          parameterBuilder.named = true;
          parameterBuilder.toThis = true;
          parameterBuilder.name = property.name;
          if (!property.type.trim().endsWith('?')) {
            parameterBuilder.required = true;
          }
        }));
      }
    });

    classBuilder.constructors.add(result);
  }

  void _addFactoryFromJson(ClassBuilder classBuilder) {
    final result = Constructor((constructorBuilder) {
      final comment =
          'Creates an instance of \'${clazz.name}\' from a JSON representation';
      constructorBuilder.docs.addAll(toDocComments(comment));
      constructorBuilder.factory = true;
      constructorBuilder.name = 'fromJson';
      constructorBuilder.requiredParameters.add(Parameter((parameterBuilder) {
        parameterBuilder.name = 'json';
        parameterBuilder.type = refer('Map<String, dynamic>');
      }));

      constructorBuilder.lambda = true;
      constructorBuilder.body =
          refer('_\$${clazz.name}FromJson').call([refer('json')]).code;
    });

    classBuilder.constructors.add(result);
  }

  void _addFields(ClassBuilder classBuilder) {
    final fields = clazz.fields;
    for (var i = 0; i < fields.length; i++) {
      final element = fields[i];
      final g = JsonFieldGenerator(
          immutable: _isImmutable(),
          index: i,
          className: clazz.name,
          field: element,
          checkNullSafety: _needCheckNullSafety());
      final result = g.generate();
      classBuilder.fields.add(result);
    }
  }

  void _addJsonSerializableAnnotation(ClassBuilder classBuilder) {
    final jsonSerializable = clazz.jsonSerializable;
    final namedArguments = <String, Expression>{};
    if (jsonSerializable != null) {
      final map = {
        'anyMap': jsonSerializable.anyMap,
        'checked': jsonSerializable.checked,
        'createFactory': jsonSerializable.createFactory,
        'createToJson': jsonSerializable.createToJson,
        'disallowUnrecognizedKeys': jsonSerializable.disallowUnrecognizedKeys,
        'explicitToJson': jsonSerializable.explicitToJson,
        'fieldRename': jsonSerializable.fieldRename,
        'genericArgumentFactories': jsonSerializable.genericArgumentFactories,
        'ignoreUnannotated': jsonSerializable.ignoreUnannotated,
        'includeIfNull': jsonSerializable.includeIfNull,
      };

      for (final key in map.keys) {
        final value = map[key];
        if (value != null) {
          namedArguments[key] = literal(value);
        }
      }
    }

    final annotation = refer('JsonSerializable').call([], namedArguments);
    addAnnotation(classBuilder, annotation);
  }

  void _addMethodToJson(ClassBuilder classBuilder) {
    final result = Method((methodBuilder) {
      final comment =
          'Returns a JSON representation of the \'${clazz.name}\' instance.';
      methodBuilder.docs.addAll(toDocComments(comment));
      methodBuilder.name = 'toJson';
      methodBuilder.returns = refer('Map<String, dynamic>');
      methodBuilder.lambda = true;
      methodBuilder.body =
          refer('_\$${clazz.name}ToJson').call([refer('this')]).code;
    });

    classBuilder.methods.add(result);
  }

  bool _isImmutable() {
    if (clazz.immutable != null) {
      return clazz.immutable;
    }

    return immutable == true;
  }

  bool _needCheckNullSafety() {
    return checkNullSafety == true;
  }

  void _setName(ClassBuilder classBuilder) {
    final name = getField(clazz.name,
        'The name of JSON object with index $index is not specified');
    classBuilder.name = name;
  }
}
