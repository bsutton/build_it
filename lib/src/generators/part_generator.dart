// @dart = 2.10

part of '../generators.dart';

abstract class PartGenererator {
  String getPartUrl(String path, bool fullPath) {
    final basename = _path.basenameWithoutExtension(path);
    final segments = _path.split(path);
    final name = basename + '.g' + _path.extension(path);
    if (fullPath) {
      segments[segments.length - 1] = basename + '.g' + _path.extension(path);
      return _path.joinAll(segments);
    } else {
      return name;
    }
  }
}
