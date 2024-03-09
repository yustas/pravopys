import 'package:flutter/material.dart';
import 'package:mova/i18n/ua.dart';
import 'package:mova/repository/content.dart';
import 'package:mova/models/content.dart';
import 'package:mova/widgets/error.dart';
import 'package:mova/widgets/loading.dart';

class ContentList extends StatefulWidget {
  const ContentList({super.key, this.parent = 0, this.title = APP_TITLE});

  final int parent;
  final String title;

  @override
  State<ContentList> createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {

  @override
  Widget build(BuildContext context) {

    final Future<List<Content>> content = loadContent(parent: widget.parent);

    void openContent(
      BuildContext context,
      int parent,
      String title,
    ) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => ContentList(
            parent: parent,
            title: title,
          ),
        ),
      ); // Navigator.push(context, route)
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<List<Content>>(
            future: content,
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
                      onTap: () {
                        openContent(
                          context,
                          snapshot.data![index].id,
                          snapshot.data![index].data,
                        );
                      },
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
