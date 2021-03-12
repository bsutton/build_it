// @dart = 2.10

part of '../json_generator.dart';

class JsonObjectGenerator extends Generator<Class> with CommentsGenerator {
  final bool checkNullSafety;

  final bool immutable;

  final int index;

  final JsonObject jsonObject;

  JsonObjectGenerator(
      {@required this.checkNullSafety,
      @required this.index,
      @required this.immutable,
      @required this.jsonObject});

  @override
  Class generate() {
    return Class((cb) {
      _addComments(cb);
      _addAnnotations(cb);
      _setName(cb);
      _addFields(cb);
      _addContructor(cb);
      _addFactoryFromJson(cb);
      _addMethodToJson(cb);
    });
  }

  void _addAnnotation(ClassBuilder cb, Expression annotation) {
    cb.annotations.add(annotation);
  }

  void _addAnnotations(ClassBuilder cb) {
    final annotations = _getAnnotations();
    if (!hasAnnotation(annotations, 'JsonSerializable(')) {
      _addAnnotation(cb, refer('JsonSerializable()'));
    } else {
      for (final annotation in annotations) {
        _addAnnotation(cb, refer(annotation));
      }
    }
  }

  void _addComments(ClassBuilder b) {
    if (jsonObject.comments != null) {
      b.docs.addAll(toDocComments(jsonObject.comments));
    }
  }

  void _addContructor(ClassBuilder cb) {
    final result = Constructor((b) {
      final properties = jsonObject.properties;
      for (final property in properties) {
        b.optionalParameters.add(Parameter((b) {
          b.named = true;
          b.toThis = true;
          b.name = property.name;
          if (!property.type.trim().endsWith('?')) {
            b.required = true;
          }
        }));
      }
    });

    cb.constructors.add(result);
  }

  void _addFactoryFromJson(ClassBuilder cb) {
    final result = Constructor((b) {
      final comment = 'Creates an object from a JSON representation';
      b.docs.addAll(toDocComments(comment));
      b.factory = true;
      b.name = 'fromJson';
      b.requiredParameters.add(Parameter((b) {
        b.name = 'json';
        b.type = refer('Map<String, dynamic>');
      }));

      b.lambda = true;
      b.body =
          refer('_\$${jsonObject.name}FromJson').call([refer('json')]).code;
    });

    cb.constructors.add(result);
  }

  void _addFields(ClassBuilder cb) {
    final list = jsonObject.properties;
    for (var i = 0; i < list.length; i++) {
      final element = list[i];
      final g = PropertyGenerator(
          immutable: _isImmutable(),
          index: i,
          objectName: jsonObject.name,
          property: element,
          checkNullSafety: _needCheckNullSafety());
      final result = g.generate();
      cb.fields.add(result);
    }
  }

  void _addMethodToJson(ClassBuilder cb) {
    final result = Method((b) {
      final comment = 'Returns a JSON representation of the object';
      b.docs.addAll(toDocComments(comment));
      b.name = 'toJson';
      b.returns = refer('Map<String, dynamic>');
      b.lambda = true;
      b.body = refer('_\$${jsonObject.name}ToJson').call([refer('this')]).code;
    });

    cb.methods.add(result);
  }

  List<String> _getAnnotations() {
    return jsonObject.annotations;
  }

  bool _isImmutable() {
    if (jsonObject.immutable != null) {
      return jsonObject.immutable;
    }

    return immutable == true;
  }

  bool _needCheckNullSafety() {
    return checkNullSafety == true;
  }

  void _setName(ClassBuilder b) {
    final name = getField(jsonObject.name,
        'The name of JSON object with index $index is not specified');
    b.name = name;
  }
}
