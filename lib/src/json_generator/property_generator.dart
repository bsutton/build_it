// @dart = 2.10

part of '../json_generator.dart';

class PropertyGenerator extends Generator<Field> with CommentsGenerator {
  final bool immutable;

  final Property property;

  PropertyGenerator({@required this.immutable, @required this.property});

  @override
  Field generate(StageBuilder builder) {
    return builder.build('Property \'${property.name}\'', _build);
  }

  void _addAnnotation(FieldBuilder b, Expression annotation) {
    b.annotations.add(annotation);
  }

  void _addAnnotations(FieldBuilder b) {
    for (final annotation in _getAnnotations()) {
      _addAnnotation(b, refer(annotation));
    }
  }

  void _addComments(FieldBuilder b) {
    if (property.comments != null) {
      b.docs.addAll(toDocComments(property.comments));
    }
  }

  Field _build() {
    return Field((b) {
      _addComments(b);
      _addAnnotations(b);
      _setName(b);
      _setType(b);
      _setMutability(b);
    });
  }

  List<String> _getAnnotations() {
    return property.annotations ?? [];
  }

  void _setMutability(FieldBuilder b) {
    if (immutable == true) {
      b.modifier = FieldModifier.final$;
    }
  }

  void _setName(FieldBuilder b) {
    final name = getField(property.name, 'name');
    b.name = name;
  }

  void _setType(FieldBuilder b) {
    final type = getField(property.type, 'type');
    b.type = refer(type);
  }
}
