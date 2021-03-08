// @dart=2.10

import 'package:build/build.dart';
import 'package:build_it/build_it_generator.dart';
import 'package:build_it/src/generators.dart';
import 'package:dart_style/dart_style.dart';

Builder buildItBuilder(BuilderOptions options) => BuildItBuilder();

class BuildItBuilder implements Builder {
  @override
  final buildExtensions = const {
    '.yaml': ['.g.dart']
  };

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
