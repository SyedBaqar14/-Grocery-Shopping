import 'package:flutter/material.dart';
import 'package:grocery_shopping/utils/config/destinations.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:grocery_shopping/views/cart/cart.dart';
import 'package:grocery_shopping/views/favourite/favourite.dart';
import 'package:grocery_shopping/views/home/home_page.dart';
import 'package:grocery_shopping/views/order/orders.dart';
import 'package:grocery_shopping/views/settings/settings.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _index = 0;

  List<Widget> allDestinations = [
    const HomePage(),
    CartPage(),
    const FavouritePage(),
    const OrdersPage(),
    const SettingsPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index:_index,
          children: allDestinations,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: BottomNavigationBar(
              currentIndex: _index,
              onTap: (int index) {
                setState(() {
                  _index = index;
                });
              },
              selectedItemColor: kUniversalColor,
              type: BottomNavigationBarType.fixed,
              items:
                  Destinations.allDestinations.map((Destinations destinations) {
                return BottomNavigationBarItem(
                  icon: destinations.icon,
                  label: destinations.title,
                );
              }).toList(),
            ),
          ),
        ));
  }
}
