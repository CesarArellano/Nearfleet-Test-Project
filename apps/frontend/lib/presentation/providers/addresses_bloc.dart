import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/extensions/null_extensions.dart';
import '../../domain/entities/address.dart';
import '../../domain/repositories/addresses_repository.dart';

class AddressesBloc extends Cubit<AddressesState> {
  final AddressesRepository addressesRepository;

  AddressesBloc({
    required this.addressesRepository,
  }) : super(const AddressesState());

  Future<void> getAddresses() async {
    _emitLoading();
    final addreses = await addressesRepository.getAddresses();
    emit(state.copyWith(addresses: addreses, isLoading: false));
  }

  Future<AddressResponse> createAddress(Address newAddress) async {
    final newLatitude = newAddress.latitude.nonNullValue();
    final newLongitude = newAddress.longitude.nonNullValue();

    if (_addressValidation(newLatitude, newLongitude)) return AddressResponse();

    _emitLoading();

    final addresesResponse = await addressesRepository.createAddress(newAddress);
    
    if(addresesResponse.address != null) {
      emit(state.copyWith(addresses: [...state.addresses, addresesResponse.address!]));
    }

    emit(state.copyWith(isLoading: false));

    return addresesResponse;
  }

  bool _addressValidation(double lt, double lng) {
    return state.addresses.any((address) => address.latitude == lt && address.longitude == lng);
  }

  void _emitLoading() => emit(state.copyWith(isLoading: true));
}

class AddressesState extends Equatable {

  final List<Address> addresses;
  final bool isLoading;

  const AddressesState({
    this.addresses = const [],
    this.isLoading = false,
  });

  AddressesState copyWith({
    List<Address>? addresses,
    bool? isLoading,
  }) => AddressesState(
    addresses: addresses ?? this.addresses,
    isLoading: isLoading ?? this.isLoading
  );
  
  @override
  List<Object?> get props => [addresses, isLoading];
}