// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'example_objects.g.g.dart';

// **************************************************************************
// build_it: JsonSerializable
// **************************************************************************

@JsonSerializable()
class Category {
  Category({required this.id, required this.name, required this.products});

  /// Creates an object from a JSON representation
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  int id;

  String name;

  List<Product> products;

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Product {
  Product({required this.id, required this.name});

  /// Creates an object from a JSON representation
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  int id;

  String name;

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
