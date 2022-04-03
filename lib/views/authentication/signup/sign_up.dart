import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/routes/routes_names.dart';
import 'package:grocery_shopping/utils/config/asset_config.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:grocery_shopping/views/authentication/components/skip_btn.dart';
import 'package:grocery_shopping/views/components/asset_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  //
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(

              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment:kIsWeb ? CrossAxisAlignment.center: CrossAxisAlignment.start,
                    children: [
                      SkipBtn(
                        onTap: () => Navigator.pushNamedAndRemoveUntil(
                            context, bottomNavBar, (route) => false),
                      ),
                      const Center(
                        child: AssetProvider(
                          asset: AssetConfig.kSignUpPageImage,
                          height: 250,
                          width: 250,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 25,
                          color: Color(0xffFE8086),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Phone",
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: kIsWeb ? 500 : double.infinity,
                        child: Form(
                          key: key,
                          child: Column(
                            // crossAxisAlignment: kIsWeb ? CrossAxisAlignment.center: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "Phone is required";
                                  }
                                },
                                onChanged: (val) => context
                                    .read<AuthenticationCubit>()
                                    .phoneNumber(val),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Color(0xffE4F9E8),
                                      width: 2,
                                    ),
                                  ),
                                  focusColor: const Color(0xffE4F9E8),
                                  // border: InputBorder.none,
                                  fillColor: const Color(0xffE4F9E8),
                                  filled: true,
                                  hintText: "Enter your Phone Number",
                                  prefixIcon: const Icon(
                                    Icons.phone_android,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              MaterialButton(
                                height: 50,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                minWidth: double.infinity,
                                color: const Color(0xffFE8086),
                                onPressed: () {
                                  if (key.currentState!.validate()) {
                                    context
                                        .read<AuthenticationCubit>()
                                        .registerPhone();
                                    Navigator.pushNamed(context, verifyEmail);
                                  }
                                },
                                child: const Text(
                                  "Register",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: kIsWeb ? 500 : double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 1,
                              width: 120,
                              color: Colors.black,
                            ),
                            const Text("Or login with"),
                            Container(
                              height: 1,
                              width: 120,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: kIsWeb ? 500 : double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                AssetConfig.kGoogleLogo,
                                height: 20,
                              ),
                              const Text("Google"),
                              Container(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
