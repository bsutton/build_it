// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

// **************************************************************************
// build_it: build_it:json_dev
// **************************************************************************

/// Configuration passed to generators
class BuildConfig {
  BuildConfig(
      {this.combineParts,
      required this.data,
      required this.index,
      required this.input,
      required this.metadata,
      required this.output});

  /// Creates an instance of 'BuildConfig' from a JSON representation
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

  /// Returns a JSON representation of the 'BuildConfig' instance.
  Map<String, dynamic> toJson() => _$BuildConfigToJson(this);
}

class Directive {
  Directive(
      {this.as,
      this.deferred,
      this.hide,
      this.show,
      required this.type,
      required this.url});

  /// Creates an instance of 'Directive' from a JSON representation
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

  /// Returns a JSON representation of the 'Directive' instance.
  Map<String, dynamic> toJson() => _$DirectiveToJson(this);
}

/// Used to return the result of the generation
class BuildResult {
  BuildResult({this.code, this.directives, this.error, this.postBuildData});

  /// Creates an instance of 'BuildResult' from a JSON representation
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

  /// Returns a JSON representation of the 'BuildResult' instance.
  Map<String, dynamic> toJson() => _$BuildResultToJson(this);
}

/// Post-build configuration that will be passed to the handler method
class PostBuildConfig {
  PostBuildConfig({this.data, required this.input});

  /// Creates an instance of 'PostBuildConfig' from a JSON representation
  factory PostBuildConfig.fromJson(Map<String, dynamic> json) =>
      _$PostBuildConfigFromJson(json);

  /// Input user to be processed by the handler
  final String? data;

  /// The parameter received by the post-builder
  final String input;

  /// Returns a JSON representation of the 'PostBuildConfig' instance.
  Map<String, dynamic> toJson() => _$PostBuildConfigToJson(this);
}
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildConfig _$BuildConfigFromJson(Map<String, dynamic> json) {
  return BuildConfig(
    combineParts: json['combineParts'] as bool?,
    data: json['data'] as String,
    index: json['index'] as int,
    input: json['input'] as String,
    metadata: json['metadata'] as String,
    output: json['output'] as String,
  );
}

Map<String, dynamic> _$BuildConfigToJson(BuildConfig instance) =>
    <String, dynamic>{
      'combineParts': instance.combineParts,
      'data': instance.data,
      'index': instance.index,
      'input': instance.input,
      'metadata': instance.metadata,
      'output': instance.output,
    };

Directive _$DirectiveFromJson(Map<String, dynamic> json) {
  return Directive(
    as: json['as'] as String?,
    deferred: json['deferred'] as bool?,
    hide: (json['hide'] as List<dynamic>?)?.map((e) => e as String).toList(),
    show: (json['show'] as List<dynamic>?)?.map((e) => e as String).toList(),
    type: json['type'] as String,
    url: json['url'] as String,
  );
}

Map<String, dynamic> _$DirectiveToJson(Directive instance) => <String, dynamic>{
      'as': instance.as,
      'deferred': instance.deferred,
      'hide': instance.hide,
      'show': instance.show,
      'type': instance.type,
      'url': instance.url,
    };

BuildResult _$BuildResultFromJson(Map<String, dynamic> json) {
  return BuildResult(
    code: json['code'] as String?,
    directives: (json['directives'] as List<dynamic>?)
        ?.map((e) => Directive.fromJson(e as Map<String, dynamic>))
        .toList(),
    error: json['error'] as String?,
    postBuildData: json['postBuildData'] as String?,
  );
}

Map<String, dynamic> _$BuildResultToJson(BuildResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'directives': instance.directives,
      'error': instance.error,
      'postBuildData': instance.postBuildData,
    };

PostBuildConfig _$PostBuildConfigFromJson(Map<String, dynamic> json) {
  return PostBuildConfig(
    data: json['data'] as String?,
    input: json['input'] as String,
  );
}

Map<String, dynamic> _$PostBuildConfigToJson(PostBuildConfig instance) =>
    <String, dynamic>{
      'data': instance.data,
      'input': instance.input,
    };
