import 'package:flutter/material.dart';
import 'package:mova/i18n/ua.dart';
import 'package:mova/repository/content.dart';
import 'package:mova/models/page_data.dart';
import 'package:mova/styles/markdown.dart';
import 'package:mova/widgets/error.dart';
import 'package:mova/widgets/loading.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

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
    final Future<PageData> pageData = loadPage(parentContentId: widget.parent);

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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<PageData>(
              future: pageData,
              builder: (BuildContext context, AsyncSnapshot<PageData> snapshot) {
                if (snapshot.hasData) {
                  var content = snapshot.data!.content;
                  var articles = snapshot.data!.articles;

                  if (content.isNotEmpty) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: content.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            openContent(
                              context,
                              content[index].id,
                              content[index].data,
                            );
                          },
                          child: MarkdownBody(
                              data: '# ${content[index].data}',
                              // selectable: true,
                              // onTapText: () {
                              //   openContent(
                              //     context,
                              //     content[index].id,
                              //     content[index].data,
                              //   );
                              // },
                            styleSheet: stylesheet,
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MarkdownBody(
                            data: articles[index].data,
                            styleSheet: stylesheet,
                          ),
                        );
                      },
                    );
                  }
                } else if (snapshot.hasError) {
                  return Error(message: 'Error: ${snapshot.error}');
                } else {
                  return const Loading();
                }
              },
            ))
          ],
        ),
      ),
    );
  }
}
