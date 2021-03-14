// @dart=2.10

part of '../../builders.dart';

/// Build It factory
Builder builder(BuilderOptions options) => BuildItBuilder();

/// Build class, used to build new files from existing ones.
class BuildItBuilder implements Builder {
  @override
  final buildExtensions = const {
    '.yaml': ['.g.dart']
  };

  /// Generates the outputs for a given "build_it" inputs.
  @override
  Future build(BuildStep buildStep) async {
    final outputId = buildStep.inputId.changeExtension('.g.dart');
    final inputId = buildStep.inputId;
    final contents = await buildStep.readAsString(inputId);
    final input = inputId.path;
    final output = outputId.path;
    final executor =
        _BuildGeneratorExecutor(input: input, output: output, source: contents);
    final result = await executor.execute();
    if (result == null) {
      return;
    }

    await buildStep.writeAsString(outputId, result);
  }
}
