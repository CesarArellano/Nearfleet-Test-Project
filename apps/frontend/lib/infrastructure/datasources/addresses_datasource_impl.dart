import 'dart:developer';

import '../../config/network/network_service.dart';
import '../../domain/datasources/addresses_datasource.dart';
import '../../domain/entities/address.dart';

class AddressesDatasourceImpl implements AddressesDatasource {
  final NetworkService networkService;

  AddressesDatasourceImpl({required this.networkService});

  @override
  Future<Address?> createAddress(Address newAddress) async {
    try {
      final response = await networkService.post('/addresses', data: newAddress.toJson());
      final address = Address.fromJson(response.data);
      return address;
    } catch (e) {
      log('$e');
      return null;
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
      final addresses = Addresses.fromJson(response.data);
      return addresses.results;
    } catch (e) {
      log('$e');
      return [];
    }
  }

  @override
  Future<Address?> updateAddress(Address newAddress) async{
    try {
      final response = await networkService.put('/addresses/${newAddress.id}', data: newAddress.toJson());
      final address = Address.fromJson(response.data);
      return address;
    } catch (e) {
      log('$e');
      return null;
    }
  }

}