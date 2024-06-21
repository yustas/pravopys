import 'package:flutter/material.dart';
import 'package:mova/i18n/ua.dart';
import 'package:mova/repository/content.dart';
import 'package:mova/models/page_data.dart';
import 'package:mova/models/content.dart';
import 'package:mova/styles/markdown.dart';
import 'package:mova/widgets/error.dart';
import 'package:mova/widgets/loading.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class ContentList extends StatefulWidget {
  const ContentList({
    super.key,
    required this.content,
  });

  final Content content;

  @override
  State<ContentList> createState() => _ContentListState();
}

class _ContentListState extends State<ContentList> {
  @override
  Widget build(BuildContext context) {
    final Future<PageData> pageData = loadPage(parentContentId: widget.content.id);

    void openContent(
      BuildContext context,
      Content content,
    ) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => ContentList(content: content),
        ),
      ); // Navigator.push(context, route)
    }

    if (widget.content.data == APP_TITLE) {
      FlutterNativeSplash.remove();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.content.prefix} ${widget.content.data}'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
        child: Column(
          children: [
            Expanded(
                child: FutureBuilder<PageData>(
              future: pageData,
              builder:
                  (BuildContext context, AsyncSnapshot<PageData> snapshot) {
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
                              content[index],
                            );
                          },
                          child: MarkdownBody(
                            data:
                                '# ${content[index].prefix} ${content[index].data}',
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
