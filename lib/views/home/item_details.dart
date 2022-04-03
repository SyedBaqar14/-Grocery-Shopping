import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shopping/logic/cubit/home/home_cubit.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:grocery_shopping/views/home/components/add_to_card.dart';
import 'package:html/parser.dart';

import 'components/item_details_stack.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({Key? key}) : super(key: key);

  @override
  _ItemDetailsState createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final data = state.productResult!.data?['listProductsFilter'];
        var d = data['products'];
        return Scaffold(
          body:  Stack(
            children: [
              Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 250,
                    width: double.infinity,
                    child: Image.network(
                      d[state.index]['image'],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 70,
                        ),
                        const Text("Product Details"),
                        Container(
                          height: 5,
                          width: 50,
                          color: kUniversalColor,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: kFiledColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child:
                              Text(_parseHtmlString(d[state.index]['description']['description'])),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Align(
                  alignment: const Alignment(0, -0.5),
                  child: ItemDetailsStack(
                    index: state.index!,
                    productResult: state.productResult!,
                  ))
            ],
          ),
          bottomNavigationBar:  Padding(
            padding: const EdgeInsets.all(15.0),
            child: AddToCart(d: d, index: state.index!, itemQty: 1, initQuantity: true),
          ),
        );
      },
    );
  }
}
