import 'package:all_about_clubs/screens/clubs_overview_screen.dart';
import 'package:all_about_clubs/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ], supportedLocales: const [
      Locale('en', ''), // English, no country code
    ], title: 'Flutter Demo', theme: THEME_DATA, home: ClubsOverviewScreen());
  }
}
