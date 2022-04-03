part of 'checkout_cubit.dart';

class CheckOutState {
  QueryResult? queryResultAvailableDates;
  QueryResult? queryResultAddOrder;
  String loadingAvailableDates;
  String loadingForPlaceOrder;
  String dilveryDate;
  String selectedTime;
  List<bool> isSelected;
  List<Suggestion> suggestionsList;
  String locationDiscription;
  double lat;
  double lng;
  String? placeID;
  bool isLoading;

  CheckOutState(
      {required this.queryResultAvailableDates,
      required this.loadingAvailableDates,
      required this.dilveryDate,
      required this.selectedTime,
      required this.isSelected,
      required this.loadingForPlaceOrder,
      required this.queryResultAddOrder,
      required this.suggestionsList,
      required this.lat,
      required this.lng,
      required this.locationDiscription,
      required this.placeID,
      required this.isLoading});

  CheckOutState copywith(
      {QueryResult? queryResultAvailableDates,
      QueryResult? queryResultAddOrder,
      String? loadingAvailableDates,
      String? dilveryDate,
      String? selectedTime,
      List<bool>? isSelected,
      String? loadingForPlaceOrder,
      List<Suggestion>? suggestionsList,
      String? locationDiscription,
      double? lat,
      double? lng,
      String? loadingSuggestion,
      String? placeID,
      bool? isLoading}) {
    return CheckOutState(
        queryResultAvailableDates:
            queryResultAvailableDates ?? this.queryResultAvailableDates,
        dilveryDate: dilveryDate ?? this.dilveryDate,
        loadingAvailableDates:
            loadingAvailableDates ?? this.loadingAvailableDates,
        selectedTime: selectedTime ?? this.selectedTime,
        isSelected: isSelected ?? this.isSelected,
        loadingForPlaceOrder: loadingForPlaceOrder ?? this.loadingForPlaceOrder,
        queryResultAddOrder: queryResultAddOrder ?? this.queryResultAddOrder,
        suggestionsList: suggestionsList ?? this.suggestionsList,
        locationDiscription: locationDiscription ?? this.locationDiscription,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
        placeID: placeID ?? this.placeID,
        isLoading: isLoading ?? this.isLoading);
  }
}
