import 'package:flutter/material.dart';
import 'package:mova/widgets/search/search_modal_data.dart';
import '../../models/example.dart';
import '../../models/search_data.dart';
import '../../repository/content.dart';

late Future<List<SearchData>> _searchData;

class SearchModalBottom extends StatelessWidget {
  const SearchModalBottom({
    super.key,
    required this.example,
  });

  final Example example;

  @override
  Widget build(BuildContext context) {

    _searchData = findExampleContent(example);

    return Container(
      width: double.infinity,
      height: 300,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  example.word,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          Expanded(
            child: SearchModalData(
              searchData: _searchData,
            ),
          ),
        ],
      ),
    );
  }
}
