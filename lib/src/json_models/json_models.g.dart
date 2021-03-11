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
      {this.annotations,
      this.comments,
      this.immutable,
      this.name,
      this.properties});

  /// Creates an object from a JSON representation
  factory JsonObject.fromJson(Map<String, dynamic> json) =>
      _$JsonObjectFromJson(json);

  /// Metadata describing the JSON object
  List<String>? annotations;

  /// Documenting comments for JSON object
  String? comments;

  /// Indicates whether JSON object is immutable or not
  bool? immutable;

  /// JSON object name
  String? name;

  /// List of JSON object properties
  List<Property>? properties;

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$JsonObjectToJson(this);
}

/// JsonObjects is used to describe the collection of JSON objects
@JsonSerializable()
class JsonObjects {
  JsonObjects(
      {this.exports,
      this.immutable,
      this.imports,
      this.jsonObjects,
      this.parts});

  /// Creates an object from a JSON representation
  factory JsonObjects.fromJson(Map<String, dynamic> json) =>
      _$JsonObjectsFromJson(json);

  /// List of used export directives
  List<String>? exports;

  /// Indicates whether JSON objects is immutable or not
  bool? immutable;

  /// List of used import directives
  List<String>? imports;

  /// List of JSON objects
  List<JsonObject>? jsonObjects;

  /// List of used part directives
  List<String>? parts;

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$JsonObjectsToJson(this);
}

@JsonSerializable()
class Property {
  Property({this.annotations, this.comments, this.name, this.type});

  /// Creates an object from a JSON representation
  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);

  /// Metadata describing the JSON object property
  List<String>? annotations;

  /// Documenting comments for JSON object property
  String? comments;

  /// JSON object property name
  String? name;

  /// JSON object property type
  String? type;

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$PropertyToJson(this);
}
