## 0.2.4

- Added (new feature) `post process` build support (not very well tested yet)
- Breaking change to support the `post process` build, the parameters of the `main` function of the generators have been changed
- Added the ability to simplify the process of handling the build steps from the `main` function of generators using `build_it_helper.dart`

## 0.2.3

- Slightly improved the `build_it` generators error reporting system

## 0.2.2

- Reduced and improved the source code of the JSON generator
- Added the ability to specify the need to check JSON objects for null safety when generating code to the JSON generator specification (property `checkNullSafety` of object `JsonObjects`).

## 0.2.1

- Fixed bug with `Uri` schema `file` when working with `.packages` file.


## 0.2.0

- Breaking changes and new features
- Added the ability to run public third-party generators

## 0.1.1

- Added `example.dart`

## 0.1.0

- Initial release
