import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/logic/cubit/home/home_cubit.dart';
import 'package:grocery_shopping/routes/routes_names.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:grocery_shopping/views/home/components/banner.dart';
import 'package:grocery_shopping/views/home/components/category_list.dart';
import 'package:grocery_shopping/views/home/components/header.dart';
import 'package:grocery_shopping/views/home/components/product_card.dart';
import 'package:grocery_shopping/views/home/shimmer/home_shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool iCatSearched = false;

  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<HomeCubit>(context, listen: false);
    final authCubit = BlocProvider.of<AuthenticationCubit>(context, listen: false);
    var id = authCubit.userIDCanBeNull ? 0000 : authCubit.getuserID;
    print(id);
    print(authCubit.getuserID);
    // print(id);
    cubit.getCategoryList();
    cubit.getBannerImages();
    print("USer id can ge ${authCubit.userIDCanBeNull}");
    if(authCubit.userIDCanBeNull == false){
      Future.delayed(const Duration(milliseconds: 500), () {
        cubit.getSearchShared();
        cubit.getProductsList(authCubit.getuserID);
      });
    }else{
      cubit.getProductsList(0000);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    /*24 is for notification bar on Android*/
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const HeaderHome(),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Bannerhome(),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Shop By Category",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w400),
                              ),
                              InkWell(
                                onTap: ()=> Navigator.pushNamed(context, categoryPage),
                                child: Text(
                                  "View All",
                                  style: GoogleFonts.montserrat(
                                      color: kUniversalColor),
                                ),
                              ),
                            ],
                          ),
                          state.categoryState == 'searching'
                              ? HomeShimmer().category()
                              : SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: CategoryList(
                                    categoryResult: state.categoryResult!,
                                  )),
                        ],
                      ),
                      const Divider(),
                      Text(cubit.getCatID == 0 ? "Recommended for you" : "Your Result"),
                      if (state.productState == 'searching') ...[
                        HomeShimmer().productsShimmer()
                      ] else
                        GridView.builder(
                          itemCount: state.productResult!
                              .data?['listProductsFilter']['products'].length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 0.6,
                            maxCrossAxisExtent: 220,
                          ),
                          itemBuilder: (ctx, i) {
                            return ProductsCard(
                                data: state.productResult!, i: i);
                          },
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
