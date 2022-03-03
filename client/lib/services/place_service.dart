import 'dart:io';


import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../conf.dart';
import '../models/location.dart';
import 'exception.dart';

class PlaceApiProvider {
  final client = Dio();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = APIKey;
  static final String iosKey = 'AIzaSyCyxrs2FWQ8pHgQMhS2rFDw-hPui1pLiAg';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    try {
      String url =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&components=country:ke&key=$apiKey&sessiontoken=$sessionToken';
      final response = await client.get(url);

      final result = response.data;
      return result['predictions']
          .map<Suggestion>((p) => Suggestion.fromJson(p))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Either<Place, ErrorMessage>> getPlaceDetailFromId(
      String placeId) async {
    try {
      final url =
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_components,name,geometry&key=$apiKey&sessiontoken=$sessionToken';
      final response = await client.get(url);
      print(response.data);
      final result = response.data;
      final components =
          result['result']['address_components'] as List<dynamic>;
      // build result
      final place = Place();
      //construct place from google map api result
      components.forEach((c) {
        final List type = c['types'];

        if (type.contains('route')) {
          place.street = c['long_name'];
        }
        if (type.contains('locality')) {
          place.city = c['long_name'];
        }
      });
      //set place name
      place.name = result['result']['name'];
      //longitude latitude
      double lat = result['result']['geometry']["location"]["lat"];
      double lng = result['result']['geometry']["location"]["lng"];
      place.latLng = LatLng(lat, lng);
      return Left(place);
    } catch (e) {
      print(e);
      return Right(getException(e));
    }
  }
}
