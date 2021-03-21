// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';


// **************************************************************************
// build_it: build_it:json_dev
// **************************************************************************

/// Class is used to describe the JSON class
class Class {
  Class(
      {required this.annotations,
      this.comments,
      required this.fields,
      this.immutable,
      this.jsonSerializable,
      this.name});

  /// Creates an instance of 'Class' from a JSON representation
  factory Class.fromJson(Map<String, dynamic> json) => _$ClassFromJson(json);

  /// Metadata describing the JSON class
    List<String> annotations;

  /// Documenting comments for JSON class
  String? comments;

  /// List of JSON fields
    List<Field> fields;

  /// Indicates the immutability of class fields
  bool? immutable;

  /// Represents annotation JsonSerializable
  JsonSerializableAnnotation? jsonSerializable;

  /// JSON class name
  String? name;

  /// Returns a JSON representation of the 'Class' instance.
  Map<String, dynamic> toJson() => _$ClassToJson(this);
}

/// Enum is used to describe the JSON enum
class Enum {
  Enum(
      {required this.annotations,
      this.comments,
      this.name,
      required this.values});

  /// Creates an instance of 'Enum' from a JSON representation
  factory Enum.fromJson(Map<String, dynamic> json) => _$EnumFromJson(json);

  /// Metadata describing the JSON enum
    List<String> annotations;

  /// Documenting comments for JSON enum
  String? comments;

  /// JSON enum name
  String? name;

  /// List of enumeration values
    List<EnumValue> values;

  /// Returns a JSON representation of the 'Enum' instance.
  Map<String, dynamic> toJson() => _$EnumToJson(this);
}

/// Enum value is used to describe the JSON enum value
class EnumValue {
  EnumValue(
      {required this.annotations,
      this.comments,
      this.jsonValue,
      required this.name});

  /// Creates an instance of 'EnumValue' from a JSON representation
  factory EnumValue.fromJson(Map<String, dynamic> json) =>
      _$EnumValueFromJson(json);

  /// Metadata describing the JSON enum value
    List<String> annotations;

  /// Documenting comments for JSON enum value
  String? comments;

  /// Represents annotation JsonValue
  JsonValueAnnotation? jsonValue;

  /// Enumeration value name
  String name;

  /// Returns a JSON representation of the 'EnumValue' instance.
  Map<String, dynamic> toJson() => _$EnumValueToJson(this);
}

/// Field is used to describe the JSON class field
class Field {
  Field(
      {required this.annotations,
      this.comments,
      this.jsonKey,
      this.name,
      this.type});

  /// Creates an instance of 'Field' from a JSON representation
  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  /// Metadata describing the JSON class field
    List<String> annotations;

  /// Documenting comments for JSON class field
  String? comments;

  /// Represents annotation JsonKey
  JsonKeyAnnotation? jsonKey;

  /// JSON class field name
  String? name;

  /// JSON class field type
  String? type;

  /// Returns a JSON representation of the 'Field' instance.
  Map<String, dynamic> toJson() => _$FieldToJson(this);
}

/// Represents annotation JsonKey
class JsonKeyAnnotation {
  JsonKeyAnnotation(
      {this.defaultValue,
      this.disallowNullValue,
      this.fromJson$,
      this.ignore,
      this.includeIfNull,
      this.name,
      this.required,
      this.toJson$,
      this.unknownEnumValue});

  /// Creates an instance of 'JsonKeyAnnotation' from a JSON representation
  factory JsonKeyAnnotation.fromJson(Map<String, dynamic> json) =>
      _$JsonKeyAnnotationFromJson(json);

  Object? defaultValue;

  bool? disallowNullValue;

    String? fromJson$;

  bool? ignore;

  bool? includeIfNull;

  String? name;

  bool? required;

    String? toJson$;

  Object? unknownEnumValue;

  /// Returns a JSON representation of the 'JsonKeyAnnotation' instance.
  Map<String, dynamic> toJson() => _$JsonKeyAnnotationToJson(this);
}

/// Represents annotation JsonSerializable
class JsonSerializableAnnotation {
  JsonSerializableAnnotation(
      {this.anyMap,
      this.checked,
      this.createFactory,
      this.createToJson,
      this.disallowUnrecognizedKeys,
      this.explicitToJson,
      this.fieldRename,
      this.genericArgumentFactories,
      this.ignoreUnannotated,
      this.includeIfNull});

  /// Creates an instance of 'JsonSerializableAnnotation' from a JSON representation
  factory JsonSerializableAnnotation.fromJson(Map<String, dynamic> json) =>
      _$JsonSerializableAnnotationFromJson(json);

  bool? anyMap;

  bool? checked;

  bool? createFactory;

  bool? createToJson;

  bool? disallowUnrecognizedKeys;

  bool? explicitToJson;

  String? fieldRename;

  bool? genericArgumentFactories;

  bool? ignoreUnannotated;

  bool? includeIfNull;

  /// Returns a JSON representation of the 'JsonSerializableAnnotation' instance.
  Map<String, dynamic> toJson() => _$JsonSerializableAnnotationToJson(this);
}

/// Represents annotation JsonValue
class JsonValueAnnotation {
  JsonValueAnnotation({required this.value});

  /// Creates an instance of 'JsonValueAnnotation' from a JSON representation
  factory JsonValueAnnotation.fromJson(Map<String, dynamic> json) =>
      _$JsonValueAnnotationFromJson(json);

  Object value;

  /// Returns a JSON representation of the 'JsonValueAnnotation' instance.
  Map<String, dynamic> toJson() => _$JsonValueAnnotationToJson(this);
}

/// Library is used to describe the JSON library
class Library {
  Library(
      {this.checkNullSafety,
      required this.classes,
      this.code,
      required this.enums,
      required this.exports,
      this.immutable,
      required this.imports,
      this.jsonSerializable,
      required this.parts});

  /// Creates an instance of 'Library' from a JSON representation
  factory Library.fromJson(Map<String, dynamic> json) =>
      _$LibraryFromJson(json);

  /// Indicates the need for a null safety check during code generation
  bool? checkNullSafety;

  /// List of JSON classes
    List<Class> classes;

  /// Source code to be inserted into the library
  String? code;

  /// List of JSON enums
    List<Enum> enums;

  /// List of export directives
    List<String> exports;

  /// Indicates immutability
  bool? immutable;

  /// List of import directives
    List<String> imports;

  /// Default values for annotation JsonSerializable
  JsonSerializableAnnotation? jsonSerializable;

  /// List of part directives
    List<String> parts;

  /// Returns a JSON representation of the 'Library' instance.
  Map<String, dynamic> toJson() => _$LibraryToJson(this);
}
// GENERATED CODE - DO NOT MODIFY BY HAND


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
