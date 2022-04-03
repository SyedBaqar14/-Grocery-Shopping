import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:grocery_shopping/logic/cubit/authentication/authentication_cubit.dart';
import 'package:grocery_shopping/logic/cubit/home/home_cubit.dart';
import 'package:grocery_shopping/views/components/asset_provider.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({Key? key, required this.categoryResult})
      : super(key: key);
  final QueryResult categoryResult;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context, listen: false);
    final authCubit = BlocProvider.of<AuthenticationCubit>(context, listen: false);
    return Row(
      children: List.generate(
        categoryResult.data?['listCategoriesFilter']['categorys'].length,
        (index) {
          final data = categoryResult.data?['listCategoriesFilter'];
          var d = data['categorys'];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                cubit.assignCategoryId(d[index]['id'],authCubit.getuserID);
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: 8,
                        right: 8,
                        top: index == 0 ? 8.0 : 0,
                        bottom: index == 0 ? 8.0 : 0),
                    decoration: BoxDecoration(
                        // color: Color(0xffE4F9E8),
                        borderRadius: BorderRadius.circular(15)),
                    child: index == 0
                        ? const AssetProvider(
                            asset: "assets/category_icon/all_prod.png",
                            height: 50,
                            width: 50,
                          )
                        : Image.network(
                            d[index]['image'],
                            height: 50,
                          ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    index == 0
                        ? "All Products"
                        : d[index]['description']['name'],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
