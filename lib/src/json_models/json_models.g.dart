// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'json_models.g.g.dart';

// **************************************************************************
// build_it: build_it:json
// **************************************************************************

/// JsonObject is used to describe the JSON object
@JsonSerializable()
class JsonObject {
  JsonObject(
      {required this.annotations,
      this.comments,
      this.immutable,
      this.name,
      required this.properties});

  /// Creates an object from a JSON representation
  factory JsonObject.fromJson(Map<String, dynamic> json) =>
      _$JsonObjectFromJson(json);

  /// Metadata describing the JSON object
  @JsonKey(defaultValue: [])
  List<String> annotations;

  /// Documenting comments for JSON object
  String? comments;

  /// Indicates whether JSON object is immutable or not
  bool? immutable;

  /// JSON object name
  String? name;

  /// List of JSON object properties
  @JsonKey(defaultValue: [])
  List<Property> properties;

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$JsonObjectToJson(this);
}

/// JsonObjects is used to describe the collection of JSON objects
@JsonSerializable()
class JsonObjects {
  JsonObjects(
      {this.checkNullSafety,
      required this.exports,
      this.filename,
      this.immutable,
      required this.imports,
      required this.jsonObjects,
      required this.parts});

  /// Creates an object from a JSON representation
  factory JsonObjects.fromJson(Map<String, dynamic> json) =>
      _$JsonObjectsFromJson(json);

  /// Indicates the need for a null safety check during code generation
  bool? checkNullSafety;

  /// List of used export directives
  @JsonKey(defaultValue: [])
  List<String> exports;

  /// If a filename is specified, the result will be written to the file rather than to the build output
  String? filename;

  /// Indicates whether JSON objects is immutable or not
  bool? immutable;

  /// List of used import directives
  @JsonKey(defaultValue: [])
  List<String> imports;

  /// List of JSON objects
  @JsonKey(defaultValue: [])
  List<JsonObject> jsonObjects;

  /// List of used part directives
  @JsonKey(defaultValue: [])
  List<String> parts;

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$JsonObjectsToJson(this);
}

@JsonSerializable()
class Property {
  Property(
      {required this.annotations,
      this.comments,
      this.defaultValue,
      this.key,
      this.name,
      this.type});

  /// Creates an object from a JSON representation
  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  /// Metadata describing the JSON object property
  @JsonKey(defaultValue: [])
  List<String> annotations;

  /// Documenting comments for JSON object property
  String? comments;

  /// Documenting comments for JSON object property
  Object? defaultValue;

  /// The key in a JSON map
  String? key;

  /// JSON object property name
  String? name;

  /// JSON object property type
  String? type;

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}
