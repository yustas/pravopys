import 'package:flutter/material.dart';
import 'package:mova/widgets/search_row.dart';

class Header extends StatelessWidget {
  const Header(
      {super.key,
      required this.title,
      required this.searchBar});

  final String title;
  final bool searchBar;

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      const SizedBox(height: 10),
      SizedBox(
        width: double.infinity,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.left,
        ),
      ),
      const SizedBox(height: 10),
    ];

    if (searchBar) {
      children.add(const SearchRow());
      children.add(const SizedBox(height: 10));
    }

    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: children,
      ),
    );
  }
}
