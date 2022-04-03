import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/logic/cubit/home/home_cubit.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:grocery_shopping/views/home/components/item_bottom_sheet.dart';

class ProductsCard extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ProductsCard({Key? key, required this.data, required this.i}) : super(key: key);
  final QueryResult data;
  final int i;

  @override
  State<ProductsCard> createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  int? index;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    final cubitAuth = BlocProvider.of<AuthenticationCubit>(context);
    var d = widget.data.data?['listProductsFilter']['products'];
    return BlocBuilder<HomeCubit,HomeState>(
      builder: (context,state){
        return InkWell(
          onTap: () {
            cubit.assignIndex(widget.i);
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              isScrollControlled: true,
              context: context,
              builder: (context) => Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: ItemBottomSheet(
                  result: widget.data,
                  index: widget.i,
                ),
              ),
            );
          },
          child: SizedBox(
            height: 300,
            child: Card(
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: SizedBox(
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(state.products![widget.i].Image))),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        cubit.removeAddFavState(widget.i);
                                        setState(() {
                                          index = widget.i;
                                        });
                                        cubit.addToFav(state.products![widget.i].id,
                                            cubitAuth.getuserID);
                                        // cubit.refreshProduct(int.parse(cubitAuth.getuserID));
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.favorite,
                                          color: state.products![widget.i].isAddedFav ?
                                          Colors.red
                                              : Colors.grey,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.products![widget.i].name),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                "Rs${state.products![widget.i].price}",
                                style:
                                GoogleFonts.montserrat(color: kUniversalColor),
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
                                    "-Rs${state.products![widget.i].discount}",
                                    style: GoogleFonts.montserrat(
                                        color: kUniversalColor),
                                  )),
                              Text(
                                "Rs${state.products![widget.i].discount == 0 ? '0' : '0'}",
                                style: GoogleFonts.montserrat(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
