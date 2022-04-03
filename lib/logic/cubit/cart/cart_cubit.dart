import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:grocery_shopping/data/model/cart_model.dart';
import 'package:grocery_shopping/data/repository/checkout_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit()
      : super(CartState(
            cartList: [],
            subTotal: 0,
            deliveryCharges: 0,
            perQuantityTotal: 0,
            imageList: [],
            total: 0,
            vat: 0,
            queryResultDeliveryCharges: null,
            quantity: 1));

  static final List<CartModel> cartList = [];
  static final List<String> imageList = [];
  static double subTotal = 0;
  // static double vat = 0;
  // static double total = 0;

  final repository = CheckOutRepository();

  applyCoupon({required String couponCode, required int customerID}) {

    final map = mapProductList(couponCode: couponCode, customerID: customerID);

    print(map);
    repository.applyCoupon(variables: map).then((value) {
      print(value);
    });
  }

  Map<String, dynamic> mapProductList({required String couponCode, required int customerID}) {

    final body = Map<String, dynamic>();

    body["customerID"] = customerID;
    body["orderTotal"] = state.subTotal;
    body["couponCode"] = couponCode;

    state.cartList.forEach((element) {
      int productID = element.product_id;
      double total = element.total;

      body['products'] = [
        {
          "product_id": productID,
          "total": total
        }
      ];
    });

    return body;
  }

  incrementQuantity({required int quantity}) {
    emit(state.copywith(quantity: quantity));
  }

  decrementQuantity({required int quantity}) {
    emit(state.copywith(quantity: quantity));
  }

  resetCart() {
    cartList.clear();
    imageList.clear();
    subTotal = 0;
    emit(CartState(
        cartList: [],
        subTotal: 0,
        deliveryCharges: 0,
        perQuantityTotal: 0,
        imageList: [],
        total: 0,
        vat: 0,
        queryResultDeliveryCharges: null,
        quantity: 1));
  }

  setDeliveryFee() async {
    final result = await repository.getDeliveryFee();
    emit(state.copywith(queryResultDeliveryCharges: result));
    final String dFee = state.queryResultDeliveryCharges!.data!['getSetting']['value'];
    final double preVat = (state.subTotal * 0.05);
    final double vat = double.parse((preVat).toStringAsFixed(2));
    final double total = (state.subTotal + double.parse(dFee) + vat);
    emit(state.copywith(deliveryCharges: double.parse(dFee), total: total, vat: vat));
  }

  addToCart(
      {required int productID,
      required String productName,
      required double price,
      required int quantity,
      required String image,
      required int reward,
      required String uom}) {
    if (state.cartList.isEmpty) {

      subTotal += (price * quantity);

      // state.perQuantityTotal = (price * quantity);
      cartList.add(CartModel(
          product_id: productID,
          name: productName,
          model: productName,
          uom: uom,
          price: price,
          quantity: quantity,
          total: (price * quantity),
          reward: reward));
      imageList.add(image);

      // updating the state
      emit(state.copywith(
          cartList: cartList,
          imageList: imageList,
          subTotal: subTotal));

      setDeliveryFee();

    } else {
      for (int j = 0; j < cartList.length; j++) {
        if (productID == cartList[j].product_id) {
          return;
        }
      }
      // state.perQuantityTotal = (price * quantity);
      subTotal += (price * quantity);
      final double preVat = (subTotal * 0.05);
      final double vat = double.parse((preVat).toStringAsFixed(2));
      final double total = (subTotal + state.deliveryCharges + vat);
      cartList.add(CartModel(
          product_id: productID,
          name: productName,
          model: productName,
          uom: uom,
          price: price,
          quantity: quantity,
          total: (price * quantity),
          reward: reward));
      imageList.add(image);

      // updating the state
      emit(state.copywith(
          cartList: cartList,
          imageList: imageList,
          subTotal: subTotal,
          vat: vat,
          total: total));
    }
  }

  increaseQuantity({required int index}) {
    cartList[index].quantity += 1;
    cartList[index].total += state.cartList[index].price;
    subTotal += cartList[index].price;
    final double preVat = (subTotal * 0.05);
    final double vat = double.parse((preVat).toStringAsFixed(2));
    final double total = (subTotal + state.deliveryCharges + vat);
    emit(state.copywith(cartList: cartList, subTotal: subTotal, total: total,
    vat: vat));
  }

  decreaseQuantity({required int index}) {
    if (cartList[index].quantity > 1) {
      cartList[index].quantity -= 1;
      cartList[index].total -= state.cartList[index].price;
      subTotal -= cartList[index].price;
      final double preVat = (subTotal * 0.05);
      final double vat = double.parse((preVat).toStringAsFixed(2));
      final double total = (subTotal + state.deliveryCharges + vat);
      emit(state.copywith(cartList: cartList, subTotal: subTotal, total: total,
      vat: vat));
    }
  }

  deleteItem({required int index}) {
    if (cartList.isNotEmpty) {
      // totalPrice = state.totalPrice -
      //     (state.cartList[index].price * state.cartList[index].quantity);
      subTotal = (state.subTotal - state.cartList[index].total);
      if(state.cartList.length == 1) {
        const double vat = 0;
        final double total = (subTotal + 0 + vat);
        cartList.removeAt(index);
        imageList.removeAt(index);
        emit(state.copywith(cartList: cartList, imageList: imageList,
            subTotal: subTotal, total: total, vat: vat, deliveryCharges: 0));
      } else {
        final double preVat = (subTotal * 0.05);
        final double vat = double.parse((preVat).toStringAsFixed(2));
        final double total = (subTotal + state.deliveryCharges + vat);
        cartList.removeAt(index);
        imageList.removeAt(index);
        emit(state.copywith(cartList: cartList, imageList: imageList,
            subTotal: subTotal, total: total, vat: vat));
      }
    }
  }

}
