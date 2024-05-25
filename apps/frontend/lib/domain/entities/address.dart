import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nearfleet_app/config/extensions/null_extensions.dart';

class AddressResponse {
  final String? msg;
  final Address? address;
  final List<Address>? results;

  AddressResponse({
    this.msg,
    this.address,
    this.results,
  });

  factory AddressResponse.withErrorMessage() => AddressResponse(
    msg: 'Server error, talk to the system admin',
  );

  factory AddressResponse.fromJson(Map<String, dynamic> json) => AddressResponse(
    msg: json["msg"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    results: json["addreses"] == null ? [] : List<Address>.from(json["addreses"]?.map((x) => Address.fromJson(x))),
  );
}

class Address {
  final int? id;
  final String? pseudonym;
  final String? street;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? country;
  final double? latitude;
  final double? longitude;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Address({
    this.id,
    this.pseudonym,
    this.street,
    this.city,
    this.state,
    this.zipCode,
    this.country,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
  });

  Address copyWith({
    int? id,
    dynamic pseudonym,
    String? street,
    String? city,
    String? state,
    String? zipCode,
    String? country,
    double? latitude,
    double? longitude,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => 
  Address(
      id: id ?? this.id,
      pseudonym: pseudonym ?? this.pseudonym,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    pseudonym: json["pseudonym"],
    street: json["street"],
    city: json["city"],
    state: json["state"],
    zipCode: json["zip_code"],
    country: json["country"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "pseudonym": pseudonym,
    "street": street,
    "city": city,
    "state": state,
    "zip_code": zipCode,
    "country": country,
    "latitude": latitude,
    "longitude": longitude,
  };

  LatLng get latLng => LatLng(latitude.nonNullValue(), longitude.nonNullValue());
}