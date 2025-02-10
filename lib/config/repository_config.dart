import 'package:fixit_provider/config/injection_config.dart';
import 'package:fixit_provider/network/api.dart';
import 'package:fixit_provider/network/common_api.dart';

class RepositoryConfig {
  var api = getIt.get<RestClient>();
  var commonRestClient = getIt.get<CommonApi>();
}
