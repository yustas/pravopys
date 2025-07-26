import 'package:flutter/material.dart';
import 'package:mova/widgets/search/search_hint_rules.dart';

import '../../models/search_data.dart';
import '../../repository/content.dart';
import '../loading.dart';
import '../error.dart';
import 'list_of_rules.dart';
import 'empty_search_results.dart';

late Future<List<SearchData>> _searchData;

class SearchResultsRules extends StatelessWidget {
  const SearchResultsRules(
      {super.key,
        required this.subject,
        required this.callback});

  final String subject;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    _searchData = findContent(needle: subject);

    if (subject.isEmpty) {
      return searchHintRules(context, callback);
    }
    return FutureBuilder<List<SearchData>>(
      future: _searchData,
      builder:
          (BuildContext context, AsyncSnapshot<List<SearchData>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return ListOfRules(results: snapshot.data!);
          } else if (subject.isNotEmpty) {
            return emptySearchResults(context);
          } else {
            return searchHintRules(context, callback);
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
