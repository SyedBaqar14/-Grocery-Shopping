import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class ContactUsHeader extends StatelessWidget {
  const ContactUsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [kUniversalColor, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      height: MediaQuery.of(context).size.height / 2,
      width: double.infinity,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:IconButton(
                      icon: Icon(
                        LineIcons.alternateLongArrowLeft,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: ()=>Navigator.pop(context),
                    )
                  ),
                ],
              ),
              Spacer(),
              Text(
                "Contact",
                style: GoogleFonts.montserrat(
                    fontSize: 40,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Let's start something greate togather,Get in touch with one of the team today!",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 10,)
            ],
          ),
        ),
      ),
    );
  }
}
