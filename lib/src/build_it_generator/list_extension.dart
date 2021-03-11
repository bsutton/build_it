// @dart = 2.10

part of '../../build_it_generator.dart';

extension _ListExt<E> on List<E> {
  bool equalsTo(List<E> other) {
    if (identical(this, other)) {
      return true;
    }

    if (this == null) {
      return false;
    }

    if (length != other.length) {
      return false;
    }

    return toSet().equalsTo(other.toSet());
  }
}
