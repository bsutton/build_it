// @dart = 2.10

import 'dart:convert';
import 'dart:isolate';

import 'package:build_it/build_it_models.dart';
import 'package:build_it/src/json_generator.dart';
import 'package:build_it/src/json_models/json_models.g.dart';

Future<void> main(List<String> args, [response]) async {
  if (response is! SendPort) {
    return;
  }

  if (args.length != 1) {
    throw ArgumentError('Wrong number of arguments');
  }

  final arg = jsonDecode(args[0]) as Map;
  final config = BuildConfig.fromJson(arg.cast());
  final data = jsonDecode(config.data);
  if (data == null) {
    final result = BuildResult(code: '// There is no data\n', directives: []);
    response.send(jsonEncode(result.toJson()));
    return;
  }

  if (data is! Map) {
    throw StateError('Unexpected configuration data type: ${data.runtimeType}');
  }

  final jsonObjects = JsonObjects.fromJson((data as Map).cast());
  final directives = <Directive>[];
  final generator = JsonGenerator(
      directives: directives, output: config.output, jsonObjects: jsonObjects);
  final code = generator.generate();
  final result = BuildResult(code: code, directives: directives);
  response.send(jsonEncode(result.toJson()));
}
