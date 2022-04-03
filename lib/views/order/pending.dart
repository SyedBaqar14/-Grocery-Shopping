import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/logic/cubit/orders/orders_cubit.dart';
import 'package:grocery_shopping/routes/routes_names.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
class PendingOrders extends StatefulWidget {
  const PendingOrders({Key? key}) : super(key: key);

  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {

  bool isLoading = false;
  refres()async{
    final cubit = BlocProvider.of<OrdersCubit>(context, listen: false);
    final authCub = BlocProvider.of<AuthenticationCubit>(context, listen: false);
    await cubit.getPendingOrders(authCub.getuserID);
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
          body: isLoading ? Center(child: CupertinoActivityIndicator(),):RefreshIndicator(
            onRefresh: (){
              setState(() {
                isLoading = true;
              });
              return refres();
            },
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: state.pendingOrderState == 'searching'
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    :state.pendingOrderState == 'Please Login to See Data' ? Center(child: Text(state.pendingOrderState.toString()),): ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                        itemCount: state.pendingOrdersResult!
                            .data?['listOrdersFilters']['orders'].length,
                        // physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (ctx, i) {
                          final data = state
                              .pendingOrdersResult!.data?['listOrdersFilters'];
                          var d = data['orders'];
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: InkWell(
                              onTap: () {
                                context
                                    .read<OrdersCubit>()
                                    .trackOrder(d[i]['id']);
                                Navigator.pushNamed(context, orderTracking);
                              },
                              child: Container(
                                height: kIsWeb ? 100 : 100,
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
                                              d[i]['order_status']['name']
                                                  .toString(),
                                              style: GoogleFonts.montserrat(
                                                  color: Colors.green,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                child: Text(
                                                    d[i]['shipping_address_1'])),
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
                            ),
                          );
                        },
                      )),
          ),
        );
      },
    );
  }
}
