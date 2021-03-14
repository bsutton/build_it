import 'dart:convert';
import 'dart:isolate';

import 'package:build_it/build_it_models.dart';
import 'package:build_it/json_helper.dart';

export 'build_it_models.dart';

Future<void> buildIt(
    List<String> args, message, Future<BuildResult> Function(BuildConfig) build,
    {Future<void> Function(PostBuildConfig)? postBuild}) async {
  if (args.length != 2) {
    throw ArgumentError('Wrong number of arguments: ${args.length}');
  }

  late SendPort response;
  if (message is SendPort) {
    response = message;
  } else {
    throw ArgumentError(
        'Invalid type of the second argument: ${message.runtimeType}');
  }

  T decodeConfig<T>(arg, T Function(Map<String, dynamic>) fromJson) {
    if (arg is String) {
      return arg.decodeJson(fromJson);
    } else {
      _errorInvalidArgument();
    }
  }

  final buildStep = args[0];
  final configArgument = args[1];
  switch (buildStep) {
    case 'build':
      final config =
          decodeConfig(configArgument, (e) => BuildConfig.fromJson(e));
      final buildResult = await build(config);
      final json = buildResult.toJson();
      final result = jsonEncode(json);
      response.send(result);
      break;
    case 'postBuild':
      if (postBuild != null) {
        final config =
            decodeConfig(configArgument, (e) => PostBuildConfig.fromJson(e));
        await postBuild(config);
      }

      response.send(null);
      break;
    default:
  }
}

Never _errorInvalidArgument() {
  throw ArgumentError('Invalid argument: \'args\'');
}
