part of '../directive_extension.dart';

extension DirectiveExtension on Directive {
  bool equals(Directive other) {
    if (identical(this, other)) {
      return true;
    }

    if (type != other.type || url != other.url || as != other.as) {
      return false;
    }

    if (!identical(hide, other.hide)) {
      if (hide == null || other.hide == null) {
        return false;
      }

      final equality = SetEquality();
      final equals = equality.equals(hide!.toSet(), other.hide!.toSet());
      if (!equals) {
        return false;
      }
    }

    if (!identical(show, other.show)) {
      if (show == null || other.show == null) {
        return false;
      }

      final equality = SetEquality();
      final equals = equality.equals(show!.toSet(), other.show!.toSet());
      if (!equals) {
        return false;
      }
    }

    final d1 = deferred == true ? true : false;
    final d2 = other.deferred == true ? true : false;
    return d1 == d2;
  }

  String asString() {
    final sb = StringBuffer();
    sb.write(type);
    sb.write(' \'');
    sb.write(url);
    sb.write('\'');
    if (deferred == true) {
      sb.write(' deferred');
    }

    if (as != null) {
      sb.write(' as ');
      sb.write(as);
    }

    if (hide != null) {
      sb.write(' hide ');
      sb.write(hide!.join(', '));
    }

    if (show != null) {
      sb.write(' show ');
      sb.write(show!.join(', '));
    }

    return sb.toString();
  }
}

extension DirectiveListExtension<E extends Directive> on List<E> {
  List<E> unique() {
    final hashSet =
        HashSet<E>(equals: (x, y) => x.equals(y), hashCode: (e) => 0);
    hashSet.addAll(this);
    return hashSet.toList();
  }

  List<E> invalid() {
    final result = <E>[];
    final types = const {'export', 'import', 'part', 'part of'};
    result.addAll(where((e) => !types.contains(e.type)));
    result.addAll(where(
        (e) => e.type == 'export' && (e.as != null || e.deferred == true)));
    result.addAll(where((e) =>
        (e.type == 'part' || e.type == 'part of') &&
        (e.as != null ||
            e.hide != null ||
            e.show != null ||
            e.deferred == true)));
    return result;
  }

  List<String> organize() {
    final result = <String>[];
    if (isEmpty) {
      return result;
    }

    void add(List<String> code, String type) {
      final result = <String>[];
      final found = where((e) => e.type == type);
      result.addAll(found.map((e) => e.asString() + ';\n'));
      result.sort();
      code.add(result.join(''));
      if (found.isNotEmpty) {
        code.add('\n');
      }
    }

    add(result, 'import');
    add(result, 'export');
    add(result, 'part');
    add(result, 'part of');

    return result;
  }
}
