import 'package:get_it/get_it.dart';
import '/config/constants/environment.dart';

import '../network/network_service.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton(() => NetworkService(baseUrl: Environment.baseURL));
}