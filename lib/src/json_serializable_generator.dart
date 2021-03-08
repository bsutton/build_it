// @dart = 2.10

import 'package:code_builder/code_builder.dart';
import 'package:meta/meta.dart';

import 'generators.dart';
import 'specifications/json_serializable.g.dart';

part 'json_serializable_generator/json_object_generator.dart';
part 'json_serializable_generator/json_objects_generator.dart';
part 'json_serializable_generator/property_generator.dart';

class JsonSerializableGenerator extends Generator<void> {
  final List<Spec> declarations;

  final Map<String, dynamic> json;

  JsonSerializableGenerator({@required this.declarations, @required this.json});

  @override
  void generate(StageBuilder builder) {
    return builder.build('JsonSerializable', () {
      final jsonObjects = JsonObjects.fromJson(json);
      final generator = JsonObjectsGenerator(
          declarations: declarations, jsonObjects: jsonObjects);
      return generator.generate(builder);
    });
  }
}
