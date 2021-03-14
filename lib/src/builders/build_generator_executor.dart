// @dart=2.10

part of '../../builders.dart';

class _BuildGeneratorExecutor extends _GeneratorExecutor {
  final String output;

  final String source;

  _BuildGeneratorExecutor(
      {@required String input, @required this.output, @required this.source})
      : super(input: input);

  Future<String> execute() async {
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
    var directives = <Directive>[];
    final packages = _getPackages();
    final errors = <String>[];
    for (var i = 0; i < yamlDocuments.length; i += 2) {
      final context = _Context();
      context.index = i;
      final metadata = yamlDocuments[i].contents.value;
      final generatorName = _getGeneratorName(metadata);
      if (generatorName == null) {
        error('Unable to determine generator name', context);
      }

      context.generatorName = generatorName;
      final pathResolver = _GeneratorPathResolver(
          name: generatorName, packages: packages, errors: errors);
      final generatorPath = pathResolver.resolve();
      if (errors.isNotEmpty) {
        error(errors.first, context);
      }

      final filepath = generatorPath.filepath;
      final file = File(filepath);
      if (!file.existsSync()) {
        error('Unable to find the generator file \'$filepath\'', context);
      }

      final version = _getLanguageVersion(metadata);
      if (version != null) {
        if (dartVersion == null) {
          dartVersion = version;
        } else {
          if (dartVersion != version) {
            error(
                'Language versions conflict between \'$dartVersion\' and \'$version\'',
                context);
          }
        }
      }

      final packageUrl = generatorPath.packageUrl;
      context.packageUrl = packageUrl;
      final config = BuildConfig(
          data: jsonEncode(yamlDocuments[i + 1].contents.value),
          index: i,
          input: input,
          metadata: jsonEncode(metadata),
          output: output);
      final args = <String>[];
      args.add('build');
      args.add(jsonEncode(config.toJson()));
      BuildResult result;
      final response = await spawn(Uri.parse(packageUrl), args, errors);
      if (response is String) {
        final json = jsonDecode(response);
        if (json is Map) {
          result = BuildResult.fromJson(json.cast());
        }
      }

      if (errors.isNotEmpty) {
        final message = errors.first;
        errors.clear();
        error(message, context);
      }

      if (result == null) {
        error(
            'Invalid result received from generator (${response.runtimeType})',
            context);
      }

      if (result.error != null) {
        error('Generator returned an eroor: ${result.error}', context);
      }

      code.add(
          '// **************************************************************************\n');
      code.add('// build_it: $generatorName\n');
      code.add(
          '// **************************************************************************\n\n');

      if (true) {
        code.add('// @build_it : combine_into_single_file\n');
      }

      if (result.code != null) {
        code.add(result.code);
      }

      final invalid = result.directives.invalid();
      if (invalid.isNotEmpty) {
        error('Invalid directive \'${invalid.first.asString()}\'', context);
      }

      directives.addAll(result.directives);

      if (result.postBuildData != null) {
        var requests = _postBuildRequests[output];
        if (requests == null) {
          requests = [];
          _postBuildRequests[output] = requests;
        }

        final data = result.postBuildData;
        final request = _PostBuildRequest(
            data: data, generatorName: generatorName, packageUrl: packageUrl);
        requests.add(request);
      }
    }

    final prologue = ['// GENERATED CODE - DO NOT MODIFY BY HAND\n'];

    if (dartVersion != null) {
      prologue.add('// @dart = $dartVersion\n');
    }

    prologue.add('\n');

    directives = directives.unique();
    prologue.addAll(directives.organize());
    code.insertAll(0, prologue);
    var result = code.join();
    final formatter = DartFormatter();
    result = formatter.format(result);
    return result;
  }

  String _getGeneratorName(object) {
    return _readValue(object, 'format:generator:name');
  }

  String _getLanguageVersion(object) {
    return _readValue(object, 'format:language:version');
  }

  Map<String, String> _getPackages() {
    final resolver = _PackagesFileResolver();
    return resolver.resolve();
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
}

class _Context {
  int index;

  String generatorName;

  String packageUrl;
}
