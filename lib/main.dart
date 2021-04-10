import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:zealth/provider/symptoms_provider.dart';
import 'package:zealth/view/menu.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SymptomProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zealth',
      theme: ThemeData(
        primaryColor: Colors.black,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        brightness: Brightness.light,
        primaryColorDark: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFF8F8F8),
          elevation: 0.0,
          titleTextStyle: TextStyle(color: Colors.black),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        platform: TargetPlatform.iOS,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFF8F8F8),
      ),
      home: Menu(),
    );
  }
}
