import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/address.dart';

class AddressesBloc extends Cubit<AddressesState> {
  AddressesBloc() : super(const AddressesState());

  void emitLoading(bool value) => emit(state.copyWith(isLoading: value));
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