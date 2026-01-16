import 'package:cab_bandhu/features/auth/screens/splash_screen.dart';
import 'package:cab_bandhu/providers/local_provider.dart';
import 'package:cab_bandhu/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'dummy_api_data/food/provider/food_provider.dart';
import 'l10n/app_localizations.dart';
import 'providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()..loadTheme()),
        ChangeNotifierProvider(create: (_) => MealProvider()..loadCategories())
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
      builder: (context, localeProvider, themeProvider, child) {
        return  MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Cab Bandhu",
          locale: localeProvider.locale,  // Dynamic locale
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          themeMode: themeProvider.themeMode,  // Dynamic theme mode
          home: const OnboardingRideScreen(), // <-- add your first screen here
        );
      },
    );
  }
}