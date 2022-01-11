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
  String? street;
  String? city;
  String? name;
  LatLng? latLng;
  String country = "Kenya";

  Place({
    this.street,
    this.city,
    this.name,
    this.latLng,
  });

  @override
  String toString() {
    return 'Place( street: $street, city: $city,  latLng:$latLng, name:$name)';
  }

  Map<String, dynamic> toJson() {
    return {
      "street": street,
      "city": city,
      "name": name,
      "lat": latLng?.latitude,
      "lng": latLng?.longitude,
    };
  }

  factory Place.fromJson(Map<String, dynamic> json) {
    LatLng latLng = LatLng(json["lat"], json["lng"]);
    return Place(
      latLng: latLng,
      name: json["name"],
      street: json["street"],
      city: json["city"],
    );
  }
}
