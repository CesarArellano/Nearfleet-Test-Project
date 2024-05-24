import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({super.key});

  @override
  State<MapsPage> createState() => MapSampleState();
}

class MapSampleState extends State<MapsPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  
  LatLng currentPosition = const LatLng(37.77483, -122.41942); // Initial center coordinates

  final CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(37.77483, -122.41942),
    zoom: 14.4746,
  );

  void _onCameraMove(CameraPosition position) {
    setState(() {
      currentPosition = position.target;
    });
  }

  void _onPositionChange(LatLng position) {
    setState(() {
      currentPosition = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps Page'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        mapType: MapType.normal,
        zoomControlsEnabled: false,
        initialCameraPosition: initialCameraPosition,
        markers: { Marker(position: currentPosition, markerId: const MarkerId('unique-maker'))},
        onCameraMove: _onCameraMove,
        onTap: _onPositionChange,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _onSubmit,
        label: const Text('Save address'),
        icon: const Icon(Icons.save),
        
      ),
    );
  }

  Future<void> _onSubmit() async {
    log('Position: $currentPosition');
  }
}