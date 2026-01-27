import 'package:cab_bandhu/providers/local_provider.dart';
import 'package:cab_bandhu/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dummy_api_data/food/provider/food_provider.dart';
import 'features/auth/screens/splash_first_screen.dart';
import 'l10n/app_localizations.dart';
import 'providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()..loadTheme()),
        ChangeNotifierProvider(create: (_) => MealProvider()..loadCategories()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<LocaleProvider, ThemeProvider>(
      builder: (context, localeProvider, themeProvider, _) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return MaterialApp(
              restorationScopeId:"app",
              debugShowCheckedModeBanner: false,
              title: "Cab Bandhu",

              /// 🌍 Localization
              locale: localeProvider.locale,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],

              /// 🎨 Theme + Font
              themeMode: themeProvider.themeMode,
              theme: ThemeData(
                textTheme: GoogleFonts.poppinsTextTheme(
                  Theme.of(context).textTheme,
                ),
              ),
              darkTheme: ThemeData.dark().copyWith(
                textTheme: GoogleFonts.poppinsTextTheme(
                  ThemeData.dark().textTheme,
                ),
              ),

              /// 🚀 First screen
              home: const SplashFirstScreen(),
            );
          },
        );
      },
    );
  }
}
