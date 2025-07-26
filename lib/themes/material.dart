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
          scrolledUnderElevation: 0,
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
          scrolledUnderElevation: 0,
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
        // # Heading 2
        headlineMedium: ThemeData()
            .textTheme
            .headlineMedium!
            .copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: colorScheme.onSurface
        ),
        // # Heading 3
        headlineSmall:
            ThemeData().textTheme.headlineSmall!.copyWith(
                fontSize: 16,
                color: colorScheme.onSurface
            ),
        bodyLarge: GoogleFonts.roboto(textStyle: ThemeData().textTheme.bodyMedium!.copyWith(
          fontSize: 18,
          color: colorScheme.onSurfaceVariant,
        )),
        bodyMedium: GoogleFonts.roboto(textStyle: ThemeData().textTheme.bodyMedium!.copyWith(
            fontSize: 18,
            color: colorScheme.onSurfaceVariant,
        )),
        bodySmall: GoogleFonts.roboto(textStyle: ThemeData().textTheme.bodyMedium!.copyWith(
          fontSize: 15,
          color: colorScheme.onSurfaceVariant,
        )),
    );
  }
}
