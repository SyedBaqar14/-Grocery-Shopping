import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/logic/cubit/orders/orders_cubit.dart';
import 'package:grocery_shopping/utils/config/asset_config.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:grocery_shopping/views/cart/cart.dart';
import 'package:grocery_shopping/views/components/asset_provider.dart';
import 'package:grocery_shopping/views/order/shimmer/orders_shimmer.dart';
import 'package:intl/intl.dart';
class OrderTracking extends StatefulWidget {
  const OrderTracking({Key? key}) : super(key: key);

  @override
  _OrderTrackingState createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  static Widget priceWidget() {
    return Row(
      children: [
        Text(
          "Rs120.00",
          style: GoogleFonts.montserrat(color: kUniversalColor),
        ),
        Text(
          "/kg",
          style: GoogleFonts.montserrat(color: Colors.grey),
        )
      ],
    );
  }


  final f = DateFormat('yyyy-MM-dd hh:mm');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: ()=>Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios,color: Colors.black,),
            ),
            title: const Text(
              "Order Tracking",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: state.trackOrderStatus == "searching"
                  ? OrdersShimmer().trackOrderShimmer(context)
                  : Column(children: [
                        const Center(
                            child: AssetProvider(
                          asset: AssetConfig.kVerifyEmailPageImage,
                          height: 250,
                          width: 250,
                        )),
                        const SizedBox(height: 10),
                        Text(
                            state.trackOrderResult!.data?['getOrder']
                                ['date_added_format'],
                            style:
                                GoogleFonts.montserrat(color: kUniversalColor)),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.circle,
                                color: state.trackOrderResult!.data?['getOrder']
                                            ['order_status']['name'] ==
                                        "Pending"
                                    ? kUniversalColor
                                    : Colors.grey,
                              ),
                              Expanded(
                                child: Container(
                                  height: 3,
                                  color:
                                      state.trackOrderResult!.data?['getOrder']
                                                  ['order_status']['name'] ==
                                              "ReadyToShip"
                                          ? kUniversalColor
                                          : Colors.grey,
                                ),
                              ),
                              Icon(
                                Icons.circle,
                                color: state.trackOrderResult!.data?['getOrder']
                                            ['order_status']['name'] ==
                                        "ReadyToShip"
                                    ? kUniversalColor
                                    : Colors.grey,
                              ),
                              Expanded(
                                child: Container(
                                  height: 3,
                                  color:
                                      state.trackOrderResult!.data?['getOrder']
                                                  ['order_status']['name'] ==
                                              "OnTheWay"
                                          ? kUniversalColor
                                          : Colors.grey,
                                ),
                              ),
                              Icon(
                                Icons.circle,
                                color: state.trackOrderResult!.data?['getOrder']
                                            ['order_status']['name'] ==
                                        "OnTheWay"
                                    ? kUniversalColor
                                    : Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              "Order\nConfirmed",
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Ready\nto Ship",
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "On\nthe way",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.trackOrderResult!
                              .data?['getOrder']['order_products'].length,
                          itemBuilder: (ctx, i) {
                            var d = state.trackOrderResult!.data?['getOrder']
                                ['order_products'][i];
                            return Padding(
                              padding: const EdgeInsets.only(
                                top: 12.0,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 60,
                                            width: 60,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        d['product']
                                                            ['image']))),
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(d['name']),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Rs ${d['price']}",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            color:
                                                                kUniversalColor),
                                                  ),
                                                  Text(
                                                    "/kg",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                            color: Colors.grey),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.trackOrderResult!
                              .data?['getOrder']['order_totals'].length,
                          itemBuilder: (ctx, i) {
                            var d = state.trackOrderResult!.data?['getOrder']
                                ['order_totals'][i];
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(d['text']),
                                    Text(d['value'].toString()),
                                  ],
                                ),
                                const SizedBox(height: 10),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
