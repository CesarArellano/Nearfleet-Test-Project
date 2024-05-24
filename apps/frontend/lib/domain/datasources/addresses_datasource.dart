import 'package:nearfleet_app/domain/entities/entities.dart';

abstract class AddressesDatasource {
  Future<List<Address>> getAddresses();
  Future<Address?> createAddress(Address newAddress);
  Future<Address?> updateAddress(Address newAddress);
  Future<bool> deleteAddress(int id);
}