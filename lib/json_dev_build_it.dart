// @dart = 2.10

import 'dart:io';

import 'package:analyzer/dart/ast/ast.dart' hide Directive;
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:build_it/build_it_helper.dart';
import 'package:build_it/src/json_generator.dart';
import 'package:build_it/src/json_models.dart';
import 'package:build_it/src/text_splitter.dart';
import 'package:json_helpers/json_helpers.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as _path;

import 'src/code_combiner.dart';

Future<void> main(List<String> args, [message]) async {
  await buildIt(args, message, _build, postBuild: _postBuild);
}

Future<BuildResult> _build(BuildConfig config) async {
  final library = config.data.json((e) => Library.fromJson(e));
  final directives = <Directive>[];
  final generator = JsonGenerator(
      directives: directives,
      input: config.input,
      library: library,
      output: config.output);
  final code = generator.generate();
  return BuildResult(code: code, directives: directives, postBuildData: '');
}

Future<void> _postBuild(PostBuildConfig config) async {
  final input = config.input;
  final basePath = _path.dirname(input);
  String fileReader(String path) {
    path = _path.join(basePath, path);
    final file = File(path);
    if (!file.existsSync()) {
      throw 'Unable to combine library into one file, file not found: $path';
    }

    return file.readAsStringSync();
  }

  List<Fragment> postProcess(CompilationUnit unit) {
    final annotations = <Annotation>[];
    final directives = <ImportDirective>[];
    final visitor = _Visitor(annotations: annotations, directives: directives);
    unit.accept(visitor);
    final fragments = <Fragment>[];
    for (final directive in directives) {
      if (directive.uri.stringValue ==
          'package:json_annotation/json_annotation.dart') {
        final offset = directive.offset;
        final end = directive.end;
        final fragment = Fragment(offset, end, '');
        fragments.add(fragment);
      }
    }

    for (final annotation in annotations) {
      final name = annotation.name;
      switch (name?.name) {
        case 'JsonSerializable':
        case 'JsonKey':
        case 'JsonLiteral':
        case 'JsonValue':
          final offset = annotation.offset;
          final end = annotation.end;
          final fragment = Fragment(offset, end, '');
          fragments.add(fragment);
          break;
      }
    }

    return fragments;
  }

  final combiner = CodeCombiner(fileReader);
  final basename = _path.basename(input);
  final content = combiner.combine(basename, postProcess: postProcess);
  if (content == null) {
    throw StateError('Unable to combine file parts: $input');
  }

  if (content != null) {
    var basename = _path.basenameWithoutExtension(input);
    basename = _path.basenameWithoutExtension(basename);
    final path = _path.join(basePath, basename + '.json_dev.dart');
    final file = File(path);
    file.writeAsStringSync(content);
  } else {
    throw StateError('Unable to remove annotations from file: $input');
  }
}

class _Visitor extends RecursiveAstVisitor {
  final List<Annotation> annotations;

  final List<ImportDirective> directives;

  _Visitor({@required this.annotations, @required this.directives});

  @override
  void visitAnnotation(Annotation node) {
    annotations.add(node);
  }

  @override
  void visitImportDirective(ImportDirective node) {
    directives.add(node);
  }
}
