// @dart = 2.10

part of '../generators.dart';

abstract class Generator<E> {
  E generate(StageBuilder builder);

  T getField<T>(T value, String name) {
    if (value is T) {
      return value;
    }

    throw StateError('Field \'$name\' must not be null');
  }

  bool hasAnnotation(List<String> annotations, String annotation) {
    return (annotations ?? [])
        .map((e) => e.replaceAll(' ', ''))
        .where((e) => e.startsWith('$annotation(') || e == annotation)
        .isNotEmpty;
  }
}
