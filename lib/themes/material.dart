import 'package:flutter/material.dart';

const Color seedColor = Colors.white;

ColorScheme lightColorScheme(context) {
  return ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.light,
    contrastLevel: 0,
    dynamicSchemeVariant: DynamicSchemeVariant.neutral
  );
}

ThemeData themeLight(BuildContext context) {
  return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme(context),
      textTheme: MaterialTheme.textTheme(lightColorScheme(context)),
      appBarTheme: AppBarTheme(
          backgroundColor: lightColorScheme(context).surface
      )
  );
}

class MaterialTheme {
  static TextTheme textTheme(ColorScheme colorScheme) {
    return ThemeData().textTheme.copyWith(
        // AppTitle
        titleLarge: ThemeData().textTheme.titleLarge!.copyWith(fontSize: 20),
        // # Heading 1
        headlineLarge: ThemeData()
            .textTheme
            .headlineLarge!
            .copyWith(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: colorScheme.onSurface
        ),
        headlineSmall:
            ThemeData().textTheme.headlineSmall!.copyWith(fontSize: 24),
        bodyMedium: ThemeData().textTheme.bodyMedium!.copyWith(
              fontSize: 15,
            ),
        bodySmall: ThemeData().textTheme.bodySmall!.copyWith(fontSize: 16));
  }

  static ThemeData light(BuildContext context) {
    return ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
          contrastLevel: 1,
          dynamicSchemeVariant: DynamicSchemeVariant.content,
        ),
        textTheme: MaterialTheme.textTheme(lightColorScheme(context)),
//        scaffoldBackgroundColor: const Color(0xFF931010),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white
            ));
  }

  static ThemeData dark(BuildContext context) {
    return ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
          contrastLevel: -1,
          dynamicSchemeVariant: DynamicSchemeVariant.content,
        ),
        textTheme: MaterialTheme.textTheme(lightColorScheme(context)),
//        scaffoldBackgroundColor: const Color(0xFF931010),
        appBarTheme: const AppBarTheme(
//            backgroundColor: Colors.amber
            ));
  }
}
