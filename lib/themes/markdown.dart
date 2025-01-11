import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/material.dart';

stylesheet(BuildContext context) {
  return MarkdownStyleSheet(
      h1: ThemeData()
          .textTheme
          .titleLarge!
          .copyWith(fontSize: 24, color: Colors.blue),
      h6: ThemeData().textTheme.bodyLarge!.copyWith(),
      h6Padding: EdgeInsets.all(0),
      h6Align: WrapAlignment.start,
      // horizontalRuleDecoration: ShapeDecoration(
      //   shape: LinearBorder(
      //
      //   ),
      //     color: Colors.red,
      p: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
      strong: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
      em: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w100,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
      code: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(overflow: TextOverflow.fade),
      codeblockPadding: EdgeInsets.all(10),
      codeblockAlign: WrapAlignment.end,
      codeblockDecoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  width: 3))),
      //listIndent: 0,
      orderedListAlign: WrapAlignment.start,
      //p: ThemeData().textTheme.bodyMedium!.copyWith(),
      //  pPadding: const EdgeInsets.only(bottom: 15),
      // blockquote: ThemeData().textTheme.bodyMedium!.copyWith(
      //   // Doesn't applied
      //   // See: https://github.com/flutter/flutter/issues/81720
      //   //
      // ),
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
      ),
      textAlign: WrapAlignment.start
  );
}
