// @dart=2.10

part of '../../builders.dart';

class _GeneratorExecutor {
  final String input;

  _GeneratorExecutor({@required this.input});

  @alwaysThrows
  void error(String message, _Context context) {
    var exception = 'The \'build_it\' processing error\n';
    exception += getErrorMessage(message, context);
    throw exception;
  }

  Future spawn(Uri url, List<String> args, List<String> errors) async {
    final exitPort = ReceivePort();
    final errorPort = ReceivePort();
    final responsePort = ReceivePort();
    var hasError = false;
    var resultCount = 0;
    var result;

    void cloaseAllPorts() {
      errorPort.close();
      exitPort.close();
      responsePort.close();
    }

    final completer = Completer();
    exitPort.listen((message) {
      cloaseAllPorts();
      if (!hasError) {
        if (resultCount == 0) {
          errors.add('The generator did not return a result');
          completer.complete();
        } else if (resultCount == 1) {
          completer.complete(result);
        } else {
          errors.add(
              'The generator returned the result $resultCount times, the results were rejected');
          completer.complete();
        }
      } else {
        completer.complete();
      }
    });

    errorPort.listen((messages) {
      var message = 'An exception was thrown during generator execution\n';
      if (messages is List) {
        message += messages.join('\n');
      } else {
        message += '$messages';
      }

      errors.add(message);
      hasError = true;
    });

    responsePort.listen((message) {
      if (resultCount++ == 0) {
        result = message;
      }
    });

    try {
      await Isolate.spawnUri(url, args, responsePort.sendPort,
          onError: errorPort.sendPort, onExit: exitPort.sendPort);
    } catch (e) {
      cloaseAllPorts();
      completer.complete();
      errors.add('Isolate spawning exception occurred');
      rethrow;
    }

    return completer.future;
  }

  String getErrorMessage(String message, context) {
    final sb = StringBuffer();
    sb.writeln(message);
    if (context.generatorName != null) {
      sb.write('Generator: ');
      sb.write(context.generatorName);
      if (context.packageUrl != null) {
        sb.write(' (');
        sb.write(context.packageUrl);
        sb.write(')');
      }

      sb.writeln();
    }

    sb.write('Input: ');
    sb.writeln(input);
    return sb.toString();
  }
}
