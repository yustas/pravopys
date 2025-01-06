import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/material.dart';

stylesheet(BuildContext context) {
  return MarkdownStyleSheet(
    h1: ThemeData()
        .textTheme
        .titleLarge!
        .copyWith(fontSize: 24, color: Colors.blue),
    listIndent: 25.0,
    //p: ThemeData().textTheme.bodyMedium!.copyWith(),
    //  pPadding: const EdgeInsets.only(bottom: 15),
    blockquote: ThemeData().textTheme.titleLarge!.copyWith(fontSize: 34),
    blockquotePadding: const EdgeInsets.all(15),
    blockquoteDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20.0),
        // border: Border(
        //     bottom: BorderSide(color: Theme.of(context).colorScheme.shadow),
        //     right: BorderSide(color: Theme.of(context).colorScheme.shadow)
        // )
    ),
    tableBorder: TableBorder(
        verticalInside: BorderSide(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          width: 1,
        ),
    ),
    tableCellsPadding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
    tableHead: TextStyle(
      fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,

    ),
    tableBody: TextStyle(
      fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
    ),
    tableColumnWidth: IntrinsicColumnWidth(),
    tableCellsDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
    )
  );
}
