import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class AddressesPage extends StatefulWidget {
  const AddressesPage({Key? key}) : super(key: key);

  @override
  _AddressesPageState createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            LineIcons.alternateLongArrowLeft,
            color: kUniversalColor,
            size: 30,
          ),
        ),
        title: Text(
          "Addresses",
          style: GoogleFonts.montserrat(color: Colors.black, fontSize: 15),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: const [
              ListTile(
                leading: Icon(
                  LineIcons.home,
                  color: kUniversalColor,
                  size: 35,
                ),
                title: Text("Home"),
                subtitle: Text("House no 345 , street abc"),
                trailing: Icon(
                  LineIcons.edit,
                  color: kUniversalColor,
                ),
              ),
              ListTile(
                leading: Icon(
                  LineIcons.home,
                  color: kUniversalColor,
                  size: 35,
                ),
                title: Text("Office"),
                subtitle: Text("House no 345 , street abc"),
                trailing: Icon(
                  LineIcons.edit,
                  color: kUniversalColor,
                ),
              ),
              ListTile(
                leading: Icon(
                  LineIcons.home,
                  color: kUniversalColor,
                  size: 35,
                ),
                title: Text("Home"),
                subtitle: Text("House no 345 , street abc"),
                trailing: Icon(
                  LineIcons.edit,
                  color: kUniversalColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
