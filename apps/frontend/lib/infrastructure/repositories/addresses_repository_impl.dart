import 'package:nearfleet_app/domain/datasources/addresses_datasource.dart';
import 'package:nearfleet_app/domain/entities/address.dart';
import 'package:nearfleet_app/domain/repositories/addresses_repository.dart';

class AddressesRepositoryImpl implements AddressesRepository {

  final AddressesDatasource datasource;
  
  AddressesRepositoryImpl(this.datasource);

  @override
  Future<AddressResponse> createAddress(Address newAddress) {
    return datasource.createAddress(newAddress);
  }

  @override
  Future<bool> deleteAddress(int id) {
    return datasource.deleteAddress(id);
  }

  @override
  Future<List<Address>> getAddresses() {
    return datasource.getAddresses();
  }

  @override
  Future<AddressResponse> updateAddress(Address newAddress) {
    return datasource.updateAddress(newAddress);
  }
  
}