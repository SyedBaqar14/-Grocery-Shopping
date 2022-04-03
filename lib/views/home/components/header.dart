import 'package:flutter/material.dart';
import 'package:grocery_shopping/routes/routes_names.dart';
import 'package:grocery_shopping/utils/config/asset_config.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:grocery_shopping/views/components/asset_provider.dart';
import 'package:line_icons/line_icons.dart';

class HeaderHome extends StatefulWidget {
  const HeaderHome({Key? key}) : super(key: key);

  @override
  _HeaderHomeState createState() => _HeaderHomeState();
}

class _HeaderHomeState extends State<HeaderHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: kUniversalColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )),
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      Text(
                        "Delivery address",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "cpo 72 sabir sre",
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                        onPressed: ()=>Navigator.pushNamed(context, locationMap),
                        icon:Icon(LineIcons.angleDown,
                        color: Colors.white,)
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(context, search),
                        child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: const [
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Search fruits,vegetable grocer"),
                              ],
                            ),
                        ),
                      ),
                    ),
                    // const SizedBox(
                    //   width: 10,
                    // ),
                    // const Padding(
                    //   padding: EdgeInsets.all(8.0),
                    //   child: InkWell(
                    //       child: AssetProvider(
                    //     asset: AssetConfig.kFilterIcon,
                    //     width: 20,
                    //     height: 20,
                    //   )),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
