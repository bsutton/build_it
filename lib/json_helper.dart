import 'dart:convert';

T fromJson<T>(json, T Function(Map<String, dynamic>) construct) {
  if (json is Map) {
    return construct(json.cast());
  }

  throw ArgumentError('');
}

extension ListExtension on List {
  List<T> fromJson<T>(T Function(Map<String, dynamic>) fromJson) {
    final result = <T>[];
    for (final element in this) {
      if (element is Map) {
        final value = element.fromJson(fromJson);
        result.add(value);
      }
    }

    return result;
  }
}

extension MapExtension on Map {
  T fromJson<T>(T Function(Map<String, dynamic>) fromJson) {
    return fromJson(cast());
  }
}

extension StringExtension on String {
  T decodeJson<T>(T Function(Map<String, dynamic>) fromJson) {
    final json = jsonDecode(this);
    if (json is Map) {
      return json.fromJson(fromJson);
    }

    return throw ArgumentError(
        'The decoding result type is not a \'Map\': ${json.runtimeType}');
  }
}
