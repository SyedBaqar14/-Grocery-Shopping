import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/logic/cubit/home/home_cubit.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:grocery_shopping/views/home/search/search_history.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<String> popular = [
    "Apple",
    "Water",
    "Fruits",
    "Candels",
    "Cheery",
    "Frozen vegetables",
    "Frozen fruits",
    "chicken meat",
  ];
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return ListView(
      shrinkWrap: true,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(left: 13.0, bottom: 10),
          child: Text(
            "Recent Searches",
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
          ),
        ),
        const SearchHistory(),
        Padding(
          padding: const EdgeInsets.only(left: 13.0, bottom: 10, top: 30),
          child: Text(
            "Popular searches",
            style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: popular.length,
          itemBuilder: (ctx, i) {
            return Wrap(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap:() {
                      cubit.assignSearch(popular[i]);
                      cubit.addToSearch(popular[i]);
                      cubit.searchProducts();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: kUniversalColor)),
                          padding: const EdgeInsets.all(5),
                          child: Text(
                            popular[i],
                            style: GoogleFonts.montserrat(color: kUniversalColor),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: kUniversalColor)),
                        padding: const EdgeInsets.all(5),
                        child: Text(
                          popular[i],
                          style: GoogleFonts.montserrat(color: kUniversalColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
