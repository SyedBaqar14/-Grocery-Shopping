import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:grocery_shopping/data/providers/init_provider.dart';

class OrdersProvider {
  final provider = InitProvider();

  Future<QueryResult> getPendingOrders(String query, variable) async {
    QueryOptions options =
        QueryOptions(document: gql(query), variables: variable,fetchPolicy: FetchPolicy.networkOnly);

    final result = await provider.client.query(options);

    return result;
  }

  Future<QueryResult> getDeliveredOrders(String query, variable) async {
    QueryOptions options =
        QueryOptions(document: gql(query), variables: variable,fetchPolicy: FetchPolicy.networkOnly);

    final result = await provider.client.query(options);

    return result;
  }

  Future<QueryResult> getCanceledOrders(String query, variable) async {
    QueryOptions options =
        QueryOptions(document: gql(query), variables: variable,fetchPolicy: FetchPolicy.networkOnly);

    final result = await provider.client.query(options);
    print(result);

    return result;
  }

  Future<QueryResult> trackOrder(String query, variable) async {
    QueryOptions options =
        QueryOptions(document: gql(query), variables: variable,fetchPolicy: FetchPolicy.networkOnly);

    final result = await provider.client.query(options);

    return result;
  }
}
