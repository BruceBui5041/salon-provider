import 'dart:io';

import 'package:salon_provider/common/Utils.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/config/repository_config.dart';
import 'package:salon_provider/network/api.dart';

class TokenRepository extends RepositoryConfig {
  Future<void> saveUserDevice(String token) async {
    try {
      await getIt.get<UserApiClient>().saveUserDevice({
        "fcm_token": token,
        "platform": Platform.isAndroid ? "android" : "ios"
      });
    } catch (e) {
      Utils.warning(e.toString());
    }
  }
}
