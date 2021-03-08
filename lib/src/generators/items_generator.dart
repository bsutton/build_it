// @dart = 2.10

part of '../generators.dart';

class ItemsGenerator<TIn, TOut> extends Generator<List<TOut>> {
  TOut Function(TIn) build;

  List<TIn> input;

  String stage;

  ItemsGenerator({
    @required this.build,
    @required this.input,
    @required this.stage,
  });

  @override
  List<TOut> generate(StageBuilder builder) {
    final result = <TOut>[];
    if (input == null) {
      return result;
    }

    for (var i = 0; i < input.length; i++) {
      final value = builder.build('$stage #$i', () {
        final element = input[i];
        if (element == null) {
          throw StateError('Element $i must not be null');
        }

        return build(element);
      });

      result.add(value);
    }

    return result;
  }
}
