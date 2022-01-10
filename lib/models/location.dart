// For storing our result
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(json["place_id"], json["description"]);
  }
}

class Place {
  String? streetNumber;
  String? street;
  String? city;
  String? zipCode;
  String? name;
  LatLng? latLng;
  String country = "Kenya";

  Place({
    this.streetNumber,
    this.street,
    this.city,
    this.zipCode,
    this.name,
    this.latLng,
  });

  @override
  String toString() {
    return 'Place(streetNumber: $streetNumber, street: $street, city: $city, zipCode: $zipCode, latLng:$latLng, name:$name)';
  }

  Map<String, dynamic> toMap() {
    return {
      "street": street,
      "city": city,
      "country": country,
      "zip_code": zipCode,
      "street_number": streetNumber,
      "name": name,
      "geometry": {
        "lat": latLng?.latitude,
        "lng": latLng?.longitude,
      }
    };
  }

  factory Place.fromJson(Map<String, dynamic> json) {
    LatLng latLng = LatLng(json["lat"], json["lng"]);
    return Place(
      latLng: latLng,
      name: json["name"],
      street: json["street"],
      city: json["city"],
      zipCode: json["zip_code"],
      streetNumber: json["street_number"],
    );
  }
}
