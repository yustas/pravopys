import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mova/utils/search.dart';

import '../i18n/ua.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
      return SearchBar(
        //onTap: controller.openView,
        onTap: () => search(context, ''),
        onChanged: (text) { search(context, text); controller.text = ""; },
        controller: controller,
        padding: const MaterialStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0, vertical: 0)),
        elevation: MaterialStateProperty.all(0.0),
        backgroundColor:
            MaterialStateProperty.all(const Color.fromARGB(255, 240, 240, 240)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        )),
        leading: const Icon(Icons.search),
        hintText: SEARCH_TITLE,
        textStyle: MaterialStatePropertyAll<TextStyle>(TextStyle(
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize)),
      );
    }, suggestionsBuilder: (BuildContext context, SearchController controller) => {  },);
  }
}
