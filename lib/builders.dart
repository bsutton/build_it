// @dart = 2.10

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as _path;
import 'package:yaml/yaml.dart' as _yaml;

import 'build_it_models.dart';
import 'src/directive_extension.dart';

part 'src/builders/build_builder.dart';
part 'src/builders/build_generator_executor.dart';
part 'src/builders/generator_executor.dart';
part 'src/builders/generator_path_resolver.dart';
part 'src/builders/packages_file_resolver.dart';
part 'src/builders/post_build_generator_executor.dart';
part 'src/builders/post_build_request.dart';
part 'src/builders/post_builder.dart';
