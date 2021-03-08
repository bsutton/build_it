// @dart = 2.10

part of '../generators.dart';

abstract class LibraryGenerator {
  final classes = <Class>[];

  final directives = <Directive>[];

  void generateExports(StageBuilder builder, List<String> urls) {
    final result = _generateDirective(builder, 'export', urls, (url) {
      return Directive.export(url);
    });

    directives.addAll(result);
  }

  void generateImports(StageBuilder builder, List<String> urls) {
    final result = _generateDirective(builder, 'import', urls, (url) {
      return Directive.import(url);
    });

    directives.addAll(result);
  }

  void generateParts(StageBuilder builder, List<String> urls) {
    final result = _generateDirective(builder, 'part', urls, (url) {
      return Directive.part(url);
    });

    directives.addAll(result);
  }

  String libraryToString(Library library) {
    final emitter = DartEmitter(Allocator.simplePrefixing());
    final result = '${library.accept(emitter)}';
    return result;
  }

  List<Directive> _generateDirective(StageBuilder builder, String name,
      List<String> urls, Directive Function(String) build) {
    return ItemsGenerator(
        stage: 'directive \'$name\'',
        input: urls,
        build: (String url) {
          return build(url);
        }).generate(builder);
  }
}
