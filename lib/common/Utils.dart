import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class Utils {
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
}
