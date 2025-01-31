import 'package:fixit_provider/config/injection_config.dart';
import 'package:fixit_provider/network/api.dart';

class RepositoryConfig {
  var api = getIt.get<RestClient>();
}
