import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:mova/i18n/ua.dart';
import 'package:mova/repository/content.dart';
import 'package:mova/models/page_data.dart';
import 'package:mova/models/content.dart';
import 'package:mova/widgets/error.dart';
import 'package:mova/widgets/loading.dart';
import 'package:mova/widgets/header.dart';
import 'package:mova/widgets/content_list.dart';
import 'package:mova/widgets/articles_list.dart';
import 'package:mova/utils/search.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class Pravopys extends StatefulWidget {
  const Pravopys({super.key, required this.content, required this.prevContent});

  final Content content;
  final Content? prevContent;

  @override
  State<Pravopys> createState() => _PravopysState();
}

class _PravopysState extends State<Pravopys> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    setState(() {}); // Trigger a rebuild
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Future<PageData> pageData =
        loadPage(parentContentId: widget.content.id);

    String getContentData(Content content) {
      return content.prefix.isNotEmpty
          ? "${content.prefix} ${content.data}"
          : content.data;
    }

    Orientation orientation = MediaQuery.of(context).orientation;
    // Define padding based on orientation
    EdgeInsetsGeometry padding;
    if (orientation == Orientation.portrait) {
      // Portrait mode
      padding =
          const EdgeInsets.all(0); // Add more padding in portrait if necessary
    } else {
      // Landscape mode
      padding = const EdgeInsets.symmetric(
          horizontal: 32.0, vertical: 0); // Adjust padding in landscape mode
    }

    var isFirstScreen = widget.prevContent == null;
    var header = getContentData(widget.content);
    var appBarTitle = isFirstScreen ? '' : getContentData(widget.prevContent!);
    var actions = [
      IconButton(
        icon: const Icon(Icons.search),
        tooltip: searchTitle,
        onPressed: () => search(context, ''),
      ),
      IconButton(
        icon: const Icon(Icons.home_rounded),
        tooltip: appTitle,
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (ctx) => const Pravopys(
                content: homeContent,
                prevContent: null,
              ),
            ),
            (Route<dynamic> route) => false,
          );
        },
      ),
    ];

    if (isFirstScreen) {
      FlutterNativeSplash.remove();
      appBarTitle = '';
      actions = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        centerTitle: false,
        titleSpacing: 0,
        actions: actions,
      ),
      body: Column(
        children: [
          Expanded(
              child: Padding(
            padding: padding,
            child: FutureBuilder<PageData>(
              future: pageData,
              builder:
                  (BuildContext context, AsyncSnapshot<PageData> snapshot) {
                if (snapshot.hasData) {
                  var links = snapshot.data!.content;
                  var articles = snapshot.data!.articles;

                  final log = Logger('List view builder');
                  log.info(
                      'Pravopys context: ${Theme.of(context).colorScheme.brightness}');

                  if (links.isNotEmpty) {
                    return Column(
                      children: [
                        Header(title: header, searchBar: isFirstScreen),
                        Expanded(
                          child: ContentList(
                              content: links, prevPage: widget.content),
                        ),
                      ],
                    );
                  } else {
                    return ArticlesList(
                      header: header,
                      articles: articles,
                      content: widget.content,
                    );
                  }
                } else if (snapshot.hasError) {
                  return Error(message: 'Error: ${snapshot.error}');
                } else {
                  return const Loading();
                }
              },
            ),
          ))
        ],
      ),
    );
  }
}
