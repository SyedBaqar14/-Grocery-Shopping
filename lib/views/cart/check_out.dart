import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/logic/cubit/cart/cart_cubit.dart';
import 'package:grocery_shopping/logic/cubit/checkout/checkout_cubit.dart';
import 'package:grocery_shopping/routes/routes_names.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class CheckOutPage extends StatefulWidget {
  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  List<ServiceTime> serviceTime = [
    ServiceTime("6:00", "", false),
    ServiceTime("7:00", "", false),
    ServiceTime("8:00", "", false),
    ServiceTime("9:00", "", false),
    ServiceTime("10:00", "", false),
    ServiceTime("11:00", "", false),
    ServiceTime("12:00", "PM", false),
    ServiceTime("1:00", "PM", false),
    ServiceTime("2:00", "PM", false),
    ServiceTime("3:00", "PM", false),
    ServiceTime("4:00", "PM", false),
    ServiceTime("5:00", "PM", false),
    ServiceTime("6:00", "PM", false),
    ServiceTime("7:00", "PM", false),
    ServiceTime("8:00", "PM", false),
  ];

  void setIsSelected(int ind) {
    for (var d in serviceTime) {
      setState(() {
        d.isSelected = false;
      });
    }
    serviceTime[ind].isSelected = true;
  }

  DateTime da = DateTime.now();

  @override
  void initState() {
    final checkoutCubit = BlocProvider.of<CheckOutCubit>(context);
    String startDate = DateTime(da.year, da.month, da.day).toString();
    checkoutCubit.assignDate(date: startDate.substring(0, 10));
    checkoutCubit.checkForAvailableDates();
  }

  @override
  Widget build(BuildContext context) {
    final checkoutCubit = BlocProvider.of<CheckOutCubit>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Checkout",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.date_range,
                    color: kUniversalColor,
                  ),
                  Text(
                    "Select Date",
                    style: GoogleFonts.montserrat(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              FlutterDatePickerTimeline(
                itemHeight: 50,
                listViewPadding: const EdgeInsets.all(3.0),
                unselectedItemBackgroundColor: kFiledColor.withOpacity(0.5),
                selectedItemBackgroundColor: kUniversalColor,
                selectedItemTextStyle: const TextStyle(color: Colors.white),
                unselectedItemTextStyle:
                    const TextStyle(color: kUniversalColor),
                unselectedItemWidth: 50,
                startDate: DateTime(da.year, da.month, da.day),
                endDate: DateTime(da.year, da.month, da.day + 6),
                initialSelectedDate: DateTime(da.year, da.month, da.day),
                onSelectedDateChange: (DateTime? dateTime) {
                  print(dateTime);
                  checkoutCubit.assignDate(
                      date: dateTime.toString().substring(0, 10));
                  checkoutCubit.checkForAvailableDates();
                  // var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
                  // var inputDate = inputFormat.parse(dateTime.toString());
                  // var outputFormat = DateFormat('yyyy/MM/dd');
                  // var en =  outputFormat.format(inputDate);
                  // print(en);
                  // pro.selectedDate = en;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(
                    LineIcons.clock,
                    color: kUniversalColor,
                  ),
                  Text(
                    "Select Date",
                    style: GoogleFonts.montserrat(fontSize: 18),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: BlocBuilder<CheckOutCubit, CheckOutState>(
                    builder: (context, state) {
                  return Row(
                    children: List.generate(
                        state.loadingAvailableDates == "Loading"
                            ? 0
                            : state
                                .queryResultAvailableDates!
                                .data!['listDeliveryAvailableSlots']
                                    ['delivery_slots']
                                .length, (i) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: InkWell(
                          onTap: () {
                            BlocProvider.of<CheckOutCubit>(context)
                                .selectedDate(
                                    selectedTime: state
                                            .queryResultAvailableDates!
                                            .data!['listDeliveryAvailableSlots']
                                        ['delivery_slots'][i]['time_slot'],
                                    index: i);
                            // setIsSelected(i);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border.all(color: kUniversalColor),
                                color: state.isSelected[i]
                                    ? kUniversalColor
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                Text(
                                  state.queryResultAvailableDates!
                                          .data!['listDeliveryAvailableSlots']
                                      ['delivery_slots'][i]['time_slot'],
                                  style: GoogleFonts.montserrat(
                                      color: state.isSelected[i]
                                          ? Colors.white
                                          : kUniversalColor,
                                      fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  );
                }),
              ),
              Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: kUniversalColor,
                              ),
                              Text(
                                "Delivery address",
                                style: GoogleFonts.montserrat(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          IconButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, locationMap),
                            icon: const Icon(
                              LineIcons.edit,
                              color: kUniversalColor,
                            ),
                          )
                        ],
                      ),
                      BlocBuilder<CheckOutCubit, CheckOutState>(
                          builder: (context, state) {
                        return Container(
                            height: 100,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                            )),
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                  target: LatLng(state.lat, state.lng),
                                  zoom: 40.0),
                              tiltGesturesEnabled: true,
                              zoomControlsEnabled: false,
                              buildingsEnabled: false,
                              compassEnabled: false,
                              indoorViewEnabled: false,
                              mapToolbarEnabled: false,
                              myLocationButtonEnabled: false,
                              myLocationEnabled: false,
                              rotateGesturesEnabled: false,
                              trafficEnabled: false,
                              onCameraMove: (pos) {
                                print(
                                    "Camerea moving ${pos.target.latitude} ${pos.target.longitude}");
                                // setState(() {
                                //   isMapMoving = true;
                                // });
                              },
                              onCameraIdle: () {
                                print("Ideleee");
                                // setState(() {
                                //   isMapMoving = false;
                                // });
                              },
                              onTap: (lat) {
                                print("Camerea moving ${lat.longitude}");
                              },
                              mapType: MapType.normal,
                              scrollGesturesEnabled: false,
                              zoomGesturesEnabled: false,
                            ));
                      }),
                      /*
                      Image.network(
                        "https://media.wired.com/photos/59269cd37034dc5f91bec0f1/191:100/w_1280,c_limit/GoogleMapTA.jpg",
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.fill,
                      ),

                       */
                      SizedBox(
                        height: 10,
                      ),
                      Text(""),
                      SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<CheckOutCubit, CheckOutState>(
                          builder: (context, state) {
                        return Text(state.locationDiscription == ""
                            ? ""
                            : state.locationDiscription);
                      }),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            LineIcons.plus,
                            size: 20,
                            color: kUniversalColor,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, locationMap);
                            },
                            child: Text(
                              "Add Delivery instruction",
                              style:
                                  GoogleFonts.montserrat(color: kUniversalColor),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            LineIcons.wallet,
                            color: kUniversalColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Payment Method",
                            style: GoogleFonts.montserrat(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<CartCubit, CartState>(
                          builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 3.0),
                              child: Row(
                                children: [
                                  Icon(
                                    LineIcons.wavyMoneyBill,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("Cash"),
                                ],
                              ),
                            ),
                            Text(state.total.toString())
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              LineIcons.clipboardList,
                              color: kUniversalColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Order Summary",
                              style: GoogleFonts.montserrat(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Subtotal"),
                            Text("Rs ${state.subTotal}"),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Delivery fee"),
                            Text("Rs ${state.deliveryCharges}"),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("VAT"),
                            Text("Rs ${state.vat}"),
                          ],
                        ),
                      ],
                    );
                  }),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text("By completing this order, I agree to all"),
                      SizedBox(height: 5,),
                      Text(
                        "terms & conditions",
                        style: GoogleFonts.montserrat(color: kUniversalColor),
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              BlocBuilder<CartCubit, CartState>(builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500)),
                    Text("Rs ${state.total}",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500)),
                  ],
                );
              }),
              SizedBox(height: 20),
              BlocBuilder<CheckOutCubit, CheckOutState>(
                  builder: (context, state) {
                return MaterialButton(
                  height: 40,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minWidth: double.infinity,
                  color: kUniversalColor,
                  onPressed: () async {
                    final checkoutBloc =
                        BlocProvider.of<CheckOutCubit>(context);
                    if (!(checkoutBloc.state.isSelected.contains(true))) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("please select delivery Day & Time"),
                      ));
                      return;
                    }
                    final cartBloc = BlocProvider.of<CartCubit>(context);
                    await checkoutBloc.placeOrder(
                        customerID: BlocProvider.of<AuthenticationCubit>(context,
                                    listen: false)
                                .getuserID,
                        productList: cartBloc.state.cartList,
                        shippingMethod: "COD",
                        shippingLat: state.lat.toString(),
                        shippingLng: state.lng.toString(),
                        total: cartBloc.state.total,
                        paymentMethod: "Cash");
                    cartBloc.resetCart();
                    await Navigator.pushNamed(context, bottomNavBar);
                    // final String isLoaded = state.loadingForPlaceOrder;
                    //
                    // if (isLoaded == "Loaded") {
                    //   print(isLoaded);
                    //   await Navigator.pushNamed(context, home);
                    // } else {
                    //   print(isLoaded);
                    // }
                  },
                  child: Text(
                    "Place Order",
                    style: GoogleFonts.montserrat(color: Colors.white),
                  ),
                );
              }),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceTime {
  String time;
  String zone;
  bool isSelected;

  ServiceTime(this.time, this.zone, this.isSelected);
}
