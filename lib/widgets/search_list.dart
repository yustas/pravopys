import 'package:flutter/material.dart';

import '../models/content.dart';
import '../models/search_data.dart';
import '../screens/pravopys.dart';

class SearchList extends StatelessWidget {
  const SearchList({super.key, required this.results});

  final List<SearchData> results;

  @override
  Widget build(BuildContext context) {
    void openContent(
        BuildContext context,
        Content nextContent,
        ) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => Pravopys(content: nextContent, prevContent: null),
        ),
      ); // Navigator.push(context, route)
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: results.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                // openContent(
                //   context,
                //   results[index],
                // );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Color.fromARGB(70, 150, 150, 150)))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [Text(results[index].prefix)],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(results[index].data)],
                      ),
                    ),
                    const Column(
                      children: [Icon(Icons.chevron_right)],
                    ),
                  ],
                ),
              )
          );

          //Text(results[index].data);
        },
      ),
    );
  }
}
