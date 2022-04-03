import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:grocery_shopping/data/providers/orders_provider.dart';

class OrdersRepository {
  final homeProvider = OrdersProvider();
  Future<QueryResult> getPendingOrders(String query, varibale) async {
    final result = homeProvider.getPendingOrders(query, varibale);
    return result;
  }

  Future<QueryResult> getDeliverdOrders(String query, varibale) async {
    final result = homeProvider.getDeliveredOrders(query, varibale);
    return result;
  }

  Future<QueryResult> getCanceledOrders(String query, varibale) async {
    final result = homeProvider.getCanceledOrders(query, varibale);
    return result;
  }

  Future<QueryResult> trackOrder(String query, varibale) async {
    final result = homeProvider.trackOrder(query, varibale);
    return result;
  }
}
