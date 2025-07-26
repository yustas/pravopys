import 'package:flutter/material.dart';
import 'package:mova/widgets/search/search_list_words.dart';
import 'package:mova/widgets/search/search_results_rules.dart';
import 'package:mova/widgets/search/search_text_field.dart';
import 'package:mova/widgets/search/segmented_control.dart';
import '../i18n/ua.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  SearchSegment selectedSegment = SearchSegment.rules;
  String searchSubject = '';

  @override
  void initState() {
    super.initState();
    searchSubject = '';
  }

  @override
  Widget build(BuildContext context) {
    setSubject(String value) => setState(() {
          searchSubject = value;
        });

    Widget searchResults = switch (selectedSegment) {
      SearchSegment.rules => SearchResultsRules(
          subject: searchSubject,
          callback: setSubject,
        ),
      SearchSegment.examples => SearchListWords(
          needle: searchSubject,
        ),
    };

    return Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
          centerTitle: false,
          titleSpacing: 0,
          actions: const [
            SizedBox(width: 36.0),
          ],
        ),
        body: Column(children: [
          Expanded(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32.0, vertical: 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            searchTitle,
                            style: Theme.of(context).textTheme.headlineMedium,
                            textAlign: TextAlign.left,
                          ),
                          SegmentedControl(
                            selectedSegment: selectedSegment,
                            fieldValue: (SearchSegment value) {
                              setState(() {
                                selectedSegment = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      SearchTextField(
                        fieldValue: setSubject,
                        subject: searchSubject,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: searchResults,
                            )
                          ],
                        ),
                      )
                    ],
                  )))
        ]));
  }
}
