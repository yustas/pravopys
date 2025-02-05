import 'package:flutter/material.dart';
import 'package:mova/i18n/ua.dart';
import 'package:mova/repository/content.dart';
import 'package:mova/widgets/error.dart';
import 'package:mova/widgets/loading.dart';
import 'package:mova/widgets/search_list.dart';

import '../models/search_data.dart';

class ContentSearchDelegate extends SearchDelegate {
  ContentSearchDelegate() : super(searchFieldLabel: searchHint);

  setQuery(String text) {
    query = text;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query.isEmpty ? close(context, null) : query = '',
        style: IconButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onSurface
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
      style: IconButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onSurface
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchHint(context, setQuery);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final Future<List<SearchData>> searchData = findContent(needle: query);

    return FutureBuilder<List<SearchData>>(
      future: searchData,
      builder: (BuildContext context, AsyncSnapshot<List<SearchData>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return SearchList(results: snapshot.data!);
          } else if (query.isNotEmpty) {
            return EmptySearchResults(context);
          } else {
            return SearchHint(context, setQuery);
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

Widget SearchHint(BuildContext context, callback) {
  const examples = searchExamples;

  return Center(
    child: Column(
      children:[
        const SizedBox(height: 20,),
        Text(
          searchTry,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).hintColor,
          ),
        ),
        const SizedBox(height: 20,),
        Expanded(
          child: GridView.count(
            crossAxisCount: 4,
            children: List.from([
              ...examples.map((text) => SearchExample(context, text, callback))
            ],),
          ),
        )
      ]
      ),
  );
}

Widget SearchExample(BuildContext context, text, onTap) {
  return GestureDetector(
    child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text(text, textAlign: TextAlign.center,)),
        ),
    ),
    onTap: () => onTap(text),
  );
}

Widget EmptySearchResults(BuildContext context) {
  return const Center(
    child: Text(
      searchNotFond,
    ),
  );
}
