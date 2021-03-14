// @dart = 2.10

part of '../../builders.dart';

final Map<String, List<_PostBuildRequest>> _postBuildRequests = {};

PostProcessBuilder postBuilder(BuilderOptions options) => PostBuilder();

class PostBuilder extends PostProcessBuilder {
  @override
  Iterable<String> get inputExtensions => const ['.g.dart'];

  @override
  FutureOr<void> build(PostProcessBuildStep buildStep) async {
    final inputId = buildStep.inputId;
    final path = inputId.path;
    final requests = _postBuildRequests[path];
    if (requests != null) {
      for (final request in requests) {
        final data = request.data;
        final generatorName = request.generatorName;
        final packageUrl = request.packageUrl;
        final input = inputId.path;
        final executor = _PostBuildGeneratorExecutor(
            data: data,
            input: input,
            generatorName: generatorName,
            packageUrl: packageUrl);
        await executor.execute();
      }
    }
  }
}
