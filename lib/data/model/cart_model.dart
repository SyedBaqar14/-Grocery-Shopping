
class CartModel {
  int product_id;
  String name;
  String model;
  double price;
  String uom;
  int quantity;
  double total;
  int reward;

  CartModel(
      {
      required this.product_id,
      required this.name,
      required this.model,
      required this.price,
      required this.uom,
      required this.quantity,
      required this.total,
      required this.reward});

  Map toJson() =>
      {
        'product_id': product_id,
        'name': name,
        "model": model,
        "price": price,
        "uom": uom,
        "quantity": quantity,
        "total": total,
        "reward": reward
      };
}
