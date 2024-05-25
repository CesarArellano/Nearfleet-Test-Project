import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart' as geocode;
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../../config/extensions/null_extensions.dart';
import '../../domain/entities/entities.dart';
import '../../config/constants/nearfleet_constants.dart';
import '../../config/di/di.dart';
import '../../config/helpers/helpers.dart';
import '../../infrastructure/mappers/address_mapper.dart';
import '../providers/addresses_bloc.dart';

class MapsPageScreenParams {
  final Address? address;

  const MapsPageScreenParams({this.address});

  factory MapsPageScreenParams.fromMap(Map<String, dynamic> map) => MapsPageScreenParams(
    address: map['address'],
  );

  Map<String, dynamic> toMap() => {
    'address': address,
  };
}

class MapsPage extends StatefulWidget {
  final MapsPageScreenParams screenParams;

  const MapsPage({
    super.key,
    required this.screenParams,
  });

  @override
  State<MapsPage> createState() => MapSampleState();
}

class MapSampleState extends State<MapsPage> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  
  late LatLng currentPosition;
  late CameraPosition initialCameraPosition;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    currentPosition = (widget.screenParams.address?.latLng) ?? NearfleetConstants.initPosition;
    initialCameraPosition = CameraPosition(
      target: currentPosition,
      zoom: 14,
    );
  }

  void _onPositionChange(LatLng position) {
    setState(() {
      currentPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    final address = widget.screenParams.address;
    final fabTitleText =  (address == null) ? 'Save address' : 'Update address';

    final isLoading = context.watch<AddressesBloc>().state.isLoading;

    Widget fab = FloatingActionButton.extended(
      isExtended: !isLoading,
      label: isLoading ? const CircularProgressIndicator() : Text(fabTitleText),
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
        actions: [
          if (address != null)
            IconButton(
              onPressed: _onDeleteAddress,
              icon: const Icon(Icons.delete),
              tooltip: 'Delete Address',
            )
        ],
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
    final geoCode = getIt.get<geocode.GeoCode>();

    late geocode.Address geoAddress;

    try {
      geoAddress = await geoCode.reverseGeocoding(
        latitude: currentPosition.latitude,
        longitude: currentPosition.longitude
      );
    } catch (_) {
      if(!mounted) return;

      return Helpers.showSnackbar(
        context,
        message: 'Error, trying to obtain address',
        isAnErrorMessage: true,
      ); 
    }

    Address newAddress = AddressMapper.addressToEntity(geoAddress, currentPosition);
    
    late AddressResponse result;

    if( widget.screenParams.address != null) {
      newAddress = newAddress.copyWith(id: widget.screenParams.address?.id);
      result = await addressesBloc.updateAddress(newAddress);
    } else {
      result = await addressesBloc.createAddress(newAddress);
    }

    if (!mounted) return;

    final serverMsg = result.msg.nonNullValue();

    if (result.address == null) {
      return Helpers.showSnackbar(
        context,
        message: serverMsg,
        isAnErrorMessage: true,
      );
    }

    Helpers.showSnackbar(
      context,
      message: serverMsg,
    );

    context.pop();
  }

  void _onDeleteAddress() async {
    final addressesBloc = context.read<AddressesBloc>();
    final addressId = (widget.screenParams.address?.id);

    if(addressId == null) return;
    final wasSuccessfully = await addressesBloc.deleteAddress(addressId);

    if (!mounted) return;

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