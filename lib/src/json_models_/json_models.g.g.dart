// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_models.g.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonClass _$JsonObjectFromJson(Map<String, dynamic> json) {
  return JsonClass(
    annotations: (json['annotations'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    comments: json['comments'] as String?,
    immutable: json['immutable'] as bool?,
    name: json['name'] as String?,
    fields: (json['fields'] as List<dynamic>?)
            ?.map((e) => JsonField.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$JsonObjectToJson(JsonClass instance) =>
    <String, dynamic>{
      'annotations': instance.annotations,
      'comments': instance.comments,
      'immutable': instance.immutable,
      'name': instance.name,
      'fields': instance.fields,
    };

JsonLibrary _$JsonObjectsFromJson(Map<String, dynamic> json) {
  return JsonLibrary(
    checkNullSafety: json['checkNullSafety'] as bool?,
    exports:
        (json['exports'] as List<dynamic>?)?.map((e) => e as String).toList() ??
            [],
    immutable: json['immutable'] as bool?,
    imports:
        (json['imports'] as List<dynamic>?)?.map((e) => e as String).toList() ??
            [],
    classes: (json['classes'] as List<dynamic>?)
            ?.map((e) => JsonClass.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    parts:
        (json['parts'] as List<dynamic>?)?.map((e) => e as String).toList() ??
            [],
  );
}

Map<String, dynamic> _$JsonObjectsToJson(JsonLibrary instance) =>
    <String, dynamic>{
      'checkNullSafety': instance.checkNullSafety,
      'exports': instance.exports,
      'immutable': instance.immutable,
      'imports': instance.imports,
      'classes': instance.classes,
      'parts': instance.parts,
    };

JsonField _$PropertyFromJson(Map<String, dynamic> json) {
  return JsonField(
    annotations: (json['annotations'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    comments: json['comments'] as String?,
    defaultValue: json['defaultValue'],
    key: json['key'] as String?,
    name: json['name'] as String?,
    type: json['type'] as String?,
  );
}

Map<String, dynamic> _$PropertyToJson(JsonField instance) => <String, dynamic>{
      'annotations': instance.annotations,
      'comments': instance.comments,
      'defaultValue': instance.defaultValue,
      'key': instance.key,
      'name': instance.name,
      'type': instance.type,
    };
