class ProductModel{

  int id;
  String name;
  String description;
  double price;
  int discount;
  bool isAddedFav;
  String Image;

  ProductModel({required this.id,required this.name,
    required this.description, required this.price,
    required this.discount,required this.Image,required this.isAddedFav});

}