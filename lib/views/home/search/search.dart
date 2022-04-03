import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shopping/logic/cubit/home/home_cubit.dart';
import 'package:grocery_shopping/views/home/components/product_card.dart';
import 'package:grocery_shopping/views/home/search/history_page.dart';
import 'package:grocery_shopping/views/home/search/suggestion_list.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<HomeCubit>(context).disposeSearch();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                stretch: true,
                collapsedHeight: 60,
                expandedHeight: 80,
                pinned: true,
                backgroundColor: Colors.white,
                flexibleSpace: SizedBox(
                  height: 80,
                  child: Center(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            cubit.disposeSearch();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: TextField(
                                autofocus: true,
                                onChanged: (val) {
                                  cubit.assignSearch(val);
                                  if (val.length >= 2) {
                                    cubit.getSuggestions();
                                  }
                                },
                                onSubmitted: (val) {
                                  cubit.searchProducts();
                                  cubit.addToSearch(val);
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      "Search for fruits, vegetables, groce...",
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        if (state.searchState == 'loaded') ...[
                          ListView.builder(
                            itemCount: state.searchResult!
                                .data?['listProductsFilter']['products'].length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (ctx, i) {
                              if(state.searchResult!
                                  .data?['listProductsFilter']['products'].length <= 0){
                                return const Center(child: Text("No Product Result"),);
                              }else{
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: ProductsCard(
                                      data: state.searchResult!, i: i),
                                );
                              }
                            },
                          ),
                        ] else if (state.search == null ||
                            state.search!.length < 2) ...[
                          const HistoryPage()
                        ] else if (state.searchSuggestions == null) ...[
                          const Text("")
                        ] else
                          SuggestionList(result: state.searchSuggestions!)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
