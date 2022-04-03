
import 'dart:convert';
import 'dart:io';

import 'package:grocery_shopping/data/model/map_model.dart';
import 'package:http/http.dart';

class PlaceApiProvider {
  final client = Client();

  static final String androidKey = 'AIzaSyBVY5x_t23MvVUr-d3sdb28yuBPXofAF5A';
  static final String iosKey = 'AIzaSyBVY5x_t23MvVUr-d3sdb28yuBPXofAF5A';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:pk&key=$apiKey';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        print(result['status']);
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&geometry&key=$apiKey';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        final place = Place(
            formattedAddress: result['result']['formatted_address'],
            lat: result['result']['geometry']['location']['lat'],
            lng: result['result']['geometry']['location']['lng']);

        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}