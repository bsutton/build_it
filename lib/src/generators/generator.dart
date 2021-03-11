// @dart = 2.10

part of '../generators.dart';

abstract class Generator<E> {
  E generate();

  T getField<T>(T value, String message) {
    if (value is T) {
      return value;
    }

    throw StateError(message);
  }

  bool hasAnnotation(List<String> annotations, String annotation) {
    return (annotations ?? [])
        .map((e) => e.replaceAll(' ', ''))
        .where((e) => e.startsWith('$annotation(') || e == annotation)
        .isNotEmpty;
  }
}
