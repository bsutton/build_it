part of '../code_combiner.dart';

class CodeCombiner {
  final String Function(String) fileReader;

  CodeCombiner(this.fileReader);

  String combine(String path,
      {FeatureSet? featureSet,
      List<Fragment> Function(CompilationUnit)? postProcess}) {
    featureSet = featureSet ?? FeatureSet.latestLanguageVersion();
    final content = fileReader(path);
    final parseResult = parseString(
        content: content,
        featureSet: featureSet,
        path: path,
        throwIfDiagnostics: false);
    final unit = parseResult.unit;
    final directives = <Directive>[];
    final visitor = DirectiveVisitor(directives);
    unit.accept(visitor);
    final paths = <String>[];
    final fragments = <Fragment>[];
    for (final directive in directives) {
      if (directive is PartDirective) {
        final offset = directive.offset;
        final end = directive.end;
        final fragment = Fragment(offset, end, '');
        fragments.add(fragment);
        final path = directive.uri.stringValue!;
        paths.add(path);
      }
    }

    final chunks = <Chunk>[Chunk(0, content)];
    final textSplitter = TextSplitter();
    final error = textSplitter.split(chunks, fragments);
    if (error != null) {
      _error(error);
    }

    final part = chunks
        .map((e) => e.fragment == null ? e.text : e.fragment!.asString())
        .join();
    final parts = [part];
    for (final path in paths) {
      final content = fileReader(path);
      final parseResult = parseString(
          content: content,
          featureSet: featureSet,
          path: path,
          throwIfDiagnostics: false);
      final unit = parseResult.unit;
      final directives = <Directive>[];
      final directiveVisitor = DirectiveVisitor(directives);
      unit.accept(directiveVisitor);
      final fragments = <Fragment>[];
      for (final directive in directives) {
        if (directive is PartOfDirective) {
          final start = directive.offset;
          final end = directive.end;
          final fragment = Fragment(start, end, '');
          fragments.add(fragment);
        }
      }

      final chunks = <Chunk>[Chunk(0, content)];
      final textSplitter = TextSplitter();
      final error = textSplitter.split(chunks, fragments);
      if (error != null) {
        _error(error);
      }

      final part = chunks
          .map((e) => e.fragment == null ? e.text : e.fragment!.asString())
          .join();
      parts.add(part);
    }

    var result = parts.join('');
    if (postProcess != null) {
      final parseResult = parseString(
          content: result, featureSet: featureSet, throwIfDiagnostics: false);
      final unit = parseResult.unit;
      final fragments = postProcess(unit);
      final chunks = <Chunk>[Chunk(0, result)];
      final textSplitter = TextSplitter();
      final error = textSplitter.split(chunks, fragments);
      if (error != null) {
        _error(error);
      }

      result = chunks
          .map((e) => e.fragment == null ? e.text : e.fragment!.asString())
          .join();
    }

    return result;
  }

  Never _error(TextSplitterError error) {
    final message = 'Text splitting error';
    throw StateError(message);
  }
}
