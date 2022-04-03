part of 'home_cubit.dart';

class HomeState {
  final QueryResult? productResult;
  final QueryResult? categoryResult;
  final QueryResult? searchResult;
  final int? index;
  final String categoryState;
  final String? productState;
  final String? search;
  final String? searchState;
  final QueryResult? searchSuggestions;
  final QueryResult? favResult;
  final String? favState;
  final List<dynamic>? bannerImagesList;
  final String? bannerImageStatus;
  final List<ProductModel>? products;
  final List<FavoriteModel>? favorite;

  HomeState({
    this.index,
    this.categoryResult,
    this.productResult,
    this.searchResult,
    required this.categoryState,
    this.productState,
    this.search,
    this.searchState,
    this.searchSuggestions,
    this.favResult,
    this.favState,
    this.bannerImagesList,
    this.bannerImageStatus,
    this.products,
    this.favorite,
  });

  HomeState copywith({
    final QueryResult? productResult,
    final QueryResult? categoryResult,
    final int? indexx,
    final String? categoryState,
    final String? productState,
    final String? search,
    final QueryResult? searchRes,
    final String? searchSta,
    final QueryResult? searchSugges,
    final QueryResult? favRes,
    final String? favStat,
    final List<dynamic>? bannerImagesList1,
    final String? bannerImageStatus1,
    final List<ProductModel>? productss,
    final List<FavoriteModel>? favoriteee,
  }) {
    return HomeState(
      categoryResult: categoryResult ?? this.categoryResult,
      productResult: productResult ?? this.productResult,
      categoryState: categoryState ?? this.categoryState,
      productState: productState ?? this.productState,
      search: search ?? this.search,
      searchResult: searchRes ?? this.categoryResult,
      searchState: searchSta ?? searchState,
      searchSuggestions: searchSugges ?? searchSuggestions,
      index: indexx ?? index,
      favResult: favRes ?? favResult,
      favState: favStat ?? favState,
      bannerImagesList: bannerImagesList1 ?? bannerImagesList,
      bannerImageStatus: bannerImageStatus1 ?? bannerImageStatus,
      products: productss ?? products,
      favorite: favoriteee ?? favorite,
    );
  }
}
