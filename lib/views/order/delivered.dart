import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/logic/cubit/orders/orders_cubit.dart';
import 'package:grocery_shopping/views/order/components/delivered_order_card.dart';

class DeliveredOrders extends StatefulWidget {
  const DeliveredOrders({Key? key}) : super(key: key);

  @override
  _DeliveredOrdersState createState() => _DeliveredOrdersState();
}

class _DeliveredOrdersState extends State<DeliveredOrders> {
  bool isLoading = false;
  refres()async{
    print("Getti");
    final cubit = BlocProvider.of<OrdersCubit>(context, listen: false);
    final authCub = BlocProvider.of<AuthenticationCubit>(context, listen: false);
    await cubit.getDliveredOrders(authCub.getuserID);
    setState(() {
      isLoading = false;
    });
    print("Okay");

  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) => Scaffold(
        body: RefreshIndicator(
          onRefresh: (){
            setState(() {
              isLoading = true;
            });
            return refres();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: state.deliveredOrderStatus == "searching"
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.deliveredOrderStatus == 'Please Login to See Data' ? Center(child: Text(state.deliveredOrderStatus.toString()),): ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.deliveredOrderResult!
                        .data?['listOrdersFilters']['orders'].length,
                    itemBuilder: (ctx, i) {
                      return DeliveredOrderCard(
                          result: state.deliveredOrderResult!, i: i);
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
