import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_shopping/logic/cubit/home/home_cubit.dart';

class SearchHistory extends StatefulWidget {
  const SearchHistory({Key? key}) : super(key: key);

  @override
  _SearchHistoryState createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context);
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
      child: ListView.builder(
        itemCount: cubit.searchSharedList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (ctx, i) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.history),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(cubit.searchSharedList[i]),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => cubit.clearFromHistory(i),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
