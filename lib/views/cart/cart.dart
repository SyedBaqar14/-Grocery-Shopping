import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/logic/cubit/cart/cart_cubit.dart';
import 'package:grocery_shopping/routes/routes_names.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:grocery_shopping/views/bottom_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  static Widget priceWidget({required String price}) {
    return Row(
      children: [
        Text(
          price,
          style: GoogleFonts.montserrat(color: kUniversalColor),
        ),
        Text(
          "/kg",
          style: GoogleFonts.montserrat(color: Colors.grey),
        )
      ],
    );
  }

  // List<CartModel> cartModel = [
  //   CartModel(
  //     title: "Carrots",
  //     image: "assets/carr.png",
  //     price: priceWidget(),
  //     currPrice: "Rs 120.00",
  //   ),
  //   CartModel(
  //     title: "Herb",
  //     image: "assets/herb.png",
  //     price: priceWidget(),
  //     currPrice: "Rs 250.00",
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocBuilder<CartCubit, CartState>(builder: (context, state) {
          if(state.cartList.isEmpty){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/cart.png"),
                Text("Your Cart Is Empty",style: GoogleFonts.montserrat(color: kUniversalColor,fontSize: 22),),
                const SizedBox(height: 20,),
                Text("It's look like you haven't added anything to your cart yet",style: GoogleFonts.montserrat(color: Colors.grey,fontSize: 18),textAlign: TextAlign.center,),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width - 100,
                  color: kUniversalColor,
                  shape: const StadiumBorder(),
                  onPressed: ()=> Navigator.pushReplacementNamed(context, bottomNavBar),
                  child: Text("SHOP NOW",style: GoogleFonts.montserrat(color: Colors.white),),
                )
              ],
            );
          }
            return SingleChildScrollView(
              physics: const ScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.cartList.length,
                    itemBuilder: (ctx, i) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 12.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: kFiledColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            image: DecorationImage(
                                                fit: BoxFit.fill,
                                                image: NetworkImage(
                                                    state.imageList[i]))),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(state.cartList[i].name.length > 20? state.cartList[i].name.substring(0,20) : state.cartList[i].name),
                                          priceWidget(
                                              price:
                                              "Rs ${state.cartList[i].price}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        BlocProvider.of<CartCubit>(context)
                                            .deleteItem(index: i);
                                      },
                                      child: const Icon(
                                        Icons.clear,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            BlocProvider.of<CartCubit>(context)
                                                .decreaseQuantity(index: i);
                                          },
                                          child: Container(
                                            // padding: const EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              border: Border.all(
                                                width: 1.5,
                                                color: kUniversalColor,
                                              ),
                                            ),
                                            child: const Icon(
                                              LineIcons.minus,
                                              color: kUniversalColor,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: const Color(0xffE4F9E8),
                                              borderRadius:
                                              BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              state.cartList[i].quantity.toString(),
                                              style: GoogleFonts.montserrat(
                                                  color: kUniversalColor),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            BlocProvider.of<CartCubit>(context)
                                                .increaseQuantity(index: i);
                                          },
                                          child: Container(
                                            // padding: const EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              border: Border.all(
                                                width: 1.5,
                                                color: kUniversalColor,
                                              ),
                                            ),
                                            child: const Icon(
                                              LineIcons.plus,
                                              color: kUniversalColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Rs ${state.cartList[i].total}",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.grey),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Subtotal"),
                      Text("Rs ${state.subTotal}"),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Delivery fee"),
                      Text("Rs ${state.deliveryCharges}"),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("VAT"),
                      Text("Rs ${state.vat}"),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        LineIcons.tag,
                        color: kUniversalColor,
                      ),
                      SizedBox(width: 5),
                      InkWell(
                        onTap: () {
                          // BlocProvider.of<CartCubit>(context).addToCart(
                          //     productID: 225,
                          //     productName: "product 1",
                          //     price: 17.00,
                          //     quantity: 2,
                          //     image: "url",
                          //     deliveryFee: 100.00,
                          //     reward: 0,
                          //     uom: "pc");

                          BlocProvider.of<CartCubit>(context).applyCoupon(couponCode: "xyz", customerID: 1);
                        },
                        child: Text(
                          "Apply a voucher",
                          style: GoogleFonts.montserrat(
                            color: kUniversalColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total",
                          style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w500)),
                      Text("Rs ${state.total}",
                          style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  SizedBox(height: 20),
                  MaterialButton(
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    minWidth: double.infinity,
                    color: kUniversalColor,
                    onPressed: () => Navigator.pushNamed(context, checkOut),
                    child: Text(
                      "Review payment and address",
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
        }),
      ),
    );
  }
}


// class CartModelOld {
//   String title;
//   String image;
//   Widget price;
//   String currPrice;
//
//   CartModelOld(
//       {required this.title,
//       required this.image,
//       required this.price,
//       required this.currPrice});
// }
