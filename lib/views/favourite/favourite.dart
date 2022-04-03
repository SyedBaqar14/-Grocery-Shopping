import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/logic/cubit/home/home_cubit.dart';
import 'package:grocery_shopping/routes/routes_names.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:grocery_shopping/views/favourite/item_bottom_sheet.dart';
import 'package:grocery_shopping/views/home/shimmer/home_shimmer.dart';
import 'package:line_icons/line_icons.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  void initState() {
    super.initState();
    getFav();
  }
   Future<void> getFav()async{
     final cubit = BlocProvider.of<HomeCubit>(context);
     final authCub = BlocProvider.of<AuthenticationCubit>(context);
     print("USer id can ge ${authCub.userIDCanBeNull}");
     if(authCub.userIDCanBeNull == false){
       cubit.fetchFav(authCub.getuserID);
     }else{
       cubit.assignNoUserId();
     }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    final authCub = BlocProvider.of<AuthenticationCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Favourites",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: RefreshIndicator(
          color: Colors.red,
          onRefresh: (){
            return getFav();
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state.favState == 'searching') ...[
                    HomeShimmer().productsShimmer()
                  ] else if(state.favState == 'Please Login to see Data') ...[
                    Center(child: Text('Please Login to see Data'))
                  ]
                  else if(state.favResult!.data?['getFavouriteProductsByCustomer']['products'].length <= 0)...[
                     Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         const Icon(LineIcons.heart,size: 100,color: kUniversalColor,),
                         Text("Your Favorite Is Empty",style: GoogleFonts.montserrat(color: kUniversalColor,fontSize: 22),),
                         const SizedBox(height: 20,),
                         Text("It's look like you haven't added anything to your Favorite yet",style: GoogleFonts.montserrat(color: Colors.grey,fontSize: 18),textAlign: TextAlign.center,),
                         MaterialButton(
                           minWidth: MediaQuery.of(context).size.width - 100,
                           color: kUniversalColor,
                           shape: const StadiumBorder(),
                           onPressed: ()=> Navigator.pushReplacementNamed(context, bottomNavBar),
                           child: Text("Add Favorite",style: GoogleFonts.montserrat(color: Colors.white),),
                         )
                       ],
                     )
                    ]
                  else ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state
                          .favorite!.length,
                      itemBuilder: (ctx, i) {
                        var list = state.favorite!.reversed;
                        if(state.favResult == null){
                          return Column(
                            children: const[
                              Text("Your Favorite is Empty",style: TextStyle(color: Colors.red,fontSize: 60),),
                            ],
                          );
                        }else{
                          return InkWell(
                            onTap: (){
                              print(state.favorite![i]);
                              showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50),
                                    topRight: Radius.circular(50),
                                  ),
                                ),
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50),
                                    ),
                                  ),
                                  child: ItemBottomSheetDetails(
                                    image: state.favorite![i].image,
                                    name: state.favorite![i].name,
                                    description: "dsfdf",
                                    discount: "dsfdf",
                                    price: state.favorite![i].price.toString(),
                                    productId: 3,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                    color: kFiledColor,
                                  ),
                                  height: kIsWeb ?400: 250,
                                  width: kIsWeb ? 200 : double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: kIsWeb ? 250 : 150,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(state.favorite![i].image),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.favorite![i].name,
                                                    style: GoogleFonts.montserrat(
                                                        fontSize: 20),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Rs ${state.favorite![i].price}",
                                                        style: GoogleFonts.montserrat(
                                                            color: kUniversalColor),
                                                      ),
                                                      Text(
                                                        "/kg",
                                                        style: GoogleFonts.montserrat(
                                                            color: Colors.grey),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    cubit.removeFromFavState(i);
                                                    cubit.addToFavState(
                                                      state.favorite![i].id,
                                                      authCub.getuserID);
                                                  },
                                                  // cubit.refreshProduct(int.parse(authCub.getuserID));},
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors.white,
                                                    child: Icon(
                                                      Icons.favorite,
                                                      color: state.favorite![i].isAddedFav ? Colors.red: Colors.grey,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container()
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }

                      },
                    )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
