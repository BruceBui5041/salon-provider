import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/network/api.dart';
import 'package:salon_provider/network/common_api.dart';

class RepositoryConfig {
  var api = getIt.get<RestClient>();
  var commonRestClient = getIt.get<CommonApi>();
}
