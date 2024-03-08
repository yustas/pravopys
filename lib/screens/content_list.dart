import 'package:flutter/material.dart';
import 'package:mova/utils/db.dart';
import 'package:mova/widgets/error.dart';
import 'package:mova/widgets/loading.dart';
import 'package:mova/i18n/ua.dart';

import '../models/content.dart';

class ContentList extends StatefulWidget {
  const ContentList({super.key});

  @override
  State<ContentList> createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  final Future<List<Content>> _content = loadContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(APP_TITLE),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<List<Content>>(
            future: _content,
            builder:
                (BuildContext context, AsyncSnapshot<List<Content>> snapshot) {
              if (snapshot.hasData) {
                var itemsCount = snapshot.data!.length;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: itemsCount,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data![index].data,
                          style: Theme.of(context).textTheme.titleLarge),
                      onTap: () {},
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Error(message: 'Error: ${snapshot.error}');
              } else {
                return const Loading();
              }
            },
          ))
        ],
      ),
    );
  }
}
