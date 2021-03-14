// @dart = 2.10

import 'package:build_it/build_it_models.dart';
import 'package:code_builder/code_builder.dart' hide Directive;
import 'package:meta/meta.dart' hide literal;
import 'package:path/path.dart' as _path;

import 'generators.dart';
import 'json_models/json_models.g.dart';

part 'json_generator/json_object_generator.dart';
part 'json_generator/json_objects_generator.dart';
part 'json_generator/property_generator.dart';

class JsonGenerator {
  final List<Directive> directives;

  final String input;

  final JsonObjects jsonObjects;

  final String output;

  JsonGenerator(
      {@required this.directives,
      @required this.input,
      @required this.jsonObjects,
      @required this.output});

  String generate() {
    final specs = <Spec>[];
    final g = JsonObjectsGenerator(
        directives: directives, jsonObjects: jsonObjects, specs: specs);
    g.generate();
    final fullPath = false;
    final basename = _path.basenameWithoutExtension(output);
    final segments = _path.split(output);
    var path = basename + '.g' + _path.extension(output);
    if (fullPath) {
      segments[segments.length - 1] = basename + '.g' + _path.extension(output);
      path = _path.joinAll(segments);
    }

    final partDirective = Directive(type: 'part', url: path);
    directives.add(partDirective);
    final library = Library((b) {
      b.body.addAll(specs);
    });

    final emitter = DartEmitter(Allocator.simplePrefixing());
    final result = '${library.accept(emitter)}';
    return result;
  }
}
