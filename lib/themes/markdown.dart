import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter/material.dart';

stylesheet(BuildContext context) {
  return MarkdownStyleSheet(
      h1: ThemeData().textTheme.titleLarge!.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.underline,
          decorationThickness: 0.5,
          decorationStyle: TextDecorationStyle.solid,
          color: Theme.of(context).colorScheme.onSurface),
      h1Padding: const EdgeInsets.only(top: 20, bottom: 10),
      h2: ThemeData().textTheme.headlineMedium!.copyWith(
          fontSize: 21,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface),
      h2Padding: const EdgeInsets.only(top: 10, bottom: 10),
      h3: ThemeData().textTheme.headlineSmall!.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onSurface),
      h6: ThemeData()
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onSurface),
      h6Padding: const EdgeInsets.all(0),
      h6Align: WrapAlignment.start,
      // horizontalRuleDecoration: ShapeDecoration(
      //   shape: LinearBorder(
      //
      //   ),
      //     color: Colors.red,
      p: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
      strong: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
      em: TextStyle(
        fontWeight: FontWeight.w100,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      code: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(overflow: TextOverflow.fade),
      codeblockPadding: const EdgeInsets.all(10),
      codeblockAlign: WrapAlignment.end,
      codeblockDecoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  width: 3))),
      listIndent: 26,
      //listBulletPadding: EdgeInsets.only(right: 10),
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
      tableBorder: TableBorder.all(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          width: 1,
          borderRadius: BorderRadius.circular(10)),
      // tableBorder: TableBorder(
      //   verticalInside: BorderSide(
      //     color: Theme.of(context).colorScheme.surfaceContainerHigh,
      //     width: 1,
      //   ),
      // ),
      tableCellsPadding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
      tableHead: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(fontWeight: FontWeight.w600),
      tableBody: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(fontStyle: FontStyle.normal),
      tableColumnWidth: const IntrinsicColumnWidth(),
      tableCellsDecoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
      textAlign: WrapAlignment.start);
}
