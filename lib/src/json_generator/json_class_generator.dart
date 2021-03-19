// @dart = 2.10

part of '../json_generator.dart';

class JsonClassGenerator extends Generator<_code_builder.Class>
    with DocsAndAnnotationsGenerator {
  final Class element;

  final int index;

  final Library parent;

  JsonClassGenerator(
      {@required this.element, @required this.index, @required this.parent});

  @override
  _code_builder.Class generate() {
    return _code_builder.Class((classBuilder) {
      addComments(classBuilder, element.comments);
      addAnnotations(classBuilder, element.annotations);
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
      final properties = element.fields;
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
          'Creates an instance of \'${element.name}\' from a JSON representation';
      constructorBuilder.docs.addAll(toDocComments(comment));
      constructorBuilder.factory = true;
      constructorBuilder.name = 'fromJson';
      constructorBuilder.requiredParameters.add(Parameter((parameterBuilder) {
        parameterBuilder.name = 'json';
        parameterBuilder.type = refer('Map<String, dynamic>');
      }));

      constructorBuilder.lambda = true;
      constructorBuilder.body =
          refer('_\$${element.name}FromJson').call([refer('json')]).code;
    });

    classBuilder.constructors.add(result);
  }

  void _addFields(ClassBuilder classBuilder) {
    final fields = element.fields;
    for (var i = 0; i < fields.length; i++) {
      final field = fields[i];
      final g = JsonFieldGenerator(
          immutable: _immutable(),
          index: i,
          parent: element,
          element: field,
          checkNullSafety: _checkNullSafety());
      final result = g.generate();
      classBuilder.fields.add(result);
    }
  }

  void _addJsonSerializableAnnotation(ClassBuilder classBuilder) {
    final defaults = _jsonSerializableToMap(parent.jsonSerializable);
    final current = _jsonSerializableToMap(element.jsonSerializable);
    final namedArguments = <String, Expression>{};
    for (final key in current.keys) {
      final value = current[key] ?? defaults[key];
      if (value != null) {
        namedArguments[key] = literal(value);
      }
    }

    final annotation = refer('JsonSerializable').call([], namedArguments);
    addAnnotation(classBuilder, annotation);
  }

  void _addMethodToJson(ClassBuilder classBuilder) {
    final result = Method((methodBuilder) {
      final comment =
          'Returns a JSON representation of the \'${element.name}\' instance.';
      methodBuilder.docs.addAll(toDocComments(comment));
      methodBuilder.name = 'toJson';
      methodBuilder.returns = refer('Map<String, dynamic>');
      methodBuilder.lambda = true;
      methodBuilder.body =
          refer('_\$${element.name}ToJson').call([refer('this')]).code;
    });

    classBuilder.methods.add(result);
  }

  bool _checkNullSafety() {
    return parent.checkNullSafety == true;
  }

  bool _immutable() {
    if (element.immutable != null) {
      return element.immutable;
    }

    return parent.immutable == true;
  }

  Map<String, dynamic> _jsonSerializableToMap(
      JsonSerializableAnnotation jsonSerializable) {
    final object = jsonSerializable ?? JsonSerializableAnnotation();
    return {
      'anyMap': object.anyMap,
      'checked': object.checked,
      'createFactory': object.createFactory,
      'createToJson': object.createToJson,
      'disallowUnrecognizedKeys': object.disallowUnrecognizedKeys,
      'explicitToJson': object.explicitToJson,
      'fieldRename': object.fieldRename,
      'genericArgumentFactories': object.genericArgumentFactories,
      'ignoreUnannotated': object.ignoreUnannotated,
      'includeIfNull': object.includeIfNull,
    };
  }

  void _setName(ClassBuilder classBuilder) {
    final name = getField(element.name,
        'The name of JSON object with index $index is not specified');
    classBuilder.name = name;
  }
}
