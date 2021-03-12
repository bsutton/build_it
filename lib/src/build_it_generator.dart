// @dart = 2.10

import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:build_it/build_it_models.dart';
import 'package:dart_style/dart_style.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as _path;
import 'package:yaml/yaml.dart' as _yaml;

part 'build_it_generator/build_it_generator.dart';
part 'build_it_generator/directive_ext.dart';
part 'build_it_generator/list_extension.dart';
part 'build_it_generator/set_extension.dart';
