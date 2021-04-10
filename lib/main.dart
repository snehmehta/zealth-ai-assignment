import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:zealth/view/symptoms_page.dart';

void main() {
  runApp(MyApp());
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

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: 'Home',
        activeColorPrimary: Colors.pink,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: 'Symptoms',
        activeColorPrimary: Colors.pink,
      ),
      PersistentBottomNavBarItem(
        icon: Image.asset(
          'assets/icons/medical.png',
          fit: BoxFit.fill,
        ),
        title: 'Medication',
        activeColorPrimary: Colors.pink,
      ),
      PersistentBottomNavBarItem(
        activeColorPrimary: Colors.pink,
        icon: Image.asset('assets/icons/Activity.png'),
        title: 'Reports',
        textStyle: TextStyle(
          color: Colors.black,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: [
        SymptomsPage(),
        SymptomsPage(),
        SymptomsPage(),
        SymptomsPage(),
      ],
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }
}
