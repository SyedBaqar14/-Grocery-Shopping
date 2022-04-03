import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/routes/routes_names.dart';
import 'package:grocery_shopping/utils/constants.dart';

class AddProfile extends StatefulWidget {
  const AddProfile({Key? key}) : super(key: key);

  @override
  _AddProfileState createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  GlobalKey<FormState> keye = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthenticationCubit>(context);
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: kUniversalColor,
          body: SafeArea(
            child: Form(
              key: keye,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // InkWell(
                            //     onTap:()=>Navigator.pop(context),
                            //     child: Icon(LineIcons.alternateLongArrowLeft,color: Colors.white,size: 30,)),
                            Text(
                              "Profile",
                              style:
                                  GoogleFonts.montserrat(color: Colors.white),
                            ),
                            // Container()
                          ],
                        ),
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
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 30),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Email"),
                              TextFormField(
                                style: const TextStyle(color: kUniversalColor),
                                cursorColor: kUniversalColor,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (val) {
                                  cubit.assignEmail(val);
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Email is Required";
                                  } else if (!RegExp(
                                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                      .hasMatch(val)) {
                                    return 'Please enter a valid email Address';
                                  }
                                },
                                decoration: const InputDecoration(
                                  focusColor: kUniversalColor,
                                  hoverColor: kUniversalColor,
                                  hintText: "Email Address",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kUniversalColor),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kUniversalColor),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("Name"),
                              TextFormField(
                                onChanged: (val) {
                                  cubit.assignName(val);
                                },
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Name is Required";
                                  }
                                },
                                style: const TextStyle(color: kUniversalColor),
                                cursorColor: kUniversalColor,
                                decoration: const InputDecoration(
                                  hintText: "Full Name",
                                  focusColor: kUniversalColor,
                                  hoverColor: kUniversalColor,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kUniversalColor),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kUniversalColor),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("Mobile Number"),
                              TextField(
                                style: const TextStyle(color: kUniversalColor),
                                cursorColor: kUniversalColor,
                                readOnly: true,
                                controller:
                                    TextEditingController(text: state.phoneNum),
                                decoration: const InputDecoration(
                                  focusColor: kUniversalColor,
                                  hoverColor: kUniversalColor,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kUniversalColor),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kUniversalColor),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minWidth: double.infinity,
                                color: kUniversalColor,
                                onPressed: () {
                                  if (keye.currentState!.validate()) {
                                    cubit.createProfile();
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        bottomNavBar, (route) => false);
                                  }
                                },
                                child: Text(
                                  "Save",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
