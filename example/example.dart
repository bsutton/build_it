import 'dart:convert';
import 'dart:isolate';

import 'package:build_it/build_it_models.dart';

Future<void> main(List<String> args, [response]) async {
  if (response is! SendPort) {
    return;
  }

  if (args.length != 1) {
    throw ArgumentError('Wrong number of arguments');
  }

  final arg = jsonDecode(args[0]) as Map;
  final config = BuildConfig.fromJson(arg.cast());
  final data = jsonDecode(config.data);
  if (data == null) {
    final result = BuildResult(code: '// There is no data\n');
    response.send(jsonEncode(result.toJson()));
    return;
  }

  if (data is! Map) {
    throw StateError('Unexpected configuration data type: ${data.runtimeType}');
  }

  final name = data['name'] as String;
  final code = <String>[];
  final template = _template.replaceAll('{{NAME}}', name);
  code.add(template);

  final directives = <Directive>[];
  directives.add(Directive(type: 'import', url: 'dart:io'));

  final result = BuildResult(code: code.join('\n'), directives: directives);
  response.send(jsonEncode(result.toJson()));
}

const _template = '''
void main() {
  stdout.writeln('Hello, {{NAME}}');
}
''';
