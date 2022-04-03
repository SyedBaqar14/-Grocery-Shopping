import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/logic/cubit/orders/orders_cubit.dart';
import 'package:grocery_shopping/utils/constants.dart';
import 'package:grocery_shopping/views/order/canceled.dart';
import 'package:grocery_shopping/views/order/pending.dart';
import 'delivered.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _tabController = TabController(length: 3, vsync: this);
    final cubit = BlocProvider.of<OrdersCubit>(context, listen: false);
    final authCub = BlocProvider.of<AuthenticationCubit>(context, listen: false);
    print("USer id can ge ${authCub.userIDCanBeNull}");
    if(authCub.userIDCanBeNull == false){
      cubit.getPendingOrders(authCub.getuserID);
      cubit.getDliveredOrders(authCub.getuserID);
      cubit.getCanceledOrders(authCub.getuserID);
    }else{
      cubit.assingNoUsrid();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Container(),
        elevation: 0.0,
        backgroundColor: kUniversalColor,
        title: const Text("Orders"),
      ),
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(child: header()),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: const [
            PendingOrders(),
            DeliveredOrders(),
            CanceledOrders()
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      height: 120,
      decoration: const BoxDecoration(
          color: kUniversalColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          )),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  focusColor: Color(0xffE4F9E8),
                  border: InputBorder.none,
                  hintText: "Search Orders",
                  prefixIcon: Icon(
                    Icons.search,
                  ),
                ),
              ),
            ),
            Container(
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                // give the indicator a decoration (color and border radius)
                indicator: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.white, width: 2))),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                onTap: (i) {},
                tabs: const [
                  // first tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Pending',
                  ),

                  // second tab [you can add an icon using the icon property]
                  Tab(
                    text: 'Delivered',
                  ),
                  Tab(
                    text: 'Canceled',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
