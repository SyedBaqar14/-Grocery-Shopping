import 'dart:async';
import 'package:animated_widgets/widgets/rotation_animated.dart';
import 'package:animated_widgets/widgets/shake_animated_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/logic/cubit/checkout/checkout_cubit.dart';
import 'package:grocery_shopping/routes/routes_names.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

class LocationMap extends StatefulWidget {
  const LocationMap({Key? key}) : super(key: key);

  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  String searchVal = '';

  bool isMapMoving = false;

  final Set<Marker> markers = {};
  Completer<GoogleMapController> completer = Completer();
  static LatLng latLng = const LatLng(24.401716, 67.822508);

  LatLng initPostition = latLng;

  onMapCreated(GoogleMapController controller) {
    _controller = controller;
    completer.complete(_controller);
  }

  onCameraMove(CameraPosition position) {
    initPostition = position.target;
  }

  GoogleMapController? _controller;

  void animateCamera(LatLng position) async {
    _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position.latitude, position.longitude),
      zoom: 27.0,
    )));
  }

  _addMarker(LatLng position, String id) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarker,
      position: position,
      infoWindow: const InfoWindow(title: "Your Destination Point!"),
    );
    markers.add(marker);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CheckOutCubit>(context).resetPlaceID();
    Geolocator.requestPermission();
    Geolocator.getCurrentPosition().then((position) {
      animateCamera(LatLng(position.latitude, position.longitude));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckOutCubit, CheckOutState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          title: Container(
            height:45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: state.isLoading == true
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(child: Text(state.locationDiscription.substring(0, 20), style: TextStyle(color: Colors.black),)),
                            WidgetSpan(child: SizedBox(width: 10,)),
                            WidgetSpan(
                              child: InkWell(
                                  onTap: () => BlocProvider.of<CheckOutCubit>(context)
                                      .loadingSuggestions(),
                                  child: Icon(Icons.edit, size: 20, color: kUniversalColor,)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                  : TextField(
                      onTap: () {
                        // Navigator.pushNamed(context, autocompleteSearch);
                      },
                      onChanged: (val) async {
                        if(val.isNotEmpty) {
                          await BlocProvider.of<CheckOutCubit>(context)
                              .getSuggestions(val, "en");
                        } else {
                          await BlocProvider.of<CheckOutCubit>(context)
                              .restSuggestionList();
                        }

                        // setState(() {
                        //   searchVal = val;
                        // });
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Set delivery address",
                      ),
                    ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                await Geolocator.requestPermission();
                Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high)
                    .then((position) {
                  // _addMarker(LatLng(position.latitude, position.longitude),
                  //     "currentLocation");
                  animateCamera(LatLng(position.latitude, position.longitude));
                  print(position);
                });
              },
              icon: const Icon(
                Icons.location_on_outlined,
                color: kUniversalColor,
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                )),
                child: GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: initPostition, zoom: 40.0),
                  onMapCreated: onMapCreated,
                  tiltGesturesEnabled: true,
                  onCameraMove: (pos) {
                    print(
                        "Camera moving ${pos.target.latitude} ${pos.target.longitude}");
                    setState(() {
                      isMapMoving = true;
                    });
                  },
                  onCameraIdle: () {
                    print("Ideleee");
                    setState(() {
                      isMapMoving = false;
                    });
                  },
                  onTap: (lat) {
                    print("Camerea moving ${lat.longitude}");
                  },
                  mapType: MapType.normal,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  markers: markers,
                )),
            isMapMoving
                ? const Align(
                    alignment: Alignment.center,
                    child: Icon(LineIcons.mapPin,
                        size: 42.0, color: kUniversalColor),
                  )
                : const Align(
                    alignment: Alignment.center,
                    child: Icon(LineIcons.mapMarker,
                        size: 35.0, color: kUniversalColor),
                  ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: kUniversalColor,
                  minWidth: double.infinity,
                  onPressed: () async {
                    await BlocProvider.of<CheckOutCubit>(context).addAddress(
                        customerID: BlocProvider.of<AuthenticationCubit>(context,
                                    listen: false)
                                .getuserID,
                        lat: state.lat.toString(),
                        lng: state.lng.toString(),
                    addressLine: state.locationDiscription);
                    Navigator.pop(context);
                  },
                  child: const Text("Select Location"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.suggestionsList.length,
                  itemBuilder: (ctx, index) {
                    print("resultAfter: lat: ${state.lat} lng: ${state.lng}");
                    return ListTile(
                        onTap: () async {
                          final bool result =
                              await BlocProvider.of<CheckOutCubit>(context)
                                  .getPlaceDetails(
                                      placeID:
                                          state.suggestionsList[index].placeId,
                                      description: state
                                          .suggestionsList[index].description);
                          if (result) {
                            print(
                                "result: $result lat: ${state.lat} lng: ${state.lng}");
                            animateCamera(LatLng(state.lat, state.lng));
                          }
                        },
                        title: Text(
                          (state.suggestionsList[index].description),
                        ));
                  }),
            )
          ],
        ),
      );
    });
  }
}
