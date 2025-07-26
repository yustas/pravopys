import 'package:flutter/material.dart';
import 'package:mova/widgets/search/search_example.dart';

import '../../models/search_hint.dart';
import '../../i18n/ua.dart';
import '../../utils/history.dart';

List<String> examples = searchExamples.toList();
String title = searchTry;

Future<SearchHint> showExamples(context, onTap) async {
  //List<String> examples = (searchExamples.toList()..shuffle()).getRange(0, 6).toList();
  List<String>? history = await getHistory();
  //List<String> words = history ?? examples;
  List<String> words = examples;

  bool isHistory = words == history;
  List<Widget> cards =
  List.from([...words.map((word) => searchExample(context, word, onTap))]);

  return SearchHint(isHistory: isHistory, cards: cards);
}

Widget searchHintRules(BuildContext context, Function callback) {
  FutureBuilder<SearchHint> examplesGrid = FutureBuilder<SearchHint>(
      future: showExamples(context, callback),
      builder: (BuildContext context, AsyncSnapshot<SearchHint> snapshot) {
        List<Widget> cards = [];
        if (snapshot.hasData) {
          cards = snapshot.data?.cards ?? [];
          title = snapshot.data!.isHistory ? searchHistory : searchTry;
        }

        return Wrap(
          spacing: 8.0, // Horizontal spacing between boxes
          runSpacing: 8.0,
          children: cards,
        );
      });

  return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [Expanded(child: examplesGrid)],
          ),
        )
      ]);
}

