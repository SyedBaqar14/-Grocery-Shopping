import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:grocery_shopping/logic/cubit/orders/orders_cubit.dart';
import 'package:grocery_shopping/routes/routes_names.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/src/provider.dart';
class DeliveredOrderCard extends StatelessWidget {
  const DeliveredOrderCard({Key? key, required this.result, required this.i})
      : super(key: key);
  final QueryResult result;
  final int i;
  @override
  Widget build(BuildContext context) {
    var d = result.data?['listOrdersFilters']['orders'];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Order#${d[i]['id'].toString()}",
                  style: GoogleFonts.montserrat(
                      color: kUniversalColor, fontSize: 15),
                ),
                Text(
                  d[i]['delivery_date'].toString(),
                  style: GoogleFonts.montserrat(
                      color: kUniversalColor, fontSize: 13),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  d[i]['order_status']['name'].toString(),
                  style:
                      GoogleFonts.montserrat(color: Colors.green, fontSize: 12),
                ),
                Row(
                  children: const [
                    Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                      size: 15,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                      size: 15,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                      size: 15,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                      size: 15,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(d[i]['shipping_address_1'])),
                Text(
                  "Amount: Rs ${d[i]['total']}",
                  style: GoogleFonts.montserrat(
                      color: kUniversalColor, fontSize: 15),
                )
              ],
            ),
            const Divider(),
            MaterialButton(
              minWidth: kIsWeb ? 300:double.infinity,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              onPressed: () {},
              color: kUniversalColor,
              child: Text(
                "Reorder",
                style: GoogleFonts.montserrat(color: Colors.white),
              ),
            ),
            Container(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  context
                      .read<OrdersCubit>()
                      .trackOrder(d[i]['id']);
                  Future.delayed(const Duration(seconds: 2),(){
                    Navigator.pushNamed(context, returnPage);
                  });
                },
                child: Text(
                  "Return",
                  style: GoogleFonts.montserrat(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
