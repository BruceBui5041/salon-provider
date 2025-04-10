import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/network/common_api.dart';

class RepositoryConfig {
  var commonRestClient = getIt.get<CommonApi>();
}
