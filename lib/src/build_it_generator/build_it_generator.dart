// @dart = 2.10

part of '../../build_it_generator.dart';

class BuildItGenerator {
  final String input;

  final String output;

  final String source;

  BuildItGenerator(
      {@required this.input, @required this.output, @required this.source});

  Future<String> generate() async {
    final yamlDocuments = _yaml.loadYamlDocuments(source);
    if (yamlDocuments.length % 2 != 0) {
      return null;
    }

    final generatorName = _getGeneratorName(yamlDocuments[0].contents.value);
    if (generatorName == null) {
      return null;
    }

    String dartVersion;
    final code = <String>[];
    final directives = <Directive>[];
    final packages = _getPackages();
    for (var i = 0; i < yamlDocuments.length; i += 2) {
      final context = _Context();
      context.index = i;
      final metadata = yamlDocuments[i].contents.value;
      final generatorName = _getGeneratorName(metadata);
      if (generatorName == null) {
        _error('Unable to determine generator name', context);
      }

      context.generatorName = generatorName;
      final parts = generatorName.trim().split(':');
      if (parts.length > 2 || parts.any((e) => e.contains(' '))) {
        _error('Invalid generator name \'$generatorName\'', context);
      }

      final packageName = parts[0];
      if (packageName.isEmpty) {
        _error(
            'The package name must be specified in the generator name $generatorName',
            context);
      }

      String generatorAlias;
      if (parts.length > 1) {
        generatorAlias = parts[1];
      } else {
        generatorAlias = packageName;
      }

      if (generatorAlias.isEmpty) {
        _error('The generator path must be specified in the generator name',
            context);
      }

      if (packageName.isEmpty) {
        _error('The generator path must be specified in the generator name',
            context);
      }

      if (!packages.containsKey(packageName)) {
        _error(
            'Unable to find package \'$packageName\' for generator \'$generatorName\'',
            context);
      }

      final version = _getLanguageVersion(metadata);
      if (version != null) {
        if (dartVersion == null) {
          dartVersion = version;
        } else {
          if (dartVersion != version) {
            _error(
                'Language versions conflict between \'$dartVersion\' and \'$version\'',
                context);
          }
        }
      }

      final packagePath = packages[packageName].trim();
      final generatorUrl = generatorAlias + '_build_it.dart';
      var filepath = _path.join(packagePath, generatorUrl);
      final isWindows = Platform.isWindows;
      filepath = Uri.parse(filepath).toFilePath(windows: isWindows);
      final file = File(filepath);
      if (!file.existsSync()) {
        _error('Unable to find the generator file \'$generatorUrl\'', context);
      }

      final packageUrl = 'package:$packageName/$generatorUrl';
      context.packageUrl = packageUrl;
      final config = BuildConfig(
          data: jsonEncode(yamlDocuments[i + 1].contents.value),
          index: i,
          input: input,
          metadata: jsonEncode(metadata),
          output: output);
      final args = [jsonEncode(config.toJson())];
      BuildResult result;
      final response = await _spawn(Uri.parse(packageUrl), args, context);
      if (response is String) {
        final json = jsonDecode(response);
        if (json is Map) {
          result = BuildResult.fromJson(json.cast());
        }
      }

      if (result == null) {
        _error(
            'Invalid result received from generator (${response.runtimeType})',
            context);
      }

      if (result.error != null) {
        _error('Generator returned an eroor: ${result.error}', context);
      }

      code.add(
          '// **************************************************************************\n');
      code.add('// build_it: $generatorName\n');
      code.add(
          '// **************************************************************************\n\n');

      if (result.code != null) {
        code.add(result.code);
      }

      if (result.directives != null) {
        final directiveTypes = const {'export', 'import', 'part', 'part of'};
        final badDirectives =
            directives.where((e) => !directiveTypes.contains(e.type));
        if (badDirectives.isNotEmpty) {
          _error('Unsupported directive \'${badDirectives.first}\'', context);
        }

        directives.addAll(result.directives);
      }
    }

    final prologue = ['// GENERATED CODE - DO NOT MODIFY BY HAND\n\n'];

    if (dartVersion != null) {
      prologue.add('// @dart = $dartVersion\n\n');
    }

    _addDirectives(prologue, directives, 'import');
    _addDirectives(prologue, directives, 'export');
    _addDirectives(prologue, directives, 'part');
    _addDirectives(prologue, directives, 'part of');

    code.insertAll(0, prologue);
    var result = code.join();
    final formatter = DartFormatter();
    result = formatter.format(result);
    return result;
  }

  void _addDirectives(
      List<String> code, List<Directive> directives, String type) {
    if (directives.isEmpty) {
      return;
    }

    final filtered = directives.where((e) => e.type == type);
    final hashSet =
        HashSet<Directive>(equals: (x, y) => x.equalsTo(y), hashCode: (e) => 0);
    hashSet.addAll(filtered);
    final result = <String>[];
    result.addAll(hashSet.map((e) => e.asString() + ';\n'));
    result.sort();
    code.add(result.join(''));
    if (hashSet.isNotEmpty) {
      code.add('\n');
    }
  }

  @alwaysThrows
  void _error(String message, _Context context) {
    message = _getErrorMessage(message, context);
    throw StateError(message);
  }

  String _getErrorMessage(String message, context) {
    final sb = StringBuffer();
    sb.writeln('The \'build_it\' process error');
    sb.writeln(message);
    if (context.generatorName != null) {
      sb.write('Generator: ');
      sb.write(context.generatorName);
      if (context.packageUrl != null) {
        sb.write(' (');
        sb.write(context.packageUrl);
        sb.write(')');
      }

      sb.writeln();
    }

    sb.write('Input: ');
    sb.writeln(input);
    return sb.toString();
  }

  String _getGeneratorName(object) {
    return _readValue(object, 'format:generator:name');
  }

  String _getLanguageVersion(object) {
    return _readValue(object, 'format:language:version');
  }

  Map<String, String> _getPackages() {
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

  T _readValue<T>(object, String path) {
    final parts = path.split(':');
    for (var i = 0; i < parts.length; i++) {
      final key = parts[i];
      if (object is Map) {
        final value = object[key];
        if (i == parts.length - 1) {
          if (value is T) {
            return value;
          }
        } else {
          object = value;
        }
      } else {
        break;
      }
    }

    return null;
  }

  Future _spawn(Uri url, List<String> args, _Context context) async {
    final exitPort = ReceivePort();
    final errorPort = ReceivePort();
    final responsePort = ReceivePort();
    var hasError = false;
    var resultCount = 0;
    var result;

    void cloaseAllPorts() {
      errorPort.close();
      exitPort.close();
      responsePort.close();
    }

    final completer = Completer();
    exitPort.listen((message) {
      cloaseAllPorts();
      if (!hasError) {
        if (resultCount == 0) {
          final message = _getErrorMessage(
              'The generator did not return a result.', context);
          stderr.writeln(message);
          completer.complete();
        } else if (resultCount == 1) {
          completer.complete(result);
        } else {
          final message = _getErrorMessage(
              'The generator returned the result $resultCount times, the results were rejected',
              context);
          stderr.writeln(message);
          completer.complete();
        }
      } else {
        completer.complete();
      }
    });

    errorPort.listen((messages) {
      final message = _getErrorMessage(
          'An exception was thrown during generator execution', context);
      stderr.writeln(message);
      if (messages is List) {
        for (final message in messages) {
          stderr.writeln(message);
        }
      } else {
        stderr.writeln(messages);
      }

      hasError = true;
    });

    responsePort.listen((message) {
      if (resultCount++ == 0) {
        result = message;
      }
    });

    try {
      await Isolate.spawnUri(url, args, responsePort.sendPort,
          onError: errorPort.sendPort, onExit: exitPort.sendPort);
    } catch (e) {
      cloaseAllPorts();
      completer.complete();
      final message = _getErrorMessage(
          'An exception was thrown during generator execution', context);
      stderr.writeln(message);
      rethrow;
    }

    return completer.future;
  }
}

class _Context {
  int index;

  String generatorName;

  String packageUrl;
}
