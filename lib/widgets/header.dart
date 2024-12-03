import 'package:flutter/material.dart';
import 'package:mova/utils/controllers.dart';
import 'package:mova/widgets/search.dart';

class Header extends StatelessWidget {
  const Header(
      {super.key,
      required this.title,
      required this.searchBar,
      required this.scrollController});

  final String title;
  final bool searchBar;
  final ScrollPositionController scrollController;

  final double? fontSize = 24;

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      const SizedBox(height: 10),
      SizedBox(
        width: double.infinity,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.left,
          ),
        ),
      ),
      const SizedBox(height: 10),
    ];

    if (searchBar) {
      children.add(const Search());
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
