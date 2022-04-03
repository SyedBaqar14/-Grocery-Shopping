import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/routes/routes_names.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:grocery_shopping/views/home/components/add_to_card.dart';
import 'package:html/parser.dart';
class ItemBottomSheetDetails extends StatefulWidget {
  final String image;
  final String name;
  final String price;
  final String discount;
  final String description;
  final int productId;

  const ItemBottomSheetDetails({Key? key,required this.name,required this.image,
    required this.description,required this.price,required this.discount,required this.productId}) : super(key: key);
  @override
  _ItemBottomSheetDetailsState createState() => _ItemBottomSheetDetailsState();
}

class _ItemBottomSheetDetailsState extends State<ItemBottomSheetDetails> {
  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body!.text).documentElement!.text;

    return parsedString;
  }
  @override
  Widget build(BuildContext context) {
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
                  image: NetworkImage(widget.image)),
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
                    widget.name,
                    style: GoogleFonts.montserrat(fontSize: 20),
                  ),
                  Row(
                    children: [
                      Text(
                        "Rs${widget.price}",
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
                          "-Rs${widget.discount}",
                          style: GoogleFonts.montserrat(color: kUniversalColor),
                        ),
                      ),
                      Text(
                        "Rs${widget.discount == 0 ? '0' : '0'}",
                        style: GoogleFonts.montserrat(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(_parseHtmlString (widget.description)
                      .toString().length > 80 ?
                  "${_parseHtmlString(widget.description)
                      .toString().substring(0,80)
                  }......" : _parseHtmlString(widget.description)
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
                  // AddToCart(d: d, index: widget.index, itemQty: 1, initQuantity: true)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
