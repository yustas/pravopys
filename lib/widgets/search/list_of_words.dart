import 'package:flutter/material.dart';
import 'package:mova/repository/content.dart';

import '../../models/content.dart';
import '../../models/search_data.dart';
import '../../screens/pravopys.dart';

class ListOfWords extends StatelessWidget {
  const ListOfWords({super.key, required this.results});

  final List<SearchData> results;

  @override
  Widget build(BuildContext context) {
    void openContent(
      BuildContext context,
      Content nextContent,
    ) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) =>
              Pravopys(content: nextContent, prevContent: searchContent),
        ),
      ); // Navigator.push(context, route)
    }

    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: results.length,
      itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              openContent(
                context,
                results[index],
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(20),
                  border: Border(
                      bottom: BorderSide(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            results[index].path,
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant
                          ),

                        ),
                        const SizedBox(height: 10,),
                        Text(
                            results[index].name,
                            style: Theme.of(context).textTheme.titleLarge
                        ),
                      ],
                    ),
                  ),
                  const Column(
                    children: [Icon(Icons.chevron_right)],
                  ),
                ],
              ),
            ));
        //Text(results[index].data);
      },
    );
  }
}
