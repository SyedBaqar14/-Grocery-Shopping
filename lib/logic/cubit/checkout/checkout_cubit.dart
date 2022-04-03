import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:grocery_shopping/data/model/cart_model.dart';
import 'package:grocery_shopping/data/model/map_model.dart';
import 'package:grocery_shopping/data/repository/checkout_repository.dart';
import 'package:grocery_shopping/utils/gql_quries.dart';

part 'checkout_state.dart';

class CheckOutCubit extends Cubit<CheckOutState> {
  CheckOutCubit()
      : super(CheckOutState(
            queryResultAvailableDates: null,
            queryResultAddOrder: null,
            loadingAvailableDates: "Loading",
            dilveryDate: "",
            selectedTime: "",
            isSelected: [],
            loadingForPlaceOrder: "Loading",
            suggestionsList: [],
            locationDiscription: "",
            lat: 0,
            lng: 0,
            placeID: null,
            isLoading: false));

  static final List<bool> isSelected = [];

  final repository = CheckOutRepository();

  addAddress(
      {required int customerID,
      required String lat,
      required String lng,
      required String addressLine}) async {
    print("customerID: $customerID");
    await repository.addAddress(variables: {
      "customerID": customerID,
      "lat": lat,
      "lng": lng,
      "addressLine": addressLine
    }).then((value) {
      print(value);
    });
  }

  assignDate({required String date}) {
    emit(state.copywith(dilveryDate: date));
  }

  selectedDate({required String selectedTime, required int index}) {
    isSelected.clear();
    for (int x = 0;
        x <
            state.queryResultAvailableDates!.data!['listDeliveryAvailableSlots']
                ['total_count'];
        x++) {
      isSelected.add(false);
    }

    isSelected[index] = true;
    emit(state.copywith(selectedTime: selectedTime, isSelected: isSelected));
    print("${state.selectedTime}, ${state.isSelected[index]}");
  }

  checkForAvailableDates() {
    print(state.loadingAvailableDates);
    repository.checkForAvailableDates(
        variable: {"deliveryDate": state.dilveryDate}).then((value) {
      isSelected.clear();
      print(value);
      for (int i = 0;
          i < value.data!['listDeliveryAvailableSlots']['total_count'];
          i++) {
        isSelected.add(false);
      }
      emit(state.copywith(
          queryResultAvailableDates: value,
          loadingAvailableDates: "Loaded",
          isSelected: isSelected));
    });
  }

  getSuggestions(String searchInput, String lang) async {
    List<Suggestion> suggestionList = await repository.searchSuggestionMap(
        searchInput: searchInput, lang: lang);
    emit(state.copywith(suggestionsList: suggestionList));
  }

  loadingSuggestions() {
    emit(state.copywith(isLoading: false));
    // emit(state.copywith(suggestionsList: []));
  }

  setLocationDiscription({required String discription}) {
    emit(state.copywith(locationDiscription: discription));
  }

  Future<bool> getPlaceDetails(
      {required String placeID, required String description}) async {
    Place place = await repository.getPlaceDetailsMap(placeID: placeID);
    print("checkoutCubit: lat: ${place.lat} lng: ${place.lng}");
    emit(state.copywith(
      lng: place.lng,
      lat: place.lat,
      placeID: placeID,
      suggestionsList: [],
      locationDiscription: description,
      isLoading: true,
    ));

    return true;
  }

  resetPlaceID() {
    emit(state.copywith(placeID: null));
  }

  restSuggestionList() {
    emit(state.copywith(suggestionsList: []));
  }

  Map<String, dynamic> orderList(
      {customerID,
      required List<CartModel> productList,
      shippingMethod,
      total,
      paymentMethod,
      shippingLat,
      shippingLng}) {
    Map<String, dynamic> body = {
      "customerID": customerID,
      "shippingLat": shippingLat,
      "shippingLng": shippingLng,
      "deliveryDate": state.dilveryDate,
      "deliveryTime": state.selectedTime,
      "shippingMethod": shippingMethod,
      "total": total,
      "paymentMethod": paymentMethod
    };

    int i = 0;
    productList.forEach((element) {
      int productID = element.product_id;
      String productName = element.name;
      String uom = element.uom;
      String model = element.model;
      int quantity = element.quantity;
      int reward = element.reward;
      double total = element.total;
      double price = element.price;

      body['products'] = [
        CartModel(
                product_id: productID,
                name: productName,
                model: model,
                price: price,
                uom: uom,
                quantity: quantity,
                total: total,
                reward: reward)
            .toJson()
      ];
    });
    return body;
  }

  placeOrder(
      {required int customerID,
      required List<CartModel> productList,
      required String shippingMethod,
      required double total,
      required String paymentMethod,
      required String shippingLat,
      required String shippingLng}) {
    print("customerID: $customerID");
    final Map<String, dynamic> variable = orderList(
        customerID: customerID,
        productList: productList,
        shippingMethod: shippingMethod,
        total: total,
        paymentMethod: paymentMethod,
        shippingLat: shippingLat,
        shippingLng: shippingLng);

    repository.placeOrder(variables: variable).then((value) {
      print(value);
      emit(state.copywith(
          queryResultAddOrder: value, loadingForPlaceOrder: "Loaded"));
      print(state.loadingForPlaceOrder);
    });
  }
}
