import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:grocery_shopping/data/providers/init_provider.dart';
import 'package:grocery_shopping/utils/gql_mutations.dart';
import 'package:grocery_shopping/utils/gql_quries.dart';

class CheckOutProvider {
  final provider = InitProvider();

  Future<QueryResult> checkAvailableDates(variable) async {

    QueryOptions queryOptions =
        QueryOptions(document: gql(GQLQuries.availableDilveryDatesQuery), variables: variable);

    final result = await provider.client.query(queryOptions);

    return result;
  }

  Future<QueryResult> placeOrder({required Map<String, dynamic> varialbes}) async {

    print(varialbes);

    MutationOptions options = MutationOptions(document: gql(GQLMutation.addOrder), variables: varialbes);
    final result = await provider.client.mutate(options);
    return result;
  }

  Future<QueryResult> applyCoupon({required Map<String, dynamic> variables}) async {

    MutationOptions options = MutationOptions(document: gql(GQLMutation.coupon), variables: variables);
    final result = await provider.client.mutate(options);
    return result;
  }

  Future<QueryResult> getDeliveryFee() async {

    QueryOptions options = QueryOptions(document: gql(GQLQuries.getDeliveryFee));

    final result = await provider.client.query(options);

    return result;
  }

  Future<QueryResult> addAddress({required Map<String, dynamic> variables}) async {

    MutationOptions options = MutationOptions(document: gql(GQLMutation.addAddress), variables: variables);
    final result = await provider.client.mutate(options);
    return result;
  }
}
