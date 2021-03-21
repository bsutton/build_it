// @dart = 2.10

part of '../json_generator.dart';

class JsonGenerator {
  final List<Directive> directives;

  final String input;

  final String output;

  final Root root;

  JsonGenerator(
      {@required this.directives,
      @required this.input,
      @required this.output,
      @required this.root});

  String generate() {
    final specs = <Spec>[];
    final generator = JsonLibraryGenerator(
        directives: directives, element: root, specs: specs);
    generator.generate();
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
    final library = _code_builder.Library((libraryBuilder) {
      libraryBuilder.body.addAll(specs);
    });

    final emitter = DartEmitter(Allocator.simplePrefixing());
    final result = '${library.accept(emitter)}';
    return result;
  }
}
