import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/utils/constants.dart';

class ProfileWidget extends StatelessWidget {
  final String name;
  final String phone;

  const ProfileWidget({Key? key, required this.name, required this.phone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const CircleAvatar(
              backgroundColor: kFiledColor,
              radius: 40,
              child: Icon(
                Icons.person,
                size: 70,
                color: kUniversalColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              name,
            ),
            Text(
              phone,
              style: GoogleFonts.montserrat(color: Colors.grey),
            )
          ],
        ),
      ],
    );
  }
}
