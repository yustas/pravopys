import 'package:flutter/material.dart';
import 'package:mova/i18n/ua.dart';
import 'package:mova/repository/content.dart';
import 'package:mova/widgets/error.dart';
import 'package:mova/widgets/loading.dart';
import 'package:mova/widgets/search_list.dart';

import '../models/content.dart';

class ContentSearchDelegate extends SearchDelegate {
  ContentSearchDelegate() : super(searchFieldLabel: searchHint);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query.isEmpty ? close(context, null) : query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return emptySearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Future<List<Content>> searchData = findContent(needle: query);

    return FutureBuilder<List<Content>>(
      future: searchData,
      builder: (BuildContext context, AsyncSnapshot<List<Content>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return SearchList(results: snapshot.data!);
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

void search(BuildContext context, String needle) {
  showSearch(
      context: context, delegate: ContentSearchDelegate(), query: needle);
}

Widget emptySearchResults(BuildContext context) {
  return Center(
    child: Text(
      searchNotFond,
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
        color: Colors.grey,
      ),
    ),
  );
}
