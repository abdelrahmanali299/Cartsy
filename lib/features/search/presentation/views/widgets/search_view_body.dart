import 'package:fake_store/features/search/presentation/manager/search/search_cubit.dart';
import 'package:fake_store/features/search/presentation/views/widgets/recent_search_list_view.dart';
import 'package:fake_store/features/search/presentation/views/widgets/search_filter_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  late TextEditingController textEditingController;
  String text = '';
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    textEditingController.addListener(() {
      setState(() {
        text = textEditingController.text;
      });
    });
  }

  String? searchDate = 'sdfsdf';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Search',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 20),

          TextField(
            cursorColor: Colors.blue,
            controller: textEditingController,
            onChanged: (value) {
              context.read<SearchCubit>().filterProducts(productName: value);
            },
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.blue),

              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              hintText: 'Search for any product',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          const SizedBox(height: 20),
          text.isEmpty
              ? Row(
                  children: [
                    Text(
                      'Recent',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        context.read<SearchCubit>().clearRecentProducts();
                      },
                      child: Text(
                        'Clear all',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          const SizedBox(height: 20),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchError) {
                  return RecentSearchListView();
                } else if (state is SearchSuccess &&
                    textEditingController.text.isNotEmpty) {
                  return SearchFilterProducts(
                    date: (value) {
                      setState(() {
                        searchDate = value;
                      });
                    },
                    filterProducts: state.filteredProducts,
                  );
                }
                return RecentSearchListView(searchDate: searchDate);
              },
            ),
          ),
        ],
      ),
    );
  }
}
