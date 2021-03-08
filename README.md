# build_it

The `build_it` is a builder that representing various types of generators that mainly generate code for other generators (and builders), or generates ready-to-use code, doing the chores for you.    

Version 0.1.0

The current list of generators includes:

- JsonSerializable

## File format

Input configuration files must be in the `build_it` format.  
This is a non-existent format (don't try to find a description). This format is only intended to be able to identify data in this format.  
This format is very simple. The data format is `YAML`. You just need to specify the correct YAML `metadata section` in a certain way.  

The header format (YAML `metadata section`) is shown below.  

```yaml
---
format:
  type: build_it
---
```

## How to use

The `build_it` builder does not directly launch third-party generators.  
The builder executes built-in generators that generate files for other generators (or builders), or generates ready-to-use files, doing the chores for you.  
The configurations for the built-in generators are described in the `build_it` format.  
Configurations are based on specifications.  
That is, you describe the configuration in the `build_it` format according to the specification.

## Specifications

A format specification is a collection of models.  
An object is an instance of a model.  
Each object describes a piece of configuration.  
The root object describes the configuration.  
By convention, one of the models is used as a description of the configuration.  

For example, for generator `JsonSerializable`, the `JsonObject` model is the root model that describes the configuration for that generator.  

## Generator `JsonSerializable`

The header format for the `JsonSerializable` generator:  

```yaml
---
format:
  type: build_it
  generator:
    name: JsonSerializable
---
```

The format of the input configuration (used models) specified in the following file:  

[https://github.com/mezoni/build_it/lib/src/specifications/json_serializable.yaml](https://github.com/mezoni/build_it/lib/src/specifications/json_serializable.yaml)  

The `JsonObjects` model is used as the root model, which is used as the configuration.  

```yaml
---
format:
  name: build_it
  generator:
    name: JsonSerializable
---

jsonObjects:
- name: JsonObject
  comments: "JsonObject is used to describe the JSON object"
  properties:
  - name: annotations
    type: List<String>?
    comments: "Metadata describing the JSON object"
  - name: comments
    type: String?
    comments: "Documenting comments for JSON object"
  - name: immutable
    type: bool?
    comments: "Indicates whether JSON object is immutable or not"
  - name: name
    type: String?
    comments: "JSON object name"
  - name: properties
    type: List<Property>?
    comments: "List of JSON object properties"

- name: JsonObjects
  comments: "JsonObjects is used to describe the collection of JSON objects"
  properties:
  - name: exports
    type: List<String>?
    comments: "List of used export directives"
  - name: immutable
    type: bool?
    comments: "Indicates whether JSON objects is immutable or not"
  - name: imports
    type: List<String>?
    comments: "List of used import directives"
  - name: jsonObjects
    type: List<JsonObject>?
    comments: "List of JSON objects"
  - name: parts
    type: List<String>?
    comments: "List of used part directives"

- name: Property
  properties:
  - name: annotations
    type: List<String>?
    comments: "Metadata describing the JSON object property"
  - name: comments
    type: String?
    comments: "Documenting comments for JSON object property"
  - name: name
    type: String?
    comments: "JSON object property name"
  - name: type
    type: String?
    comments: "JSON object property type"

```

An example of the input configuration:

`shop_objects.yaml`

```yaml
---
format:
  name: build_it
  generator:
    name: JsonSerializable
---

immutable: true
jsonObjects:
- name: Product
  comments: "Product model"
  properties:
  - { name: id, type: int? }
  - { name: name, type: String? }
  - { name: retailPrice, type: double? }

- name: User
  immutable: false
  comments: "User model"
  properties:
  - { name: email, type: String? }
  - { name: id, type: int? }
  - { name: name, type: String? }
  - name: password
    type: String
    comments: "Password property"
```

An example of the generated code:

`shop_objects.g.dart`

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:json_annotation/json_annotation.dart';

part 'shop_objects.g.g.dart';

// **************************************************************************
// build_it: JsonSerializable
// **************************************************************************

/// Product model
@JsonSerializable()
class Product {
  Product({this.id, this.name, this.retailPrice});

  /// Creates an object from a JSON representation
  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  final int? id;

  final String? name;

  final double? retailPrice;

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

/// User model
@JsonSerializable()
class User {
  User({this.email, this.id, this.name, required this.password});

  /// Creates an object from a JSON representation
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  String? email;

  int? id;

  String? name;

  /// Password property
  String password;

  /// Returns a JSON representation of the object
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

```

To be continued...