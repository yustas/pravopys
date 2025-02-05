import 'package:flutter/material.dart';

import '../models/content.dart';
import '../screens/pravopys.dart';

class ContentList extends StatelessWidget {
  const ContentList({super.key, required this.content, required this.prevPage});

  final List<Content> content;
  final Content prevPage;

  @override
  Widget build(BuildContext context) {
    void openContent(
      BuildContext context,
      Content nextContent,
    ) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) =>
              Pravopys(content: nextContent, prevContent: prevPage),
        ),
      ); // Navigator.push(context, route)
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 0),
      child: Container(
        decoration: BoxDecoration(
//          color: Theme.of(context).colorScheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: content.length,
          itemBuilder: (context, index) {
            // Widget numeration = content[index].numeration.toString().isNotEmpty
            //     ? Text(content[index].numeration, style: Theme.of(context).textTheme.titleLarge)
            //     : Text('•', style: Theme.of(context).textTheme.titleLarge);

            return InkWell(
                onTap: () {
                  openContent(
                    context,
                    content[index],
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).colorScheme.outlineVariant,
                          ))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Column(
                      //   children: [
                      //     numeration,
                      //     const SizedBox(width: 25)
                      //   ],
                      // ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${content[index].name}',
                                style: Theme.of(context).textTheme.titleLarge)
                          ],
                        ),
                      ),
                      const Column(
                        children: [Icon(Icons.chevron_right)],
                      ),
                    ],
                  ),
                ));
          },
        ),
      ),
    );
  }
}
