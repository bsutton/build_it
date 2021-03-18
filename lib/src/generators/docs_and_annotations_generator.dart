// @dart = 2.10

part of '../generators.dart';

abstract class DocsAndAnnotationsGenerator {
  void addAnnotation(HasAnnotationsBuilder builder, Expression annotation) {
    if (annotation != null) {
      builder.annotations.add(annotation);
    }
  }

  void addAnnotations(HasAnnotationsBuilder builder, List<String> annotations) {
    for (final annotation in annotations) {
      addAnnotation(builder, refer(annotation));
    }
  }

  void addComments(HasDartDocsBuilder builder, String comments) {
    if (comments != null) {
      builder.docs.addAll(toDocComments(comments));
    }
  }

  List<String> toDocComments(String comments) {
    if (comments == null) {
      return null;
    }

    // TODO: Split lines by a specific maximum length
    final lines = LineSplitter().convert(comments);
    return lines.map((e) => '/// $e').toList();
  }
}
