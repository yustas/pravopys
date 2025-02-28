import 'package:flutter/material.dart';
import 'package:mova/i18n/ua.dart';
import 'package:mova/repository/content.dart';
import 'package:mova/widgets/error.dart';
import 'package:mova/widgets/loading.dart';
import 'package:mova/widgets/search_list.dart';
import 'package:mova/utils/history.dart';

import '../models/search_data.dart';
import '../models/search_hint.dart';

String title = searchTry;

void search(BuildContext context, String needle) {
  showSearch(
      context: context, delegate: ContentSearchDelegate(), query: needle);
}

class ContentSearchDelegate extends SearchDelegate {
  ContentSearchDelegate() : super(searchFieldLabel: searchHintText);

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
    return searchHint(context, setQuery);
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
            return emptySearchResults(context);
          } else {
            return searchHint(context, setQuery);
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

Widget searchHint(BuildContext context, Function callback) {
  FutureBuilder<SearchHint> examplesGrid = FutureBuilder<SearchHint>(
      future: showExamples(context, callback),
      builder: (BuildContext context, AsyncSnapshot<SearchHint> snapshot) {
        List<Widget> cards = [];
        if (snapshot.hasData) {
          cards = snapshot.data?.cards ?? [];
          title = snapshot.data!.isHistory
              ? searchHistory
              : searchTry;
        }

        return GridView.count(
          crossAxisCount: 4,
          children: cards,
        );
      }
  );

  return Center(
    child: Column(
      children:[
        const SizedBox(height: 20,),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Theme.of(context).hintColor,
          ),
        ),
        const SizedBox(height: 20,),
        Expanded(
          child: examplesGrid,
        )
      ]
      ),
  );
}

Future<SearchHint> showExamples(context, onTap) async {
  List<String> examples = (searchExamples.toList()..shuffle()).getRange(0, 4).toList();
  List<String>? history = await getHistory();
  //List<String> words = history ?? examples;
  List<String> words = examples;

  bool isHistory = words == history;
  List<Widget> cards = List.from([
    ...words.map((word) => searchExample(context, word, onTap))
  ]);

  return SearchHint(isHistory: isHistory, cards: cards);
}

Widget searchExample(BuildContext context, text, onTap) {
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

Widget emptySearchResults(BuildContext context) {
  return const Center(
    child: Text(
      searchNotFond,
    ),
  );
}
