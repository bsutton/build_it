# build_it

The `build_it` is a builder that representing various types of generators that mainly generate code for other generators (and builders), or generates ready-to-use code.

Version 0.1.1

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

For example, for generator `JsonSerializable`, the `JsonObjects` model is the root model that describes the configuration for that generator.

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

[https://github.com/mezoni/build_it/blob/main/lib/src/specifications/json_serializable.yaml](https://github.com/mezoni/build_it/blob/main/lib/src/specifications/json_serializable.yaml)  

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

`example_objects.yaml`

```yaml
---
format:
  name: build_it
  generator:
    name: JsonSerializable
---

jsonObjects:
- name: Category
  properties:
  - { name: id, type: int }
  - { name: name, type: String }
  - { name: products, type: List<Product> }

- name: Product
  properties:
  - { name: id, type: int }
  - { name: name, type: String }
```

An example of the generated code:

`example_objects.g.dart`

```dart
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

```

Example of using generated code:

```dart
import 'example_objects.g.dart';

void main() {
  final categories = _json.map((e) => Category.fromJson(e));
  for (final category in categories) {
    print('Category: ${category.name}');
    for (final product in category.products) {
      print('  Product: ${product.name}');
    }
  }
}

final _json = [
  {
    'id': 1,
    'name': 'Intel CPU',
    'products': [
      {'id': 1, 'name': 'Celeron'},
      {'id': 1, 'name': 'Pentium'},
      {'id': 1, 'name': 'Core i3'},
      {'id': 1, 'name': 'Core i5'},
      {'id': 1, 'name': 'Core i7'},
    ]
  },
  {
    'id': 2,
    'name': 'AMD CPU',
    'products': [
      {'id': 1, 'name': 'Sempron'},
      {'id': 1, 'name': 'Athlon'},
      {'id': 1, 'name': 'Phenom'},
      {'id': 1, 'name': 'Opteron'},
    ]
  }
];

```

## How to avoid bulld conflicts

The only way to avoid build conflicts is to not create a Dart file with the same name as the configuration file.  
For example, if you are using a configuration file named `my_models.yaml`, then do not create a file called `my_models.dart`.  
The reason for the possible conflict may be that if the file `my_models.dart` will generate the file` my_models.g.dart`, then there will be a build conflict.

To be continued...  