import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:grocery_shopping/data/model/map_model.dart';
import 'package:grocery_shopping/data/providers/checkout_provider.dart';
import 'package:grocery_shopping/data/providers/map_autocomplete_provider.dart';

class CheckOutRepository {
  final checkoutProvider = CheckOutProvider();

  Future<QueryResult> checkForAvailableDates(
      {required variable}) async {
    final result = checkoutProvider.checkAvailableDates(variable);
    return result;
  }

  Future<QueryResult> placeOrder({required variables}) {
    final result = checkoutProvider.placeOrder(varialbes: variables);
    return result;
  }

  Future<QueryResult> applyCoupon({required variables}) {
    final result = checkoutProvider.applyCoupon(variables: variables);
    return result;
  }

  Future<QueryResult> getDeliveryFee() {
    final result = checkoutProvider.getDeliveryFee();
    return result;
  }

  Future<List<Suggestion>> searchSuggestionMap({required String searchInput, required String lang}) {

    final suggestion = PlaceApiProvider().fetchSuggestions(searchInput, lang);

    return suggestion;
  }

  Future<Place> getPlaceDetailsMap({required String placeID}) async {

    final Place place = await PlaceApiProvider().getPlaceDetailFromId(placeID);

    return place;
  }

  Future<QueryResult> addAddress({required variables}) async {
    final result = await checkoutProvider.addAddress(variables: variables);
    return result;
  }
}
