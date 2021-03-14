// @dart = 2.10

part of '../../builders.dart';

class _PostBuildRequest {
  final String data;

  final String generatorName;

  final String packageUrl;

  _PostBuildRequest(
      {@required this.data,
      @required this.generatorName,
      @required this.packageUrl});
}
