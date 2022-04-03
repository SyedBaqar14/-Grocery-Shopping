import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/routes/routes_names.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            leading: InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  LineIcons.alternateLongArrowLeft,
                  color: Colors.white,
                  size: 30,
                )),
            backgroundColor: kUniversalColor,
            title: Text(
              "Profile",
              style: GoogleFonts.montserrat(color: Colors.white, fontSize: 15),
            ),
            actions: [
              IconButton(
                onPressed: () => Navigator.pushNamed(context, editProfile),
                icon: const Icon(
                  LineIcons.penSquare,
                  color: Colors.white,
                ),
              )
            ],
          ),
          backgroundColor: kUniversalColor,
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
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
                              Text(state.name!,
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white)),
                            ],
                          ),
                        ],
                      ),
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
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(
                            LineIcons.envelope,
                            color: kUniversalColor,
                          ),
                          title: const Text("Email"),
                          subtitle: Text(
                            state.email!,
                            style:
                                GoogleFonts.montserrat(color: kUniversalColor),
                          ),
                        ),
                        ListTile(
                          leading: const Icon(
                            LineIcons.phone,
                            color: kUniversalColor,
                          ),
                          title: const Text("Mobile Number"),
                          subtitle: Text(
                            state.phoneNum!,
                            style:
                                GoogleFonts.montserrat(color: kUniversalColor),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
