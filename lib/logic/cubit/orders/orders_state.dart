part of 'orders_cubit.dart';

class OrdersState {
  final QueryResult? pendingOrdersResult;
  final String? pendingOrderState;
  final QueryResult? deliveredOrderResult;
  final String? deliveredOrderStatus;
  final QueryResult? canceledOrdersResult;
  final String? canceledOrdersStatus;
  final QueryResult? trackOrderResult;
  final String? trackOrderStatus;

  OrdersState({
    this.pendingOrdersResult,
    this.pendingOrderState,
    this.deliveredOrderResult,
    this.deliveredOrderStatus,
    this.canceledOrdersResult,
    this.canceledOrdersStatus,
    this.trackOrderResult,
    this.trackOrderStatus,
  });

  OrdersState copywith({
    final QueryResult? pendingOrdersResult,
    final String? pendingOrderState,
    final QueryResult? deliveredOrderResult,
    final String? deliveredOrderStatus,
    final QueryResult? canceledOrdersRes,
    final String? canceledOrdersSta,
    final QueryResult? trackOrderRes,
    final String? trackOrderSta,
  }) {
    return OrdersState(
      deliveredOrderResult: deliveredOrderResult ?? this.deliveredOrderResult,
      deliveredOrderStatus: deliveredOrderStatus ?? this.deliveredOrderStatus,
      pendingOrderState: pendingOrderState ?? this.pendingOrderState,
      pendingOrdersResult: pendingOrdersResult ?? this.pendingOrdersResult,
      canceledOrdersResult: canceledOrdersRes ?? canceledOrdersResult,
      canceledOrdersStatus: canceledOrdersSta ?? canceledOrdersStatus,
      trackOrderResult: trackOrderRes ?? trackOrderResult,
      trackOrderStatus: trackOrderSta ?? trackOrderStatus,
    );
  }
}
