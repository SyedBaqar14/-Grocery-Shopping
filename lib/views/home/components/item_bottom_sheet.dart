import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:grocery_shopping/routes/routes_names.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:grocery_shopping/views/home/components/add_to_card.dart';
import 'package:html/parser.dart';

class ItemBottomSheet extends StatefulWidget {
  const ItemBottomSheet({Key? key, required this.result, required this.index})
      : super(key: key);
  final QueryResult result;
  final int index;
  @override
  _ItemBottomSheetState createState() => _ItemBottomSheetState();
}

class _ItemBottomSheetState extends State<ItemBottomSheet> {
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }
  String itemDes =
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s when a galley of type and scrambled it to make a type specimen book  only five centuries, but also the leap into electronic typesetting, unchanged.";
  @override
  Widget build(BuildContext context) {
    final data = widget.result.data?['listProductsFilter'];
    var d = data['products'];
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: MediaQuery.of(context).size.height / 1.3,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                // bottomLeft: Radius.circular(100),
                // bottomRight: Radius.circular(20),
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              ),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(d[widget.index]['image'])),
              // color: Colors.white,
            ),
            height: height / 3.5,
            width: MediaQuery.of(context).size.width,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    d[widget.index]['description']['name'],
                    style: GoogleFonts.montserrat(fontSize: 20),
                  ),
                  Row(
                    children: [
                      Text(
                        "Rs${d[widget.index]['price']}",
                        style: GoogleFonts.montserrat(color: kUniversalColor),
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
                          "-Rs${d[widget.index]['discount_price']}",
                          style: GoogleFonts.montserrat(color: kUniversalColor),
                        ),
                      ),
                      Text(
                        "Rs${d[widget.index]['discount_price'] == 0 ? '0' : '0'}",
                        style: GoogleFonts.montserrat(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(_parseHtmlString (d[widget.index]['description']['description'])
                      .toString().length > 80 ?
                  "${_parseHtmlString(d[widget.index]['description']['description'])
        .toString().substring(0,80)
  }......" : _parseHtmlString(d[widget.index]['description']['description'])
                      .toString(),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, itemDetails);
                    },
                    child: Text(
                      "View All",
                      style: GoogleFonts.montserrat(color: kUniversalColor),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AddToCart(d: d, index: widget.index, itemQty: 1, initQuantity: true)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
