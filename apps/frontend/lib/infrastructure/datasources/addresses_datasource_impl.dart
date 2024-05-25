import 'dart:developer';

import '../../config/network/network_service.dart';
import '../../domain/datasources/addresses_datasource.dart';
import '../../domain/entities/address.dart';

class AddressesDatasourceImpl implements AddressesDatasource {
  final NetworkService networkService;

  AddressesDatasourceImpl({required this.networkService});

  @override
  Future<AddressResponse> createAddress(Address newAddress) async {
    try {
      final response = await networkService.post('/addresses', data: newAddress.toJson());
      final result = AddressResponse.fromJson(response.data);
      return result;
    } catch (e) {
      log('$e');
      return AddressResponse();
    }
  }

  @override
  Future<bool> deleteAddress(int id) async {
    try {
      await networkService.delete('/addresses/$int');
      return true;
    } catch (e) {
      log('$e');
      return false;
    }
  }

  @override
  Future<List<Address>> getAddresses() async {
    try {
      final response = await networkService.get('/addresses');
      final result = AddressResponse.fromJson(response.data);
      return result.results ?? [];
    } catch (e) {
      log('$e');
      return [];
    }
  }

  @override
  Future<AddressResponse> updateAddress(Address newAddress) async{
    try {
      final response = await networkService.put('/addresses/${newAddress.id}', data: newAddress.toJson());
      final result = AddressResponse.fromJson(response.data);
      return result;
    } catch (e) {
      log('$e');
      return AddressResponse();
    }
  }

}