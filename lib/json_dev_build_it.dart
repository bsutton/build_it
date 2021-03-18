// @dart = 2.10

import 'dart:io';

import 'package:build_it/build_it_helper.dart';
import 'package:build_it/src/json_generator.dart';
import 'package:build_it/src/json_models/json_models.g.dart';
import 'package:json_helpers/json_helpers.dart';
import 'package:path/path.dart' as _path;

import 'src/code_combiner.dart';

Future<void> main(List<String> args, [message]) async {
  await buildIt(args, message, _build, postBuild: _postBuild);
}

Future<BuildResult> _build(BuildConfig config) async {
  final library = config.data.json((e) => Library.fromJson(e));
  final directives = <Directive>[];
  final g = JsonGenerator(
      directives: directives,
      input: config.input,
      library: library,
      output: config.output);
  final code = g.generate();
  return BuildResult(code: code, directives: directives, postBuildData: '');
}

Future<void> _postBuild(PostBuildConfig config) async {
  return;
  final input = config.input;
  final basePath = _path.dirname(input);
  String fileReader(String path) {
    path = _path.join(basePath, path);
    final file = File(path);
    if (!file.existsSync()) {
      throw 'File not found: $path';
    }

    return file.readAsStringSync();
  }

  final combiner = CodeCombiner(fileReader);
  final result = combiner.combine(_path.basename(input));
  if (result != null) {
    var basename = _path.basenameWithoutExtension(input);
    basename = _path.basenameWithoutExtension(basename);
    final path = _path.join(basePath, basename + '.combined.dart');
    final file = File(path);
    file.writeAsStringSync(result);
  } else {
    // TODO:
    throw 'Error';
  }
}
