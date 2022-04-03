import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:grocery_shopping/views/paint/profile_clip_path.dart';
import 'package:grocery_shopping/views/settings/components/profile_widget.dart';
import 'package:grocery_shopping/views/settings/components/settings_lsit.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit,AuthenticationState>(builder: (context,state){
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: Container(),
          centerTitle: true,
          backgroundColor: kUniversalColor,
          title: Text(
            "Settings",
            style: GoogleFonts.montserrat(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  kIsWeb ? Container() : ClipPath(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 130,
                      color: kUniversalColor,
                    ),
                    clipper: ProfileClipPath(),
                  ),
                  Align(
                    alignment:const  Alignment(0.0, 0.0),
                    child: ProfileWidget(name: state.name!,phone: state.phoneNum!,)
                  )
                ],
              ),
              const  SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SettingsList()
              ),
            ],
          ),
         ),
       );
      },
    );
  }
}


