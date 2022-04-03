import 'package:flutter/material.dart';
import 'package:grocery_shopping/routes/routes_names.dart';
import 'package:grocery_shopping/views/authentication/signup/sign_up.dart';
import 'package:grocery_shopping/views/authentication/signup/verify_email.dart';
import 'package:grocery_shopping/views/bottom_nav_bar.dart';
import 'package:grocery_shopping/views/cart/address/location_map.dart';
import 'package:grocery_shopping/views/cart/check_out.dart';
import 'package:grocery_shopping/views/home/category.dart';
import 'package:grocery_shopping/views/home/home_page.dart';
import 'package:grocery_shopping/views/home/item_details.dart';
import 'package:grocery_shopping/views/home/search/search.dart';
import 'package:grocery_shopping/views/not_found.dart';
import 'package:grocery_shopping/views/order/order_tracking.dart';
import 'package:grocery_shopping/views/order/return_page.dart';
import 'package:grocery_shopping/views/settings/addresses.dart';
import 'package:grocery_shopping/views/settings/contact_us.dart';
import 'package:grocery_shopping/views/settings/create_profile.dart';
import 'package:grocery_shopping/views/settings/edit_profile.dart';
import 'package:grocery_shopping/views/settings/faq.dart';
import 'package:grocery_shopping/views/settings/profile.dart';
import 'package:grocery_shopping/views/splash_screen.dart';

class CustomRoutes {
  static Route<dynamic> allRoutes(RouteSettings setting) {
    switch (setting.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUp());
      case verifyEmail:
        return MaterialPageRoute(builder: (_) => const VerifyEmail());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case bottomNavBar:
        return MaterialPageRoute(builder: (_) => const BottomNavBar());
      case itemDetails:
        return MaterialPageRoute(builder: (_) => const ItemDetails());
      case checkOut:
        return MaterialPageRoute(builder: (_) => CheckOutPage());
      case orderTracking:
        return MaterialPageRoute(builder: (_) => const OrderTracking());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfile());
      case addresses:
        return MaterialPageRoute(builder: (_) => const AddressesPage());
      case search:
        return MaterialPageRoute(builder: (_) => const Search());
      case faqPage:
        return MaterialPageRoute(builder: (_) => const FAQPage());
      case locationMap:
        return MaterialPageRoute(builder: (_) => const LocationMap());
      case contactUs:
        return MaterialPageRoute(builder: (_) => const ContactUs());
      case addProfile:
        return MaterialPageRoute(builder: (_) => const AddProfile());
      case categoryPage:
        return MaterialPageRoute(builder: (_) =>  CategoryPage());
      case returnPage:
        return MaterialPageRoute(builder: (_) =>  ReturnPage());
    }
    return MaterialPageRoute(builder: (_) => const NotFoundPage());
  }
}
