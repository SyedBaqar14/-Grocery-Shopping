import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:grocery_shopping/data/repository/orders_repository.dart';
import 'package:grocery_shopping/utils/gql_quries.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit()
      : super(
          OrdersState(
            pendingOrderState: "searching",
            deliveredOrderStatus: "searching",
            trackOrderStatus: "searching",
            canceledOrdersStatus: "searching",
          ),
        );
  final repository = OrdersRepository();

  getPendingOrders(int userId) {
    repository.getPendingOrders(
        GQLQuries.pendingOrdersQuery, {'customer_id': userId}).then((result) {
          print(result);
      emit(state.copywith(
          pendingOrdersResult: result, pendingOrderState: 'loaded'));
    });
  }

  assingNoUsrid(){
    emit(state.copywith(
        pendingOrderState: 'Please Login to See Data',
      deliveredOrderStatus: 'Please Login to See Data',
      canceledOrdersSta: 'Please Login to See Data'
    ),
    );
  }

  getDliveredOrders(int userId) {
    repository.getDeliverdOrders(
        GQLQuries.deliveredOrderQuery, {'customer_id': userId}).then((result) {
          print(result.data);
      emit(state.copywith(
          deliveredOrderResult: result, deliveredOrderStatus: 'loaded'));
    });
  }

  getCanceledOrders(int userId) {
    repository.getCanceledOrders(
        GQLQuries.canceledOrdersQuery, {'customer_id': userId}).then((result) {
      emit(state.copywith(
          canceledOrdersRes: result, canceledOrdersSta: 'loaded'));
    });
  }

  trackOrder(int orderId) {
    repository
        .trackOrder(GQLQuries.trackOrderQuery, {'id': orderId}).then((result) {
      emit(state.copywith(trackOrderRes: result, trackOrderSta: 'loaded'));
    });
  }
}
