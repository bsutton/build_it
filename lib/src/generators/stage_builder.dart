// @dart = 2.10

part of '../generators.dart';

class StageBuilder {
  final List<String> _stages = [];

  final bool verbose;

  bool _throws = false;

  StageBuilder({this.verbose = false});

  T build<T>(String stage, T Function() build) {
    if (_throws) {
      throw StateError('The builder has already thrown an exception');
    }

    _stages.add(stage);
    try {
      return build();
    } catch (e) {
      if (!_throws) {
        _throws = true;
        for (final stage in _stages) {
          print(stage);
        }
      }

      rethrow;
    } finally {
      _stages.removeLast();
    }
  }
}
