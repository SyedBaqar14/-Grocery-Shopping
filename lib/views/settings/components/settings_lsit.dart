import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/routes/routes_names.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cub = BlocProvider.of<AuthenticationCubit>(context);
    return Column(
      children: [
        ListTile(
          onTap: () => Navigator.pushNamed(context, profile),
          title: const Text("Profile"),
          leading: const Icon(
            LineIcons.user,
            color: kUniversalColor,
            size: 30,
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
        ListTile(
          onTap: () => Navigator.pushNamed(context, addresses),
          title: const Text("Addresses"),
          leading: const Icon(
            LineIcons.mapMarker,
            color: kUniversalColor,
            size: 30,
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
        ListTile(
          onTap: () => Navigator.pushNamed(context, faqPage),
          title: const Text("Faq's"),
          leading: const Icon(LineIcons.questionCircle,
              color: kUniversalColor, size: 30),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
        ListTile(
          onTap: () => Navigator.pushNamed(context, contactUs),
          title: const Text("Contact Us"),
          leading:
              const Icon(LineIcons.headset, color: kUniversalColor, size: 30),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
        ListTile(
          onTap: () {
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: Text("Are you sure you want logout?"),
                actions: [
                  TextButton(
                    onPressed: (){
                     Navigator.pop(context);
                    },
                    child: Text("No"),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.pushNamedAndRemoveUntil(
                          context, signUp, (route) => false);
                      cub.logout();
                    },
                    child: Text("Yes"),
                  )
                ],
              );
            });
          },
          title: const Text("Logout"),
          leading: const Icon(LineIcons.alternateSignOut,
              color: kUniversalColor, size: 30),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ],
    );
  }
}
