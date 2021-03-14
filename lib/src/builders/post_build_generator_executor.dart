// @dart=2.10

part of '../../builders.dart';

class _PostBuildGeneratorExecutor extends _GeneratorExecutor {
  final String data;

  final String generatorName;

  final String packageUrl;

  _PostBuildGeneratorExecutor(
      {@required this.data,
      @required this.generatorName,
      @required String input,
      @required this.packageUrl})
      : super(input: input);

  Future<void> execute() async {
    final errors = <String>[];
    final context = _Context();
    context.generatorName = generatorName;
    context.packageUrl = packageUrl;
    final config = PostBuildConfig(data: data, input: input);
    final args = <String>[];
    args.add('postBuild');
    args.add(jsonEncode(config.toJson()));
    await spawn(Uri.parse(packageUrl), args, errors);
    if (errors.isNotEmpty) {
      error(errors.first, context);
    }
  }
}
