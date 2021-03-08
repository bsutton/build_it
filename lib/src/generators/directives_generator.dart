// @dart = 2.10

part of '../generators.dart';

abstract class DirectivesGenerator {
  void addDirectives(
      List<Spec> declarations, DirectiveType type, List<String> urls) {
    if (urls == null) {
      return;
    }

    for (final url in urls) {
      Directive directive;
      switch (type) {
        case DirectiveType.export:
          directive = Directive.import(url);
          break;
        case DirectiveType.import:
          directive = Directive.import(url);
          break;
        case DirectiveType.part:
          directive = Directive.import(url);
          break;
      }

      declarations.add(directive);
    }
  }
}
