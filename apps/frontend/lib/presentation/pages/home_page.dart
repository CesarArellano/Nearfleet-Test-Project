import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nearfleet_app/presentation/providers/addresses_bloc.dart';

class HomePage extends StatefulWidget {
  
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
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
    
    final addressesState = context.watch<AddressesBloc>().state;
    final addresses = addressesState.addresses;
    final isLoading = addressesState.isLoading;

    if(isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if(addresses.isEmpty) {
      return const Center(
        child: Text('Empty List')
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: addresses.length,
        itemBuilder:(context, index) {
          final address = addresses[index];
          return ListTile(
            title: Text('${address.street}, ${address.city}, ${address.state}, ${address.country}, ${address.zipCode}'),
            subtitle: Text('${address.latitude}, ${address.longitude}'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => context.push('/maps')
          );
        }
      ),
    );
  }
}