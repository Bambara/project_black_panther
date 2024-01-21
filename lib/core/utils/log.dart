import 'package:logger/logger.dart';

class Log {
  static LogMode _logMode = LogMode.debug;
  static final Logger _logger = Logger(filter: null, printer: PrettyPrinter(), output: null);

  static void init(LogMode mode) {
    Log._logMode = mode;
  }

  // static void log(dynamic data, {StackTrace? stackTrace}) {
  //   if (_logMode == LogMode.debug) {
  //     print("Error: $data$stackTrace");
  //   }
  // }

  static void i(dynamic info) {
    if (_logMode == LogMode.debug) {
      _logger.i(info);
    }
  }

  static void e(dynamic error) {
    if (_logMode == LogMode.debug) {
      _logger.e(error);
    }
  }

  static void w(dynamic worn) {
    if (_logMode == LogMode.debug) {
      _logger.w(worn);
    }
  }

  static void v(dynamic verb) {
    if (_logMode == LogMode.debug) {
      _logger.v(verb);
    }
  }
}

enum LogMode { debug, live }
