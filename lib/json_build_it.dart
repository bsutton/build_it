// @dart = 2.10

import 'package:build_it/build_it_helper.dart';
import 'package:build_it/src/json_generator.dart';
import 'package:build_it/src/json_models.dart';
import 'package:json_helpers/json_helpers.dart';

Future<void> main(List<String> args, [message]) async {
  await buildIt(args, message, _build);
}

Future<BuildResult> _build(BuildConfig config) async {
  final root = config.data.json((e) => Root.fromJson(e));
  final directives = <Directive>[];
  final generator = JsonGenerator(
      directives: directives,
      input: config.input,
      output: config.output,
      root: root);
  final code = generator.generate();
  return BuildResult(code: code, directives: directives);
}
