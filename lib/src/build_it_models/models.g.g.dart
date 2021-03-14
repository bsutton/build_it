// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.g.dart';

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
