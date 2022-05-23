import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/Welcome/start_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: const FirebaseOptions(
    //   apiKey: 'AIzaSyAUOXWTxxb2je7EkAFsPRcm1jW1BPnr07E',
    //   appId: '1:10319697662:android:ab94551ce1a25bfcab77af',
    //   messagingSenderId: '10319697662',
    //   projectId: 'infinito-wallet-fea37',
    // ),
  );
  runApp(const MyApp());
} 

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // supportedLocales: [
      //   Locale('en', 'US'),
      // ],
      localizationsDelegates: [
        CountryLocalizations.delegate,
      ],
      home: StartPage()
    );
  }
}