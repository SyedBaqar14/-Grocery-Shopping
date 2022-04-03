import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/logic/cubit/home/home_cubit.dart';
import 'package:grocery_shopping/logic/cubit/init_cubit.dart';
import 'package:grocery_shopping/logic/cubit/orders/orders_cubit.dart';
import 'package:grocery_shopping/routes/custom_routes.dart';
import 'package:grocery_shopping/routes/routes_names.dart';
import 'package:grocery_shopping/logic/cubit/cart/cart_cubit.dart';
import 'package:grocery_shopping/logic/cubit/checkout/checkout_cubit.dart';

final initCubit = InitCubit();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InitCubit>(create: (context) => InitCubit()),
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
        BlocProvider<AuthenticationCubit>(
            create: (context) => AuthenticationCubit()),
        BlocProvider<OrdersCubit>(create: (context) => OrdersCubit()),
        BlocProvider<CartCubit>(create: (context) => CartCubit()),
        BlocProvider<CheckOutCubit>(create: (context) => CheckOutCubit(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Grocery Shopping',
        theme: ThemeData(
          textTheme: TextTheme(
            // caption: GoogleFonts.montserrat(),
            bodyText2: GoogleFonts.montserrat(),
            // bodyText1: GoogleFonts.montserrat(),
          ),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: CustomRoutes.allRoutes,
        initialRoute: splash,
      ),
    );
  }
}
