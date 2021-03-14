// @dart = 2.10

import 'package:build_it/build_it_helper.dart';
import 'package:build_it/src/json_generator.dart';
import 'package:build_it/src/json_models/json_models.g.dart';

import 'json_helper.dart';

Future<void> main(List<String> args, [message]) async {
  await buildIt(args, message, _build);
}

Future<BuildResult> _build(BuildConfig config) async {
  final jsonObjects = config.data.decodeJson((e) => JsonObjects.fromJson(e));
  final directives = <Directive>[];
  final g = JsonGenerator(
      directives: directives,
      input: config.input,
      jsonObjects: jsonObjects,
      output: config.output);
  final code = g.generate();
  return BuildResult(code: code, directives: directives);
}
