import 'package:build_it/build_it_helper.dart';
import 'package:json_helpers/json_helpers.dart';

Future<void> main(List<String> args, [message]) async {
  return await buildIt(args, message, _build);
}

Future<BuildResult> _build(BuildConfig config) async {
  const _template = '''
void main() {
  stdout.writeln('Hello, {{NAME}}');
}
''';

  final data = config.data.json((e) => Data.fromMap(e));
  final name = data.name;
  final code = <String>[];
  final template = _template.replaceAll('{{NAME}}', name);
  code.add(template);
  final directives = <Directive>[];
  directives.add(Directive(type: 'import', url: 'dart:io'));
  return BuildResult(code: code.join('\n'), directives: directives);
}

class Data {
  final String name;

  Data({required this.name});

  factory Data.fromMap(Map<String, dynamic> json) {
    return Data(name: (json['name'] as String?) ?? '');
  }
}
