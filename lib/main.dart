import 'package:flutter/material.dart';
import 'package:mova/screens/content_list.dart';
import 'package:logging/logging.dart';
import 'package:mova/i18n/ua.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time} | ${record.message}');
  });

  runApp(const MovaApp());
}

class MovaApp extends StatelessWidget {
  const MovaApp({super.key});

  @override
  Widget build(BuildContext context) {

    final textTheme = ThemeData().textTheme.copyWith(
        titleLarge: ThemeData().textTheme.titleLarge!.copyWith(fontSize: 24)
    );

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: textTheme,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: textTheme,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.system,

      home: const ContentList(),
    );
  }
}
