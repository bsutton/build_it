// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_serializable.g.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonObject _$JsonObjectFromJson(Map<String, dynamic> json) {
  return JsonObject(
    annotations: (json['annotations'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    comments: json['comments'] as String?,
    immutable: json['immutable'] as bool?,
    name: json['name'] as String?,
    properties: (json['properties'] as List<dynamic>?)
        ?.map((e) => Property.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$JsonObjectToJson(JsonObject instance) =>
    <String, dynamic>{
      'annotations': instance.annotations,
      'comments': instance.comments,
      'immutable': instance.immutable,
      'name': instance.name,
      'properties': instance.properties,
    };

JsonObjects _$JsonObjectsFromJson(Map<String, dynamic> json) {
  return JsonObjects(
    exports:
        (json['exports'] as List<dynamic>?)?.map((e) => e as String).toList(),
    immutable: json['immutable'] as bool?,
    imports:
        (json['imports'] as List<dynamic>?)?.map((e) => e as String).toList(),
    jsonObjects: (json['jsonObjects'] as List<dynamic>?)
        ?.map((e) => JsonObject.fromJson(e as Map<String, dynamic>))
        .toList(),
    parts: (json['parts'] as List<dynamic>?)?.map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$JsonObjectsToJson(JsonObjects instance) =>
    <String, dynamic>{
      'exports': instance.exports,
      'immutable': instance.immutable,
      'imports': instance.imports,
      'jsonObjects': instance.jsonObjects,
      'parts': instance.parts,
    };

Property _$PropertyFromJson(Map<String, dynamic> json) {
  return Property(
    annotations: (json['annotations'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    comments: json['comments'] as String?,
    name: json['name'] as String?,
    type: json['type'] as String?,
  );
}

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      'annotations': instance.annotations,
      'comments': instance.comments,
      'name': instance.name,
      'type': instance.type,
    };
