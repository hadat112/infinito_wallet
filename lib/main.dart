import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/Welcome/StartPage.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      supportedLocales: [
        Locale('en', 'US'),
      ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
      ],
      home: StartPage()
    );
  }
}