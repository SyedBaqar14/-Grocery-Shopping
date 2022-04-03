import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/utils/constants.dart';

class ContactUsColumn extends StatelessWidget {
  const ContactUsColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(
        //   height: MediaQuery.of(context).size.height / 2,
        // ),
        Text(
          "Get in touch",
          style: GoogleFonts.montserrat(
              fontSize: 30, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Phone",
          style: GoogleFonts.montserrat(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
            "Due to COVID-19 our full team are working remotly, Please mail us at request a callback"),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Email",
          style: GoogleFonts.montserrat(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          "hello@grocerapp.info",
          style: GoogleFonts.montserrat(color: kUniversalColor),
        ),
        Text(
          "contactus@grocerapp.contact",
          style: GoogleFonts.montserrat(color: kUniversalColor),
        ),
        Text(
          "abc@grocerapp.com",
          style: GoogleFonts.montserrat(color: kUniversalColor),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Office Location",
          style: GoogleFonts.montserrat(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text("Fakhri Trade Center Chilli mart Karachi"),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
