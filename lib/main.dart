import 'package:country_code_picker/country_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    // return MaterialApp(
    //   localizationsDelegates: const [
    //     CountryLocalizations.delegate,
    //   ],
    //   builder: (context, child) => ResponsiveWrapper.builder(
    //       child,
    //       maxWidth: 1200,
    //       minWidth: 480,
    //       defaultScale: true,
    //       breakpoints: [
    //         const ResponsiveBreakpoint.resize(480, name: MOBILE),
    //         const ResponsiveBreakpoint.autoScale(800, name: TABLET),
    //         const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
    //       ],
    //       background: Container(color: const Color(0xFFF5F5F5))),
    //   initialRoute: '/',
    //   routes: {
    //     '/' :(context) => const StartPage()
    //   },
    // );
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
      return  const MaterialApp(
        // supportedLocales: [
        //   Locale('en', 'US'),
        // ],
        localizationsDelegates: [
          CountryLocalizations.delegate,
        ],
        home: StartPage()
      );
        
      } 
    );
  }
}