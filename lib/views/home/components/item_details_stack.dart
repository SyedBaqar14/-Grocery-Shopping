import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/logic/cubit/home/home_cubit.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:html/parser.dart';

class ItemDetailsStack extends StatefulWidget {
  const ItemDetailsStack(
      {Key? key, required this.productResult, required this.index})
      : super(key: key);

  final QueryResult productResult;
  final int index;

  @override
  State<ItemDetailsStack> createState() => _ItemDetailsStackState();
}

class _ItemDetailsStackState extends State<ItemDetailsStack> {

  bool isFav = false;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    final cubitAuth = BlocProvider.of<AuthenticationCubit>(context);
    final data = widget.productResult.data?['listProductsFilter'];
    var d = data['products'];
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        height: 140,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        d[widget.index]['description']['name'],
                        style: GoogleFonts.montserrat(fontSize: 20),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isFav = !isFav;
                        });
                        cubit.addToFav(d[widget.index]['id'],
                            cubitAuth.getuserID);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.favorite,
                          color: isFav ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Rs${d[widget.index]['price'].toString()}",
                      style: GoogleFonts.montserrat(color: kUniversalColor),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "/kg",
                      style: GoogleFonts.montserrat(color: Colors.grey),
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: kUniversalColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "-Rs ${d[widget.index]['discount_price']}",
                        style: GoogleFonts.montserrat(color: kUniversalColor),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Rs ${d[widget.index]['discount_price'] == 0 ? '0' : '0'}",
                      style: GoogleFonts.montserrat(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
