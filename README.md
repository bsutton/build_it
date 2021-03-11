# build_it

The `build it`is a builder that makes publicly available third-party source code generators and runs them during the build process for rapid development.

Version 0.2.0 (BETA)

## What are the principles of work?

The `build_it` builder simplifies several development steps at once:

- Allows you to easily use your own generator without delving too much into the principles of the build process (generate whatever you want)  
- You can use your own data description format to configure your generator in YAML format (it is recommended to use JSON models for this purpose)  
- You can use third-party source code generators for rapid development, you just need to know the configuration description format (and what they end up creating)  

## How do generators become publicly available?

Create a file named `your_generator_name_build_it.dart`.  
That is, add `_build_it.dart` at the end of the generator file name.  
Your generator will be available to anyone who adds dependencies to your package.  
The generator will be available with the name `your_package_name:generator_name`.  
Or, if your generator has the same name as your package, then its alias (the short name) will be `your_package_name`.  

If necessary, you can hide it away in your package.  
Eg. `src/foo/bar/baz_build_it.dart`

## File format

Input configuration files must be in the `build_it` format.  
This is a non-existent format (don't try to find a description). This format is only intended to be able to identify data in this format.  
This format is very simple. The data format is `YAML`.  
You just need to specify the correct YAML `metadata section` in a certain way.

The header format (YAML `metadata section`) is shown below.

```yaml
---
format:
  name: build_it
  generator:
    name: string
  language:
    version: string?
---

# Configuration goes here
```

## How to use

The `build_it` builder directly executes third-party (or your own) generators for you.  
The builder executes thеse generators that generates ready-to-use files (or files for other builders or generators).  
The configurations for generators are described in the `YAML` format.  
Configurations are based on specifications.  
That is, you describe the configuration in the `YAML` format according to the specification. Because the target generator will use this configuration for its work.

## How to implement your own `build_it` generator?

First, add a dependency to the `pubspec.yaml` file:

```yaml
dependencies:
  # Don't forget about other runtime dependencies, eg. `json_annotation`
dev_dependencies:
  build: ^1.6.2
  build_it: ^0.2.0
  build_runner: ^1.11.5
```

Suppose you want to create a generator named `foo`. 

Create a file named `foo_build_it.dart` in the` lib` folder. 

Add the following directive (for data exchange with the builder):

```dart
import 'package:build_it/build_it_models.dart';
```

Create a `main` method:

```dart
Future<void> main(List<String> args, [response]) async {
  //
}
```

And add some code to it.

```dart
import 'dart:convert';
import 'dart:isolate';

import 'package:build_it/build_it_models.dart';

Future<void> main(List<String> args, [response]) async {
  if (response is! SendPort) {
    return;
  }

  if (args.length != 1) {
    throw ArgumentError('Wrong number of arguments');
  }

  final arg = jsonDecode(args[0]) as Map;
  final config = BuildConfig.fromJson(arg.cast());
  final data = jsonDecode(config.data);
  if (data == null) {
    final result = BuildResult(code: '// There is no data\n');
    response.send(jsonEncode(result.toJson()));
    return;
  }

  if (data is! Map) {
    throw StateError('Unexpected configuration data type: ${data.runtimeType}');
  }

  final name = data['name'] as String;
  final code = <String>[];
  final template = _template.replaceAll('{{NAME}}', name);
  code.add(template);

  final directives = <Directive>[];
  directives.add(Directive(type: 'import', url: 'dart:io'));

  final result = BuildResult(code: code.join('\n'), directives: directives);
  response.send(jsonEncode(result.toJson()));
}

const _template = '''
void main() {
  stdout.writeln('Hello, {{NAME}}');
}
''';

```

Then create your config file:

`foo_test.yaml`

```yaml
---
format:
  name: build_it
  language:
    version: "2.10" # If you need it
  generator:    
    name: build_it_test:foo
---

name: "Jack"
```

We will assume that your package is named `build_it_test`.   
Accordingly, the public available name of your generator is `build_it_test:foo`.  

Everything is ready, you can start the build process:

`dart run build_runner build`

Below is the build (and generation) result:

`foo_test.g.dart`

```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'dart:io';

// **************************************************************************
// build_it: build_it_test:foo
// **************************************************************************

void main() {
  stdout.writeln('Hello, Jack');
}

```

Yes, it’s not impressive, but we didn't put much effort into it.  
A good generator should have a format specification and use JSON models to work with the configuration.

## Built-in JSON generator

For a generator to work well, a specification is required to describe the configuration and to work with the configuration.  
JSON objects are very well suited for this purpose. They are convenient for modeling and data processing.  
It is not very pleasant to write such objects by hand, it is a common routine work.  
Using the `json` generator from the` build_it` package can make this work a little easier.

Example of configuration for this generator:

`example_objects.yaml`

```yaml
---
format:
  name: build_it
  generator:
    name: build_it:json
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

The result of work:

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

This generator is an example of how and what kind of public generators can be written and used with the `build_it` builder.  
If you add the following dependencies to your project, then this generator will be available in your project as well.

```yaml
dependencies:
  json_annotation: ^4.0.0
dev_dependencies:
  build: ^1.6.2
  build_it: ^0.1.1
  build_runner: ^1.11.5  
  json_serializable: ^4.0.2
```

Now everyone who adds dependencies will have access to this generator.  

This way everyone can easily create useful public generators for everyone.  
This applies to all generators intended to use with `build_it` builder.

## How to avoid bulld conflicts?

The only way to avoid build conflicts is to not create a Dart file with the same name as the configuration file.  
For example, if you are using a configuration file named `my_models.yaml`, then do not create a file called `my_models.dart`.  
The reason for the possible conflict may be that if the file `my_models.dart` will generate the file` my_models.g.dart`, then there will be a build conflict.

To be continued...  