import 'dart:io';

import 'package:salon_provider/common/Utils.dart';
import 'package:salon_provider/config/repository_config.dart';

class TokenRepository extends RepositoryConfig {
  Future<void> saveUserDevice(String token) async {
    try {
      await api.saveUserDevice({
        "fcm_token": token,
        "platform": Platform.isAndroid ? "android" : "ios"
      });
    } catch (e) {
      Utils.warning(e.toString());
    }
  }
}
