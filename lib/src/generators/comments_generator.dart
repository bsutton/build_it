// @dart = 2.10

part of '../generators.dart';

abstract class CommentsGenerator {
  List<String> toDocComments(String comments) {
    if (comments == null) {
      return null;
    }

    // TODO: Split lines by a specific maximum length
    final lines = LineSplitter().convert(comments);
    return lines.map((e) => '/// $e').toList();
  }
}
