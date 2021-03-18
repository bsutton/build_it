// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'json_models.g.g.dart';

// **************************************************************************
// build_it: build_it:json
// **************************************************************************

/// Class is used to describe the JSON class
@JsonSerializable()
class Class {
  Class(
      {required this.annotations,
      this.comments,
      required this.fields,
      this.immutable,
      this.jsonSerializable,
      this.name});

  /// Creates an object from a JSON representation
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

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$ClassToJson(this);
}

/// Enum is used to describe the JSON enum
@JsonSerializable()
class Enum {
  Enum({required this.value, this.jsonValue});

  /// Creates an object from a JSON representation
  factory Enum.fromJson(Map<String, dynamic> json) => _$EnumFromJson(json);

  /// Enumeration value name
  String value;

  /// Represents annotation JsonValue
  JsonValueAnnotation? jsonValue;

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$EnumToJson(this);
}

/// Field is used to describe the JSON field
@JsonSerializable()
class Field {
  Field(
      {required this.annotations,
      this.comments,
      this.jsonKey,
      this.name,
      this.type});

  /// Creates an object from a JSON representation
  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  /// Metadata describing the JSON field
  List<String> annotations;

  /// Documenting comments for JSON field
  String? comments;

  /// Represents annotation JsonKey
  JsonKeyAnnotation? jsonKey;

  /// JSON field name
  String? name;

  /// JSON field type
  String? type;

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$FieldToJson(this);
}

/// Represents annotation JsonKey
@JsonSerializable()
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

  /// Creates an object from a JSON representation
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

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$JsonKeyAnnotationToJson(this);
}

/// Represents annotation JsonSerializable
@JsonSerializable()
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

  /// Creates an object from a JSON representation
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

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$JsonSerializableAnnotationToJson(this);
}

/// Represents annotation JsonValue
@JsonSerializable()
class JsonValueAnnotation {
  JsonValueAnnotation({required this.value});

  /// Creates an object from a JSON representation
  factory JsonValueAnnotation.fromJson(Map<String, dynamic> json) =>
      _$JsonValueAnnotationFromJson(json);

  Object value;

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$JsonValueAnnotationToJson(this);
}

/// Library is used to describe the JSON library
@JsonSerializable()
class Library {
  Library(
      {this.checkNullSafety,
      required this.classes,
      required this.enums,
      required this.exports,
      this.immutable,
      required this.imports,
      this.jsonSerializable,
      required this.parts});

  /// Creates an object from a JSON representation
  factory Library.fromJson(Map<String, dynamic> json) =>
      _$LibraryFromJson(json);

  /// Indicates the need for a null safety check during code generation
  bool? checkNullSafety;

  /// List of JSON classes
  List<Class> classes;

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

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$LibraryToJson(this);
}
