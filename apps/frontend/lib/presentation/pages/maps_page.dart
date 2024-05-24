import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart' hide Address;
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nearfleet_app/config/constants/nearfleet_constants.dart';
import 'package:nearfleet_app/config/extensions/null_extensions.dart';
import 'package:nearfleet_app/config/helpers/helpers.dart';
import 'package:nearfleet_app/domain/entities/address.dart';
import 'package:nearfleet_app/presentation/providers/addresses_bloc.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../config/di/di.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => MapSampleState();
}

class MapSampleState extends State<MapsPage> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  
  LatLng currentPosition = NearfleetConstants.initPosition;

  final CameraPosition initialCameraPosition = const CameraPosition(
    target: NearfleetConstants.initPosition,
    zoom: 14,
  );

  void _onPositionChange(LatLng position) {
    setState(() {
      currentPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AddressesBloc>().state.isLoading;

    Widget fab = FloatingActionButton.extended(
      isExtended: !isLoading,
      label: isLoading ? const CircularProgressIndicator() : const Text('Save address'),
      icon: const Icon(Icons.save),
      onPressed: _onSubmit,
    );

    if(kIsWeb) {
      fab = PointerInterceptor(child: fab);
    }

    final Set<Marker> currentMarker = {
      Marker(
        markerId: NearfleetConstants.uniqueMarker,
        position: currentPosition,
      )
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps Page'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) => _controller.complete(controller),
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        initialCameraPosition: initialCameraPosition,
        markers: currentMarker,
        onTap: _onPositionChange,
      ),
      floatingActionButton: fab,
    );
  }

  Future<void> _onSubmit() async {
    final addressesBloc = context.read<AddressesBloc>();
    final geoCode = getIt.get<GeoCode>();
    final address = await geoCode.reverseGeocoding(
      latitude: currentPosition.latitude,
      longitude: currentPosition.longitude
    );

    final result = await addressesBloc.createAddress(Address(
      city: address.city,
      country: address.countryCode,
      state: address.region,
      street: address.streetAddress.nonNullValueEmpty(address.streetNumber.toString()),
      zipCode: address.postal.nonNullValue(),
      latitude: currentPosition.latitude,
      longitude: currentPosition.longitude,
    ));

    if (!mounted) return;

    if (result == null) {
      return Helpers.showSnackbar(
        context,
        message: 'Address was not successfully created',
        isAnErrorMessage: true,
      );
    }

    Helpers.showSnackbar(
      context,
      message: 'Address was successfully created',
    );

    context.pop();
  }
}