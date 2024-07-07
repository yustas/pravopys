import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchBar(
        padding: const MaterialStatePropertyAll<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 16.0, vertical: 0)),
        elevation: MaterialStateProperty.all(0.0),
        backgroundColor: MaterialStateProperty.all(Colors.black12),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
            )
        ),
        leading: const Icon(Icons.search));
  }
}
