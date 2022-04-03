import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({Key? key}) : super(key: key);

  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {

  @override
  void initState() {
    super.initState();
    context.read<AuthenticationCubit>().getFaq();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit,AuthenticationState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            // elevation: 0.0,
            centerTitle: true,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                LineIcons.alternateLongArrowLeft,
                color: Colors.white,
                size: 30,
              ),
            ),
            backgroundColor: kUniversalColor,
            title: Text(
              "FAQ",
              style: GoogleFonts.montserrat(fontSize: 15),
            ),
          ),
          body: state.faqStatus == 'searching'?Center(child: CircularProgressIndicator(),): Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: state.faqREs!.data?['listFaqs'].length,
              itemBuilder: (ctx,i){
                var d = state.faqREs!.data?['listFaqs'][i];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     ExpansionTile(
                      iconColor: Colors.black,
                      childrenPadding: EdgeInsets.all(15),
                      textColor: Colors.black,
                      title: Text(d['title']),
                      children: [
                        Text(
                            d['description'])
                      ],
                    ),
                  ],
                );
              },
            )
          ),
        );
      }
    );
  }
}
