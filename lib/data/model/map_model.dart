// for places lat long
class Place {
  String formattedAddress;
  double lat;
  double lng;


  Place({required this.formattedAddress,required this.lat, required this.lng});

  @override
  String toString() {
    return 'Place(formattedAddress: $formattedAddress, latitude: $lat, longitude: $lng)';
  }
}

// For autoComplete
class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}