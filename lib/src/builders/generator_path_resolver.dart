// @dart=2.10

part of '../../builders.dart';

class _GeneratorPathResolverResult {
  final String filepath;

  final String packageUrl;

  _GeneratorPathResolverResult(
      {@required this.filepath, @required this.packageUrl});
}

class _GeneratorPathResolver {
  final List<String> errors;

  final String name;

  Map<String, String> packages;

  _GeneratorPathResolver(
      {@required this.errors, @required this.name, @required this.packages});

  _GeneratorPathResolverResult resolve() {
    final parts = name.trim().split(':');
    if (parts.length > 2 || parts.any((e) => e.contains(' '))) {
      return _addError('Invalid generator name \'$name\'');
    }

    final packageName = parts[0];
    if (packageName.isEmpty) {
      return _addError(
          'The package name must be specified in the generator name $name');
    }

    String generatorAlias;
    if (parts.length > 1) {
      generatorAlias = parts[1];
    } else {
      generatorAlias = packageName;
    }

    if (generatorAlias.isEmpty) {
      return _addError(
          'The generator path must be specified in the generator name');
    }

    if (packageName.isEmpty) {
      return _addError(
          'The generator path must be specified in the generator name');
    }

    if (!packages.containsKey(packageName)) {
      return _addError(
          'Unable to find package \'$packageName\' for generator \'$name\'');
    }

    final packagePath = packages[packageName].trim();
    final generatorUrl = generatorAlias + '_build_it.dart';
    final url = _path.join(packagePath, generatorUrl);
    final isWindows = Platform.isWindows;
    final filepath = Uri.parse(url).toFilePath(windows: isWindows);
    final packageUrl = 'package:$packageName/$generatorUrl';
    return _GeneratorPathResolverResult(
        filepath: filepath, packageUrl: packageUrl);
  }

  _GeneratorPathResolverResult _addError(String error) {
    errors.add(error);
    return _GeneratorPathResolverResult(filepath: '', packageUrl: '');
  }
}
