import 'package:flutter/material.dart';
import 'package:mova/widgets/search.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.title, required this.searchBar});

  final String title;
  final bool searchBar;

  @override
  Widget build(BuildContext context) {

    var children = <Widget>[
      SizedBox(
        width: double.infinity,
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
          textAlign: TextAlign.left,
        ),
      ),
      const SizedBox(height: 10),
    ];

    if (searchBar) {
      children.add(const Search());
      children.add(const SizedBox(height: 10));
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: children,
      ),
    );
  }
}
