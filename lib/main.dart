import 'package:flutter/material.dart';
import 'package:mova/screens/content_list.dart';
import 'package:logging/logging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
        // AppTitle
        titleLarge: ThemeData().textTheme.titleLarge!.copyWith(fontSize: 24),
        // # Heading 1
        headlineSmall: ThemeData().textTheme.headlineSmall!.copyWith(fontSize: 24),
        bodyMedium: ThemeData().textTheme.bodyMedium!.copyWith(
            fontSize: 20,
        ),
        bodySmall: ThemeData().textTheme.bodySmall!.copyWith(fontSize: 16)
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
