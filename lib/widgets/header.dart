import 'package:flutter/material.dart';
import 'package:mova/utils/controllers.dart';
import 'package:mova/widgets/search.dart';

class Header extends StatefulWidget {
  const Header(
      {super.key,
      required this.title,
      required this.searchBar,
      required this.scrollController});

  final String title;
  final bool searchBar;
  final ScrollPositionController scrollController;

  @override
  State<Header> createState() => _HeaderState(scrollController);
}

class _HeaderState extends State<Header> {

  ScrollPosition? scrollPosition;
  double? fontSize = 24;
  double? height;
  TextOverflow? overflow;

  void doScroll(ScrollPosition scrollPosition) {
    scrollPosition = scrollPosition;
    setState(() {
      fontSize = scrollPosition.pixels > 0 ? 10 : 24;
      height = (scrollPosition.pixels > 0) ? 30 : null;
      overflow = (scrollPosition.pixels > 0) ? TextOverflow.ellipsis : null;
    });
  }

  _HeaderState(ScrollPositionController scrollController) {
    scrollController.doScroll = doScroll;
  }

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[
      const SizedBox(height: 10),
      SizedBox(
        width: double.infinity,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.headlineLarge,
            textAlign: TextAlign.left,
          ),
        ),
      ),
      const SizedBox(height: 10),
    ];

    if (widget.searchBar) {
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
