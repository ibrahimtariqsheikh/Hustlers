import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppColors {
  static const secondary = Color(0xFF3B76F6);
  static const accent = Color(0xFFD6755B);
  static const textDark = Color(0xFF53585A);
  static const textLight = Color(0xFFF5F5F5);
  static const textFaded = Color(0xFF9899A5);
  static const iconLight = Color(0xFFB1B4C0);
  static const iconDark = Color(0xFFB1B3C1);
  static const textHighlight = secondary;
  static const logoLight = Color(0xFF303334);
  static const logoDark = Color(0xFFF9FAFE);
  static const cardLight = Color(0xFFF9FAFE);
  static const cardDark = Color(0xFF1A1A1C);
  static const dividerLight = Color.fromRGBO(0, 0, 0, .15);
  static const dividerDark = Color.fromRGBO(255, 255, 255, .25);
  static const socialButtonColorLight = Colors.white;
  static const socialButtonBorderLight = Color(0xFFD6D6D6);
  static const socialButtonColorDark = Color.fromRGBO(20, 21, 24, 1);
  static const socialButtonBorderDark = Color.fromRGBO(40, 43, 50, 1);
}

abstract class _LightColors {
  static const background = Color(0xFFF2F1F6);
  static const logo = AppColors.logoLight;
  static const card = AppColors.cardLight;
  static const divider = AppColors.dividerLight;
  static const socialButton = {
    'background': AppColors.socialButtonColorLight,
    'border': AppColors.socialButtonBorderLight,
  };
}

abstract class _DarkColors {
  static const background = Color.fromRGBO(7, 7, 7, 1);
  static const logo = AppColors.logoDark;
  static const card = AppColors.cardDark;
  static const divider = AppColors.dividerDark;
  static const socialButton = {
    'background': AppColors.socialButtonColorDark,
    'border': AppColors.socialButtonBorderDark,
  };
}

abstract class _TextStyles {
  static TextStyle bodyLarge({required bool isDark}) {
    return GoogleFonts.urbanist(
      textStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: isDark ? AppColors.textLight : AppColors.logoLight,
      ),
    );
  }

  static TextStyle bodySmall({required bool isDark}) {
    return GoogleFonts.urbanist(
      textStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.textLight : AppColors.textDark,
      ),
    );
  }

  static TextStyle bodyMedium({required bool isDark}) {
    return GoogleFonts.urbanist(
      textStyle: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: isDark ? AppColors.textLight : Colors.black,
      ),
    );
  }

  static TextStyle displayLarge({required bool isDark}) {
    return GoogleFonts.urbanist(
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: isDark ? Colors.black : AppColors.textLight,
      ),
    );
  }

  static TextStyle displayMedium({required bool isDark}) {
    return GoogleFonts.urbanist(
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: isDark ? AppColors.textLight : AppColors.textDark,
      ),
    );
  }

  static TextStyle displaySmall() {
    return GoogleFonts.urbanist(
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textLight,
      ),
    );
  }
}

/// Reference to the application theme.
abstract class AppTheme {
  static final visualDensity = VisualDensity.adaptivePlatformDensity;

  /// Light theme and its settings.
  static ThemeData light() => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: _LightColors.logo,
        visualDensity: visualDensity,
        colorScheme: ColorScheme.light(
          background: _LightColors.background,
          primary: _LightColors.logo,
          secondary: _LightColors.socialButton['background'] as Color,
          secondaryContainer: _LightColors.socialButton['border'] as Color,
          onTertiary: _LightColors.divider,
        ),
        textTheme: GoogleFonts.urbanistTextTheme()
            .apply(
              bodyColor: AppColors.textDark,
            )
            .copyWith(
              bodyLarge: _TextStyles.bodyLarge(isDark: false),
              bodyMedium: _TextStyles.bodyMedium(isDark: false),
              bodySmall: _TextStyles.bodySmall(isDark: false),
              displayLarge: _TextStyles.displayLarge(isDark: false),
              displayMedium: _TextStyles.displayMedium(isDark: false),
              displaySmall: _TextStyles.displaySmall(),
            ),
        scaffoldBackgroundColor: _LightColors.background,
        cardColor: _LightColors.card,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          backgroundColor: _LightColors.background,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.black,
          selectedIconTheme: IconThemeData(color: Colors.black),
          backgroundColor: _LightColors.background,
          elevation: 0,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.iconDark,
        ),
      );

  /// Dark theme and its settings.
  static ThemeData dark() => ThemeData(
        useMaterial3: true,
        primaryColor: _DarkColors.logo,
        brightness: Brightness.dark,
        visualDensity: visualDensity,
        colorScheme: ColorScheme.dark(
          background: _DarkColors.background,
          primary: _DarkColors.logo,
          secondary: _DarkColors.socialButton['background'] as Color,
          secondaryContainer: _DarkColors.socialButton['border'] as Color,
          onTertiary: _DarkColors.divider,
        ),
        textTheme: GoogleFonts.urbanistTextTheme()
            .apply(bodyColor: AppColors.textLight)
            .copyWith(
              bodyLarge: _TextStyles.bodyLarge(isDark: true),
              bodyMedium: _TextStyles.bodyMedium(isDark: true),
              bodySmall: _TextStyles.bodySmall(isDark: true),
              displayLarge: _TextStyles.displayLarge(isDark: true),
              displayMedium: _TextStyles.displayMedium(isDark: true),
              displaySmall: _TextStyles.displaySmall(),
            ),
        scaffoldBackgroundColor: _DarkColors.background,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          backgroundColor: _DarkColors.background,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: _DarkColors.background,
          elevation: 0,
        ),
        cardColor: _DarkColors.card,
        iconTheme: const IconThemeData(
          color: AppColors.iconLight,
        ),
      );
}
