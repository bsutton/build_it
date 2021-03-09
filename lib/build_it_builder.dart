// @dart=2.10

import 'package:build/build.dart';
import 'package:build_it/build_it_generator.dart';
import 'package:build_it/src/generators.dart';
import 'package:dart_style/dart_style.dart';

/// Build It factory
Builder buildItBuilder(BuilderOptions options) => BuildItBuilder();

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
    final generator = BuildItGenerator(
        input: inputId.path, output: outputId.path, source: contents);
    final builder = StageBuilder();
    var result = generator.generate(builder);
    if (result == null) {
      return;
    }

    final formatter = DartFormatter();
    result = formatter.format(result);
    await buildStep.writeAsString(outputId, result);
  }
}
