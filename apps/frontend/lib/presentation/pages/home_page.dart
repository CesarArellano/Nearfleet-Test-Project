import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/extensions/null_extensions.dart';
import '../../config/helpers/helpers.dart';
import '../../domain/entities/entities.dart';
import '../providers/addresses_bloc.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    final addressesBloc = context.read<AddressesBloc>();
    addressesBloc.getAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Addresses'),
      ),
      body: const _HomePageBody(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.push('/maps')
      ),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody();

  @override
  Widget build(BuildContext context) {
    final addressesCubit = context.watch<AddressesBloc>();
    final addressesState = addressesCubit.state;
    final addresses = addressesState.addresses;
    final isLoading = addressesState.isLoading;

    if(isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if(addresses.isEmpty) {
      return const EmptyFullScreen();
    }

    return RefreshIndicator(
      onRefresh: addressesCubit.getAddresses,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: addresses.length,
          itemBuilder:(context, index) {
            final address = addresses[index];
            return _AddressItem(address: address);
          }
        ),
      ),
    );
  }
}

class _AddressItem extends StatelessWidget {
  final Address address;
  const _AddressItem({required this.address});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _onDeleteAddress(
        context,
        address.id.nonNullValue(),
      ),
      background: const DismissibleBackground(),
      child: ListTile(
        title: Text('${address.street}, ${address.city}, ${address.state}, ${address.country}, ${address.zipCode}'),
        subtitle: Text('${address.latitude}, ${address.longitude}'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () => _onAddressTap(context, address),
      ),
    );
  }

  void _onAddressTap(BuildContext context, Address address) {
    context.push('/maps', extra: MapsPageScreenParams(address: address).toMap());
  }

  void _onDeleteAddress(BuildContext context, int addressId) async {
    final addressesBloc = context.read<AddressesBloc>();
    final wasSuccessfully = await addressesBloc.deleteAddress(addressId);

    if (!context.mounted) return;

    final serverMsg = (wasSuccessfully) 
      ? 'Address was successfully deleted'
      : 'Address was not successfully deleted';

    Helpers.showSnackbar(
      context,
      message: serverMsg,
      isAnErrorMessage: !wasSuccessfully,
    );

    if(wasSuccessfully) context.pop();
  }
}