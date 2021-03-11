// @dart = 2.10

part of '../../build_it_generator.dart';

extension _SetExt<E> on Set<E> {
  bool equalsTo(Set<E> other) {
    if (identical(this, other)) {
      return true;
    }

    if (this == null) {
      return false;
    }

    for (final value in this) {
      if (!other.contains(value)) {
        return false;
      }
    }

    return true;
  }
}
