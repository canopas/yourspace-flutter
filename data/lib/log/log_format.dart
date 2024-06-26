import 'dart:math';

import 'package:logger/logger.dart';

class AppLogPrinter extends LogPrinter {
  /// Matches a stacktrace line as generated on Android/iOS devices.
  /// For example:
  /// #1      Logger.log (package:logger/src/logger.dart:115:29)
  static final _deviceStackTraceRegex = RegExp(r'#[0-9]+\s+(.+) \((\S+)\)');

  /// Matches a stacktrace line as generated by Flutter web.
  /// For example:
  /// packages/logger/src/printers/pretty_printer.dart 91:37
  static final _webStackTraceRegex = RegExp(r'^((packages|dart-sdk)/\S+/)');

  /// Matches a stacktrace line as generated by browser Dart.
  /// For example:
  /// dart:sdk_internal
  /// package:logger/src/logger.dart
  static final _browserStackTraceRegex =
  RegExp(r'^(?:package:)?(dart:\S+|\S+)');

  @override
  List<String> log(LogEvent event) {
    final timestamp = DateTime.now().toIso8601String();
    final level = event.level.name.toUpperCase();
    final message = event.message;
    final stackTrace = formatStackTrace(event.stackTrace, 100);
    final method = formatStackTrace(StackTrace.current, 1);
    final error = event.error;

    return [
      '$timestamp [$level] ',
      if (method != null) '$method > ',
      '$message',
      if (error != null) 'Error: $error',
      if (error != null && stackTrace != null) '\n$stackTrace',
    ];
  }

  String? formatStackTrace(StackTrace? stackTrace, int methodCount) {
    final lines = stackTrace
        .toString()
        .split('\n')
        .where(
          (line) =>
      !_discardDeviceStacktraceLine(line) &&
          !_discardWebStacktraceLine(line) &&
          !_discardBrowserStacktraceLine(line) &&
          line.isNotEmpty,
    )
        .toList();
    final formatted = [];

    for (int count = 0; count < min(lines.length, methodCount + 1); count++) {
      final line = lines[count];
      if (count < 1) {
        continue;
      }
      if (methodCount == 1) {
        formatted.add(line.replaceFirst(RegExp(r'#\d+\s+'), ''));
      } else {
        formatted.add('#$count   ${line.replaceFirst(RegExp(r'#\d+\s+'), '')}');
      }
    }

    if (formatted.isEmpty) {
      return null;
    } else {
      return formatted.join('\n');
    }
  }

  bool _discardDeviceStacktraceLine(String line) {
    final match = _deviceStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    return match.group(2)!.startsWith('package:logger');
  }

  bool _discardWebStacktraceLine(String line) {
    final match = _webStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    return match.group(1)!.startsWith('packages/logger') ||
        match.group(1)!.startsWith('dart-sdk/lib');
  }

  bool _discardBrowserStacktraceLine(String line) {
    final match = _browserStackTraceRegex.matchAsPrefix(line);
    if (match == null) {
      return false;
    }
    return match.group(1)!.startsWith('package:logger') ||
        match.group(1)!.startsWith('dart:');
  }
}
