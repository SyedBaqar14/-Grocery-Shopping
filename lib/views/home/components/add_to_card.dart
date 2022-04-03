import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:line_icons/line_icons.dart';
import 'package:grocery_shopping/logic/cubit/cart/cart_cubit.dart';

// ignore: must_be_immutable
class AddToCart extends StatelessWidget {
  AddToCart({
    Key? key,
    required this.d,
    required this.index,
    required this.itemQty,
    required this.initQuantity,
  }) : super(key: key);

  int itemQty;
  bool initQuantity;
  final d;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (itemQty > 1) {
              initQuantity = false;
              itemQty -= 1;
              BlocProvider.of<CartCubit>(context)
                  .decrementQuantity(quantity: itemQty);
            }
          },
          child: CircleAvatar(
            backgroundColor: Colors.grey[300],
            minRadius: 15,
            maxRadius: 20,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                LineIcons.minus,
                size: 20,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        BlocBuilder<CartCubit, CartState>(builder: (context, state) {
          return Text("${initQuantity ? 1 : state.quantity}");
        }),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            itemQty++;
            initQuantity = false;
            BlocProvider.of<CartCubit>(context, listen: false)
                .incrementQuantity(quantity: itemQty);
          },
          child: const CircleAvatar(
            backgroundColor: kUniversalColor,
            minRadius: 15,
            maxRadius: 20,
            // elevation: 3.0,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                LineIcons.plus,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            height: 40,
            color: kUniversalColor,
            onPressed: () {
              var price = d[index]['price'];
              double dPrice = price.toDouble();
              final cartCubit = BlocProvider.of<CartCubit>(context);
              cartCubit.addToCart(
                  productID: d[index]['id'],
                  productName: d[index]['model'].length > 20
                      ? d[index]['model'].substring(0, 20)
                      : d[index]['model'],
                  price: dPrice,
                  quantity: itemQty,
                  image: d[index]['image'],
                  reward: 0,
                  uom: "");
              Navigator.pop(context);
              Fluttertoast.showToast(msg: "Item Added to Cart");
            },
            child: const Text(
              "Add To Cart",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
