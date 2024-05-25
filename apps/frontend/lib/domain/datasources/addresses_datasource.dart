import 'package:nearfleet_app/domain/entities/entities.dart';

abstract class AddressesDatasource {
  Future<List<Address>> getAddresses();
  Future<AddressResponse> createAddress(Address newAddress);
  Future<AddressResponse> updateAddress(Address newAddress);
  Future<bool> deleteAddress(int id);
}