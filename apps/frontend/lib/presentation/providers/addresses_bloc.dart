import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nearfleet_app/domain/repositories/addresses_repository.dart';

import '../../domain/entities/address.dart';

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