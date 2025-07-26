import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mova/widgets/search/search_modal_bottom.dart';

import '../../models/example.dart';
import '../../repository/content.dart';
import '../loading.dart';
import 'empty_search_results.dart';

class SearchListWords extends StatefulWidget {
  const SearchListWords({
    super.key,
    required this.needle,
  });

  final String needle;

  @override
  State<SearchListWords> createState() => _SearchListWordsState();
}

class _SearchListWordsState extends State<SearchListWords> {

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  late final _pagingController = PagingController<int, Example>(
    getNextPageKey: (state) => state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) => loadExamples(page: pageKey, needle: widget.needle),
  );

  @override
  void didUpdateWidget(covariant SearchListWords oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.needle != widget.needle) {
      _pagingController.refresh();
    }
  }

  @override
  Widget build(BuildContext context) => PagingListener(
    controller: _pagingController,
    builder: (context, state, fetchNextPage) => PagedListView<int, Example>(
      state: state,
      fetchNextPage: fetchNextPage,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, item, index) => GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) => SearchModalBottom(example: item),
              );
            },
            child: Text(item.word)
        ),
        noItemsFoundIndicatorBuilder: (context) => emptySearchResults(context),
        newPageProgressIndicatorBuilder: (context) => const Loading(),
      ),
    ),
  );
}
