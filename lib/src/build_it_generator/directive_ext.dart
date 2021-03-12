// @dart = 2.10

part of '../build_it_generator.dart';

extension _DirectiveExt on Directive {
  bool equalsTo(Directive other) {
    if (identical(this, other)) {
      return true;
    }

    if (this == null) {
      return false;
    }

    if (type != other.type || url != other.url || as != other.as) {
      return false;
    }

    if (!hide.equalsTo(other.hide) || !show.equalsTo(other.show)) {
      return false;
    }

    return deferred == other.deferred;
  }

  String asString() {
    final sb = StringBuffer();
    sb.write(type);
    sb.write(' \'');
    sb.write(url);
    sb.write('\'');
    if (hide != null) {
      sb.write(' hide ');
      sb.write(hide.join(', '));
    }

    if (show != null) {
      sb.write(' show ');
      sb.write(show.join(', '));
    }

    if (as != null) {
      sb.write(' as ');
      sb.write(as);
    }

    return sb.toString();
  }
}
