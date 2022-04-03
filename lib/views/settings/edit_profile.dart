import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String email = '';
  String name = '';
  String phone = '';
  bool isPressed = false;

  double height = 50;

  @override
  void dispose() {
    super.dispose();
    isPressed = false;
  }

  @override
  Widget build(BuildContext context) {
    final cub = BlocProvider.of<AuthenticationCubit>(context);
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: kUniversalColor,
          title: Text(
            "Profile",
            style: GoogleFonts.montserrat(color: Colors.white, fontSize: 15),
          ),
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                LineIcons.alternateLongArrowLeft,
                color: Colors.white,
                size: 30,
              )),
        ),
        backgroundColor: kUniversalColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 100,
                    width: 80,
                    child: Stack(
                      children: const [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40,
                          child: Icon(
                            Icons.person,
                            size: 70,
                            color: kUniversalColor,
                          ),
                        ),
                        // Align(
                        //   alignment: Alignment(1.2,0.5),
                        //   child: Container(
                        //       padding: const EdgeInsets.all(4),
                        //       decoration: BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           color: Colors.white
                        //       ),
                        //       child: Icon(LineIcons.camera,color: kUniversalColor,)),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 30),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        width: kIsWeb ? 300 : double.infinity,
                        child: Column(
                          crossAxisAlignment:CrossAxisAlignment.start,
                          children: [
                            const Text("Email"),
                            TextField(
                              onChanged: (val) {
                                cub.assignUpdateEmail(val);
                              },
                              style: const TextStyle(color: kUniversalColor),
                              cursorColor: kUniversalColor,
                              controller: TextEditingController(text: state.email!),
                              decoration: const InputDecoration(
                                focusColor: kUniversalColor,
                                hoverColor: kUniversalColor,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kUniversalColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kUniversalColor),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Name"),
                            TextField(
                              onChanged: (val) {
                                cub.assignUpdateName(val);
                              },
                              style: const TextStyle(color: kUniversalColor),
                              cursorColor: kUniversalColor,
                              controller: TextEditingController(text: state.name!),
                              decoration: const InputDecoration(
                                focusColor: kUniversalColor,
                                hoverColor: kUniversalColor,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kUniversalColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kUniversalColor),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text("Mobile Number"),
                            TextField(
                              readOnly: true,
                              onChanged: (val) {
                                cub.assignUpdateEmail(val);
                              },
                              style: const TextStyle(color: kUniversalColor),
                              cursorColor: kUniversalColor,
                              controller:
                                  TextEditingController(text: state.phoneNum!),
                              decoration: const InputDecoration(
                                focusColor: kUniversalColor,
                                hoverColor: kUniversalColor,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kUniversalColor),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: kUniversalColor),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            height == 0
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          kUniversalColor),
                                    ),
                                  )
                                : Center(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isPressed = true;
                                          Future.delayed(
                                              const Duration(milliseconds: 800),
                                              () {
                                            setState(() {
                                              height = 0;
                                            });
                                          });
                                        });
                                        cub.updateProfile(context);
                                        Future.delayed(const Duration(seconds: 3),
                                            () {
                                          setState(() {
                                            height = 50;
                                            isPressed = false;
                                          });
                                        });
                                      },
                                      child: AnimatedContainer(
                                        height: 40,
                                        decoration: BoxDecoration(
                                            color: kUniversalColor,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        curve: Curves.fastOutSlowIn,
                                        duration: const Duration(milliseconds: 800),
                                        width: isPressed ? 60 : 500,
                                        padding: const EdgeInsets.all(10),
                                        // width: 60,
                                        child: Center(
                                          child: Text(
                                            "Save",
                                            style: GoogleFonts.montserrat(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
