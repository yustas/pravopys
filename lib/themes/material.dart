import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color seedColor = Colors.white;

ColorScheme lightColorScheme(context) {
  return ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.light,
    contrastLevel: 0,
    dynamicSchemeVariant: DynamicSchemeVariant.neutral
  );
}

ColorScheme darkColorScheme(context) {
  return ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.dark,
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
          backgroundColor: lightColorScheme(context).surface,
          foregroundColor: lightColorScheme(context).onSurface,
          actionsIconTheme: IconThemeData(
            color: lightColorScheme(context).onSurface,
          ),
//          iconTheme: Theme.of(context).primaryIconTheme.copyWith(color: Colors.green),
      )
  );
}

ThemeData themeDark(BuildContext context) {
  return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme(context),
      textTheme: MaterialTheme.textTheme(darkColorScheme(context)),
      appBarTheme: AppBarTheme(
          backgroundColor: darkColorScheme(context).surface,
          foregroundColor: darkColorScheme(context).onSurface,
          actionsIconTheme: IconThemeData(
            color: darkColorScheme(context).onSurface,
          ),
      )
  );
}

class MaterialTheme {
  static TextTheme textTheme(ColorScheme colorScheme) {
    return ThemeData().textTheme.copyWith(
        // AppTitle
        titleLarge: ThemeData().textTheme.titleLarge!.copyWith(
            fontSize: 20,
            color: colorScheme.onSurface
        ),
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
        // Tinos height: 1.3,

        bodyMedium: GoogleFonts.roboto(textStyle: ThemeData().textTheme.bodyMedium!.copyWith(
            fontSize: 18,
            color: colorScheme.onSurfaceVariant,
//          height: 1.3,
        )),
        bodySmall: ThemeData().textTheme.bodySmall!.copyWith(fontSize: 15),
    );
  }
}
