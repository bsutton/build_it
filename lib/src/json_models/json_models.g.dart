// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'json_models.g.g.dart';

// **************************************************************************
// build_it: build_it:json_dev
// **************************************************************************

/// Class is used to describe the JSON class
@JsonSerializable(disallowUnrecognizedKeys: true)
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
  @JsonKey(defaultValue: [])
  List<String> annotations;

  /// Documenting comments for JSON class
  String? comments;

  /// List of JSON fields
  @JsonKey(defaultValue: [])
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
@JsonSerializable(disallowUnrecognizedKeys: true)
class Enum {
  Enum(
      {required this.annotations,
      this.comments,
      this.name,
      required this.values});

  /// Creates an instance of 'Enum' from a JSON representation
  factory Enum.fromJson(Map<String, dynamic> json) => _$EnumFromJson(json);

  /// Metadata describing the JSON enum
  @JsonKey(defaultValue: [])
  List<String> annotations;

  /// Documenting comments for JSON enum
  String? comments;

  /// JSON enum name
  String? name;

  /// List of enumeration values
  @JsonKey(defaultValue: [])
  List<EnumValue> values;

  /// Returns a JSON representation of the 'Enum' instance.
  Map<String, dynamic> toJson() => _$EnumToJson(this);
}

/// Enum value is used to describe the JSON enum value
@JsonSerializable(disallowUnrecognizedKeys: true)
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
  @JsonKey(defaultValue: [])
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
@JsonSerializable(disallowUnrecognizedKeys: true)
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
  @JsonKey(defaultValue: [])
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
@JsonSerializable(disallowUnrecognizedKeys: true)
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

  @JsonKey(name: 'fromJson')
  String? fromJson$;

  bool? ignore;

  bool? includeIfNull;

  String? name;

  bool? required;

  @JsonKey(name: 'toJson')
  String? toJson$;

  Object? unknownEnumValue;

  /// Returns a JSON representation of the 'JsonKeyAnnotation' instance.
  Map<String, dynamic> toJson() => _$JsonKeyAnnotationToJson(this);
}

/// Represents annotation JsonSerializable
@JsonSerializable(disallowUnrecognizedKeys: true)
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
@JsonSerializable(disallowUnrecognizedKeys: true)
class JsonValueAnnotation {
  JsonValueAnnotation({required this.value});

  /// Creates an instance of 'JsonValueAnnotation' from a JSON representation
  factory JsonValueAnnotation.fromJson(Map<String, dynamic> json) =>
      _$JsonValueAnnotationFromJson(json);

  Object value;

  /// Returns a JSON representation of the 'JsonValueAnnotation' instance.
  Map<String, dynamic> toJson() => _$JsonValueAnnotationToJson(this);
}

/// Root is used to describe the configuration
@JsonSerializable(disallowUnrecognizedKeys: true)
class Root {
  Root(
      {this.checkNullSafety,
      required this.classes,
      this.code,
      required this.enums,
      required this.exports,
      this.immutable,
      required this.imports,
      this.jsonSerializable,
      required this.parts});

  /// Creates an instance of 'Root' from a JSON representation
  factory Root.fromJson(Map<String, dynamic> json) => _$RootFromJson(json);

  /// Indicates the need for a null safety check during code generation
  bool? checkNullSafety;

  /// List of JSON classes
  @JsonKey(defaultValue: [])
  List<Class> classes;

  /// Source code to be inserted into the library
  String? code;

  /// List of JSON enums
  @JsonKey(defaultValue: [])
  List<Enum> enums;

  /// List of export directives
  @JsonKey(defaultValue: [])
  List<String> exports;

  /// Indicates immutability
  bool? immutable;

  /// List of import directives
  @JsonKey(defaultValue: [])
  List<String> imports;

  /// Default values for annotation JsonSerializable
  JsonSerializableAnnotation? jsonSerializable;

  /// List of part directives
  @JsonKey(defaultValue: [])
  List<String> parts;

  /// Returns a JSON representation of the 'Root' instance.
  Map<String, dynamic> toJson() => _$RootToJson(this);
}
