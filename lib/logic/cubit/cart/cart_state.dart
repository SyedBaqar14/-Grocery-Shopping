part of 'cart_cubit.dart';

class CartState {
  List<CartModel> cartList;
  List<String> imageList;
  double subTotal;
  double total;
  double deliveryCharges;
  double perQuantityTotal;
  double vat;
  int quantity;
  QueryResult? queryResultDeliveryCharges;

  CartState(
      {required this.cartList,
      required this.subTotal,
      required this.deliveryCharges,
      required this.perQuantityTotal,
      required this.imageList,
      required this.vat,
      required this.total,
      required this.queryResultDeliveryCharges,
      required this.quantity});

  CartState copywith(
      {List<CartModel>? cartList,
      List<String>? imageList,
      double? subTotal,
      double? deliveryCharges,
      double? perQuantityTotal,
      double? total,
      double? vat,
      int? quantity,
      QueryResult? queryResultDeliveryCharges}) {
    return CartState(
        cartList: cartList ?? this.cartList,
        imageList: imageList ?? this.imageList,
        subTotal: subTotal ?? this.subTotal,
        perQuantityTotal: perQuantityTotal ?? this.perQuantityTotal,
        deliveryCharges: deliveryCharges ?? this.deliveryCharges,
        vat: vat ?? this.vat,
        total: total ?? this.total,
        queryResultDeliveryCharges:
            queryResultDeliveryCharges ?? this.queryResultDeliveryCharges,
        quantity: quantity ?? this.quantity);
  }
}
