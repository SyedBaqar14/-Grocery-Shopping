import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/logic/cubit/orders/orders_cubit.dart';
import 'package:grocery_shopping/utils/constants.dart';

class CanceledOrders extends StatefulWidget {
  const CanceledOrders({Key? key}) : super(key: key);

  @override
  _CanceledOrdersState createState() => _CanceledOrdersState();
}

class _CanceledOrdersState extends State<CanceledOrders> {
  bool isLoading = false;
  refres()async{
    print(" ccccc");
    final cubit = BlocProvider.of<OrdersCubit>(context, listen: false);
    final authCub = BlocProvider.of<AuthenticationCubit>(context, listen: false);
    await cubit.getDliveredOrders(authCub.getuserID);
    setState(() {
      isLoading = false;
    });
    print("Okay");

  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: state.canceledOrdersStatus == 'searching'
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.canceledOrdersStatus == 'Please Login to See Data' ? Center(child: Text(state.canceledOrdersStatus.toString()),):RefreshIndicator(
              onRefresh: (){
                setState(() {
                  isLoading = true;
                });
                return refres();
              },
                  child: ListView.builder(
                      itemCount: state.canceledOrdersResult!
                          .data?['listOrdersFilters']['orders'].length,
                      // physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx, i) {
                        final data = state
                            .canceledOrdersResult!.data?['listOrdersFilters'];
                        var d = data['orders'];
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: InkWell(
                            onTap: () {},
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Order#${d[i]['id'].toString()}",
                                          style: GoogleFonts.montserrat(
                                              color: kUniversalColor,
                                              fontSize: 15),
                                        ),
                                        Text(
                                          d[i]['delivery_date'].toString(),
                                          style: GoogleFonts.montserrat(
                                              color: kUniversalColor,
                                              fontSize: 13),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          d[i]['order_status']['name'].toString(),
                                          style: GoogleFonts.montserrat(
                                              color: Colors.green, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child:
                                                Text(d[i]['shipping_address_1'])),
                                        Text(
                                          "Amount: Rs ${d[i]['total']}",
                                          style: GoogleFonts.montserrat(
                                              color: kUniversalColor,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ),
          ),
        );
      },
    );
  }
}
