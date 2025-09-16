import 'package:fake_store/features/search/presentation/views/widgets/search_view_body.dart';
import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  static const routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: SearchViewBody());
  }
}
