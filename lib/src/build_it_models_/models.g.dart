// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'models.g.g.dart';

// **************************************************************************
// build_it: build_it:json
// **************************************************************************

// @build_it : combine_into_single_file
/// Configuration passed to generators
@JsonSerializable()
class BuildConfig {
  BuildConfig(
      {this.combineParts,
      required this.data,
      required this.index,
      required this.input,
      required this.metadata,
      required this.output});

  /// Creates an object from a JSON representation
  factory BuildConfig.fromJson(Map<String, dynamic> json) =>
      _$BuildConfigFromJson(json);

  /// If true, one file without parts will also be built
  final bool? combineParts;

  /// Contents of YAML document in JSON format
  final String data;

  /// Index of YAML metadata document
  final int index;

  /// Input file path
  final String input;

  /// YAML metadata in JSON format
  final String metadata;

  /// Output file path
  final String output;

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$BuildConfigToJson(this);
}

@JsonSerializable()
class Directive {
  Directive(
      {this.as,
      this.deferred,
      this.hide,
      this.show,
      required this.type,
      required this.url});

  /// Creates an object from a JSON representation
  factory Directive.fromJson(Map<String, dynamic> json) =>
      _$DirectiveFromJson(json);

  /// Directive prefix
  final String? as;

  /// Indicates that the directive is deferred
  final bool? deferred;

  /// List of identifiers to hide
  final List<String>? hide;

  /// List of identifiers to show
  final List<String>? show;

  final String type;

  /// Directive url
  final String url;

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$DirectiveToJson(this);
}

/// Used to return the result of the generation
@JsonSerializable()
class BuildResult {
  BuildResult({this.code, this.directives, this.error, this.postBuildData});

  /// Creates an object from a JSON representation
  factory BuildResult.fromJson(Map<String, dynamic> json) =>
      _$BuildResultFromJson(json);

  /// Generated code, excluding directives
  final String? code;

  /// Generated directives
  final List<Directive>? directives;

  /// A message indicating that an error has occurred
  final String? error;

  /// If specified, a post build step with the specified value will be called
  final String? postBuildData;

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$BuildResultToJson(this);
}

/// Post-build configuration that will be passed to the handler method
@JsonSerializable()
class PostBuildConfig {
  PostBuildConfig({this.data, required this.input});

  /// Creates an object from a JSON representation
  factory PostBuildConfig.fromJson(Map<String, dynamic> json) =>
      _$PostBuildConfigFromJson(json);

  /// Input user to be processed by the handler
  final String? data;

  /// The parameter received by the post-builder
  final String input;

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$PostBuildConfigToJson(this);
}
