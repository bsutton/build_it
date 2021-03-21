// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_models.g.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Class _$ClassFromJson(Map<String, dynamic> json) {
  $checkKeys(json, allowedKeys: const [
    'annotations',
    'comments',
    'fields',
    'immutable',
    'jsonSerializable',
    'name'
  ]);
  return Class(
    annotations: (json['annotations'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    comments: json['comments'] as String?,
    fields: (json['fields'] as List<dynamic>?)
            ?.map((e) => Field.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    immutable: json['immutable'] as bool?,
    jsonSerializable: json['jsonSerializable'] == null
        ? null
        : JsonSerializableAnnotation.fromJson(
            json['jsonSerializable'] as Map<String, dynamic>),
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$ClassToJson(Class instance) => <String, dynamic>{
      'annotations': instance.annotations,
      'comments': instance.comments,
      'fields': instance.fields,
      'immutable': instance.immutable,
      'jsonSerializable': instance.jsonSerializable,
      'name': instance.name,
    };

Enum _$EnumFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      allowedKeys: const ['annotations', 'comments', 'name', 'values']);
  return Enum(
    annotations: (json['annotations'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    comments: json['comments'] as String?,
    name: json['name'] as String?,
    values: (json['values'] as List<dynamic>?)
            ?.map((e) => EnumValue.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}

Map<String, dynamic> _$EnumToJson(Enum instance) => <String, dynamic>{
      'annotations': instance.annotations,
      'comments': instance.comments,
      'name': instance.name,
      'values': instance.values,
    };

EnumValue _$EnumValueFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      allowedKeys: const ['annotations', 'comments', 'jsonValue', 'name']);
  return EnumValue(
    annotations: (json['annotations'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    comments: json['comments'] as String?,
    jsonValue: json['jsonValue'] == null
        ? null
        : JsonValueAnnotation.fromJson(
            json['jsonValue'] as Map<String, dynamic>),
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$EnumValueToJson(EnumValue instance) => <String, dynamic>{
      'annotations': instance.annotations,
      'comments': instance.comments,
      'jsonValue': instance.jsonValue,
      'name': instance.name,
    };

Field _$FieldFromJson(Map<String, dynamic> json) {
  $checkKeys(json, allowedKeys: const [
    'annotations',
    'comments',
    'jsonKey',
    'name',
    'type'
  ]);
  return Field(
    annotations: (json['annotations'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList() ??
        [],
    comments: json['comments'] as String?,
    jsonKey: json['jsonKey'] == null
        ? null
        : JsonKeyAnnotation.fromJson(json['jsonKey'] as Map<String, dynamic>),
    name: json['name'] as String?,
    type: json['type'] as String?,
  );
}

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'annotations': instance.annotations,
      'comments': instance.comments,
      'jsonKey': instance.jsonKey,
      'name': instance.name,
      'type': instance.type,
    };

JsonKeyAnnotation _$JsonKeyAnnotationFromJson(Map<String, dynamic> json) {
  $checkKeys(json, allowedKeys: const [
    'defaultValue',
    'disallowNullValue',
    'fromJson',
    'ignore',
    'includeIfNull',
    'name',
    'required',
    'toJson',
    'unknownEnumValue'
  ]);
  return JsonKeyAnnotation(
    defaultValue: json['defaultValue'],
    disallowNullValue: json['disallowNullValue'] as bool?,
    fromJson$: json['fromJson'] as String?,
    ignore: json['ignore'] as bool?,
    includeIfNull: json['includeIfNull'] as bool?,
    name: json['name'] as String?,
    required: json['required'] as bool?,
    toJson$: json['toJson'] as String?,
    unknownEnumValue: json['unknownEnumValue'],
  );
}

Map<String, dynamic> _$JsonKeyAnnotationToJson(JsonKeyAnnotation instance) =>
    <String, dynamic>{
      'defaultValue': instance.defaultValue,
      'disallowNullValue': instance.disallowNullValue,
      'fromJson': instance.fromJson$,
      'ignore': instance.ignore,
      'includeIfNull': instance.includeIfNull,
      'name': instance.name,
      'required': instance.required,
      'toJson': instance.toJson$,
      'unknownEnumValue': instance.unknownEnumValue,
    };

JsonSerializableAnnotation _$JsonSerializableAnnotationFromJson(
    Map<String, dynamic> json) {
  $checkKeys(json, allowedKeys: const [
    'anyMap',
    'checked',
    'createFactory',
    'createToJson',
    'disallowUnrecognizedKeys',
    'explicitToJson',
    'fieldRename',
    'genericArgumentFactories',
    'ignoreUnannotated',
    'includeIfNull'
  ]);
  return JsonSerializableAnnotation(
    anyMap: json['anyMap'] as bool?,
    checked: json['checked'] as bool?,
    createFactory: json['createFactory'] as bool?,
    createToJson: json['createToJson'] as bool?,
    disallowUnrecognizedKeys: json['disallowUnrecognizedKeys'] as bool?,
    explicitToJson: json['explicitToJson'] as bool?,
    fieldRename: json['fieldRename'] as String?,
    genericArgumentFactories: json['genericArgumentFactories'] as bool?,
    ignoreUnannotated: json['ignoreUnannotated'] as bool?,
    includeIfNull: json['includeIfNull'] as bool?,
  );
}

Map<String, dynamic> _$JsonSerializableAnnotationToJson(
        JsonSerializableAnnotation instance) =>
    <String, dynamic>{
      'anyMap': instance.anyMap,
      'checked': instance.checked,
      'createFactory': instance.createFactory,
      'createToJson': instance.createToJson,
      'disallowUnrecognizedKeys': instance.disallowUnrecognizedKeys,
      'explicitToJson': instance.explicitToJson,
      'fieldRename': instance.fieldRename,
      'genericArgumentFactories': instance.genericArgumentFactories,
      'ignoreUnannotated': instance.ignoreUnannotated,
      'includeIfNull': instance.includeIfNull,
    };

JsonValueAnnotation _$JsonValueAnnotationFromJson(Map<String, dynamic> json) {
  $checkKeys(json, allowedKeys: const ['value']);
  return JsonValueAnnotation(
    value: json['value'] as Object,
  );
}

Map<String, dynamic> _$JsonValueAnnotationToJson(
        JsonValueAnnotation instance) =>
    <String, dynamic>{
      'value': instance.value,
    };

Library _$LibraryFromJson(Map<String, dynamic> json) {
  $checkKeys(json, allowedKeys: const [
    'checkNullSafety',
    'classes',
    'code',
    'enums',
    'exports',
    'immutable',
    'imports',
    'jsonSerializable',
    'parts'
  ]);
  return Library(
    checkNullSafety: json['checkNullSafety'] as bool?,
    classes: (json['classes'] as List<dynamic>?)
            ?.map((e) => Class.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    code: json['code'] as String?,
    enums: (json['enums'] as List<dynamic>?)
            ?.map((e) => Enum.fromJson(e as Map<String, dynamic>))
            .toList() ??
        [],
    exports:
        (json['exports'] as List<dynamic>?)?.map((e) => e as String).toList() ??
            [],
    immutable: json['immutable'] as bool?,
    imports:
        (json['imports'] as List<dynamic>?)?.map((e) => e as String).toList() ??
            [],
    jsonSerializable: json['jsonSerializable'] == null
        ? null
        : JsonSerializableAnnotation.fromJson(
            json['jsonSerializable'] as Map<String, dynamic>),
    parts:
        (json['parts'] as List<dynamic>?)?.map((e) => e as String).toList() ??
            [],
  );
}

Map<String, dynamic> _$LibraryToJson(Library instance) => <String, dynamic>{
      'checkNullSafety': instance.checkNullSafety,
      'classes': instance.classes,
      'code': instance.code,
      'enums': instance.enums,
      'exports': instance.exports,
      'immutable': instance.immutable,
      'imports': instance.imports,
      'jsonSerializable': instance.jsonSerializable,
      'parts': instance.parts,
    };
