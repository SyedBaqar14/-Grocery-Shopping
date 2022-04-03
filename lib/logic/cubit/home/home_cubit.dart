import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:grocery_shopping/data/model/favorite_model.dart';
import 'package:grocery_shopping/data/model/product_model.dart';
import 'package:grocery_shopping/data/repository/home_repostiory.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(HomeState(
          categoryState: 'searching',
          productState: 'searching',
          searchState: 'searching',
          favState: "searching",
          bannerImageStatus: "searching",
          favorite: [],
          products: [],
        ));

  final repository = HomeRepository();
  List<String> searchSharedList = [];
  static int categoryId = 0;

  int get getCatID => categoryId;

  assignCategoryId(int id, int userID) {
    categoryId = id;
    emit(state.copywith(productState: 'searching', productss: []));
    getProductsList(userID);
  }

  refreshProduct(int userID) {
    emit(state.copywith(productState: 'searching', productResult: null));
    getProductsList(userID);
  }

  assignSearch(String query) {
    emit(state.copywith(search: query));
  }

  assignIndex(int index) {
    emit(state.copywith(indexx: index));
  }

  addToSearch(String query) {
    if (!searchSharedList.contains(query)) {
      searchSharedList.add(query);
    }
    addSearchToShared();
  }

  clearFromHistory(int ind) {
    searchSharedList.removeAt(ind);
    addSearchToShared();
  }

  getCategoryList() {
    repository.getCategoriesList().then((result) {
      // print("myD ata = ${result}");
      // print("myD ata = ${state.categoryState}");
      emit(state.copywith(categoryResult: result, categoryState: 'loaded'));
    });
  }

  getBannerImages() {
    repository.getBannerImages().then((result) {
      emit(state.copywith(
          bannerImagesList1: result.data?['listPromotions']['promotions'],
          bannerImageStatus1: 'loaded'));
    });
  }

  List<ProductModel> productList = [];
  List<FavoriteModel> favList = [];

  getProductsList(int userID) {
    productList = [];
    print(categoryId);
    repository.getProductsList(
        {'category_id': categoryId, 'customer_id': userID}).then((result) {
      var d = result.data?['listProductsFilter']['products'];
      for (var i = 0; i < d.length; i++) {
        productList.add(
        ProductModel(
          id: d[i]['id'],
          name: d[i]['description']['name'],
          description: d[i]['description']['description'],
          price: double.parse(d[i]['price'].toString()),
          discount: d[i]['discount_price'],
          Image: d[i]['image'],
          isAddedFav: d[i]['is_exisit_favourite'] == 0 ? false : true,
        ));
      }
      emit(state.copywith(
          productResult: result,
          productState: 'loaded',
          productss: productList));
      // print("categorrrrrry  ====${state.categoryResult}");
    });
  }

  searchProducts() {
    repository.searchProducts({
      'search': state.search,
    }).then((result) {
      emit(state.copywith(searchRes: result, searchSta: "loaded"));
    });
  }

  getSuggestions() {
    repository.getSuggestions({
      'search': state.search,
    }).then((result) {
      emit(state.copywith(
        searchSugges: result,
      ));
    });
  }

  disposeSearch() {
    emit(state.copywith(searchSta: 'searching', searchRes: null));
  }

  removeAddFavState(int ind) {
    favList = [];
    productList[ind].isAddedFav = !productList[ind].isAddedFav;
    emit(state.copywith(productss: productList,favoriteee: []));
  }

  addToFavState(int productId, int userId){
    repository.addToFav({'product_id': productId, 'customer_id': userId}).then(
            (value) {
          Fluttertoast.showToast(msg: "Product Removed from Favorite");
        });
  }

  addToFav(int productId, int userId) {
    repository.addToFav({'product_id': productId, 'customer_id': userId}).then(
        (value) {
      Fluttertoast.showToast(msg: "Product Added to Favorite");
      fetchFav(userId);
    });
  }

  getSearchShared() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    var history = pre.getStringList('search');
    searchSharedList = history ?? [];
  }

  addSearchToShared() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setStringList('search', searchSharedList);
    getSearchShared();
  }

  removeFromFavState(int index) {
    favList.removeAt(index);
    emit(state.copywith(favoriteee: favList));
  }

  fetchFav(int userId) {
    favList=[];
    repository.fetchFav({'customer_id': userId}).then((result) {
      var d = result.data?['getFavouriteProductsByCustomer']['products'];
      for (var fav in d) {
        favList.add(FavoriteModel(
          id: fav['id'],
          image: fav['image'],
          name: fav['description']['name'],
          price: double.parse(fav['price'].toString()),
          isAddedFav: fav['is_exisit_favourite'] == 0 ? false : true,
        ));
      }
      emit(state.copywith(
          favStat: 'loaded', favRes: result, favoriteee: favList));
    });
  }
  assignNoUserId(){
    emit(state.copywith(favStat: 'Please Login to see Data'));
  }
}
