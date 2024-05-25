import 'package:geocode/geocode.dart' as geocode;
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

import '../../config/extensions/null_extensions.dart';
import '../../domain/entities/entities.dart';

class AddressMapper {
  static Address addressToEntity(geocode.Address geocodeAddress, LatLng latLng) => Address(
    city: geocodeAddress.city,
    country: geocodeAddress.countryName.nonNullValueEmpty(geocodeAddress.countryCode.nonNullValue()),
    state: geocodeAddress.region,
    street: geocodeAddress.streetAddress.nonNullValueEmpty(geocodeAddress.streetNumber.nonNullValue().toString()),
    zipCode: geocodeAddress.postal.nonNullValue(),
    latitude: latLng.latitude,
    longitude: latLng.longitude,
  );
}