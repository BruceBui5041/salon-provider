import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:logger/logger.dart';

class Utils {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  // Debug level log
  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  // Info level log
  static void info(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  // Warning level log
  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  // Error level log
  static void error(DioException e, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(e.response!.data['message'].toString(),
        error: error, stackTrace: stackTrace);
    // _logger.e(e)
    _logger.e(e.response!.data['log'], error: error, stackTrace: stackTrace);
  }

  // Verbose level log
  static void verbose(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.v(message, error: error, stackTrace: stackTrace);
  }

  // 2. compress file and get file.
  static Future<XFile?> compressAndGetFile(
      XFile file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      quality: 88,
      rotate: 180,
    );

    return result;
  }

  static void logError(DioException e) {
    _logger.e(
      "API Error",
      error: e,
      stackTrace: e.stackTrace,
    );
    if (e.response != null) {
      _logger.e(
        "Response Data",
        error: e.response?.data,
      );
    }
  }
}
