// @dart=2.10

part of '../../builders.dart';

class _PackagesFileResolver {
  Map<String, String> _packages;

  Map<String, String> resolve() {
    if (_packages != null) {
      return _packages;
    }

    var dirname =
        _path.dirname(Platform.script.toFilePath(windows: Platform.isWindows));
    var found = false;
    var prev = dirname;
    while (true) {
      if (File(_path.join(dirname, '.packages')).existsSync()) {
        found = true;
        break;
      }

      dirname = _path.dirname(dirname);
      if (dirname == prev) {
        break;
      }

      prev = dirname;
    }

    if (!found) {
      throw StateError('Unable to find file: \'.packages\'');
    }

    final content = File(_path.join(dirname, '.packages')).readAsStringSync();
    final lines = LineSplitter().convert(content);
    final result = <String, String>{};
    for (var line in lines) {
      line = line.trim();
      if (line.startsWith('#')) {
        continue;
      }

      final index = line.indexOf(':');
      if (index != -1) {
        final name = line.substring(0, index);
        result[name] = line.substring(index + 1);
      }
    }

    return result;
  }
}
