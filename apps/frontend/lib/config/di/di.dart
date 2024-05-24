import 'package:get_it/get_it.dart';
import 'package:nearfleet_app/domain/repositories/addresses_repository.dart';
import 'package:nearfleet_app/infrastructure/datasources/addresses_datasource_impl.dart';
import 'package:nearfleet_app/infrastructure/repositories/addresses_repository_impl.dart';
import '../../domain/datasources/addresses_datasource.dart';
import '/config/constants/environment.dart';

import '../network/network_service.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  final NetworkService networkService = NetworkService(baseUrl: Environment.baseURL);
  final AddressesDatasource addressesDatasource = AddressesDatasourceImpl(networkService: networkService);
  final AddressesRepository addressesRepository = AddressesRepositoryImpl(addressesDatasource);
  
  getIt.registerLazySingleton<NetworkService>(() => networkService);
  getIt.registerSingleton<AddressesRepository>(addressesRepository);
}