import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:grocery_shopping/data/providers/init_provider.dart';
import 'package:grocery_shopping/utils/gql_mutations.dart';
import 'package:grocery_shopping/utils/gql_quries.dart';

class HomeProvider {
  final provider = InitProvider();

  Future<QueryResult> getCategoriesList() async {
    QueryOptions options = QueryOptions(document: gql(GQLQuries.categoryList));

    final result = await provider.client.query(options);

    return result;
  }

  Future<QueryResult> getBannerImages() async {
    QueryOptions options = QueryOptions(document: gql(GQLQuries.bannerQuery));

    final result = await provider.client.query(options);

    return result;
  }

  Future<QueryResult> getProductList(Map<String, dynamic> variable) async {
    QueryOptions options = QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(variable['customer_id'] == 0000 ? GQLQuries.findWithoutID: GQLQuries.findByCategory), variables: variable);

    final result = await provider.client.query(options);

    return result;
  }

  Future<QueryResult> searchProducts(Map<String, dynamic> variable) async {
    QueryOptions options =
        QueryOptions(document: gql(GQLQuries.searchQuery), variables: variable);

    final result = await provider.client.query(options);

    return result;
  }

  Future<QueryResult> getSuggestions(Map<String, dynamic> variable) async {
    QueryOptions options =
        QueryOptions(document: gql(GQLQuries.searchQuery), variables: variable);

    final result = await provider.client.query(options);

    return result;
  }

  Future<QueryResult> addToFav(Map<String, dynamic> variable) async {
    QueryOptions options = QueryOptions(
        document: gql(GQLMutation.addtoFavQuery), variables: variable);

    final result = await provider.client.query(options);

    return result;
  }

  Future<QueryResult> fetchFav(Map<String, dynamic> variable) async {
    QueryOptions options = QueryOptions(
        fetchPolicy: FetchPolicy.networkOnly,
        document: gql(GQLQuries.fetchFavQuery), variables: variable);

    final result = await provider.client.query(options);

    return result;
  }
}
