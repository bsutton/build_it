part of '../code_combiner.dart';

class CodeCombiner {
  final String Function(String) fileReader;

  CodeCombiner(this.fileReader);

  String? combine(String path, {FeatureSet? featureSet}) {
    final content = fileReader(path);
    final parseResult =
        parseString(content: content, path: path, featureSet: featureSet);
    final unit = parseResult.unit;
    final directives = <Directive>[];
    final visitor = DirectiveVisitor(directives);
    unit.accept(visitor);
    final paths = <String>[];
    final fragments = <_Fragment>[];
    for (final directive in directives) {
      if (directive is PartDirective) {
        final offset = directive.offset;
        final end = directive.end;
        final fragment = _Fragment(offset, end, '');
        fragments.add(fragment);
        final path = directive.uri.stringValue!;
        paths.add(path);
      }
    }

    final chunks = <Chunk>[Chunk(0, content)];
    final textSplitter = TextSplitter();
    final error = textSplitter.split(chunks, fragments);
    if (error != null) {
      return null;
    }

    final part = chunks
        .map((e) => e.fragment == null ? e.text : e.fragment!.asString())
        .join();
    final parts = [part];
    for (final path in paths) {
      final content = fileReader(path);
      final parseResult =
          parseString(content: content, path: path, featureSet: featureSet);
      final unit = parseResult.unit;
      final directives = <Directive>[];
      final directiveVisitor = DirectiveVisitor(directives);
      unit.accept(directiveVisitor);
      final fragments = <_Fragment>[];
      for (final directive in directives) {
        if (directive is PartOfDirective) {
          final start = directive.offset;
          final end = directive.end;
          final fragment = _Fragment(start, end, '');
          fragments.add(fragment);
        }
      }

      final chunks = <Chunk>[Chunk(0, content)];
      final textSplitter = TextSplitter();
      final error = textSplitter.split(chunks, fragments);
      if (error != null) {
        return null;
      }

      final part = chunks
          .map((e) => e.fragment == null ? e.text : e.fragment!.asString())
          .join();
      parts.add(part);
    }

    return parts.join('');
  }
}