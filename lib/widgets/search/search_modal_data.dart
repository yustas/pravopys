import 'package:flutter/cupertino.dart';

import '../../models/search_data.dart';
import '../loading.dart';
import '../error.dart';
import 'empty_search_results.dart';
import 'list_of_rules.dart';

class SearchModalData extends StatelessWidget {
  const SearchModalData({
    super.key,
    required this.searchData,
  });

  final Future<List<SearchData>> searchData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SearchData>>(
      future: searchData,
      builder:
          (BuildContext context, AsyncSnapshot<List<SearchData>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return ListOfRules(results: snapshot.data!);
          } else {
            return emptySearchResults(context);
          }
        } else if (snapshot.hasError) {
          return Error(message: 'Error: ${snapshot.error}');
        } else {
          return const Loading();
        }
      },
    );
  }
}