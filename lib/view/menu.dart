import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:zealth/view/symptoms/symptoms_page.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 1);
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: PersistentIcon(
          path: 'assets/svg/Home.svg',
          title: 'Home',
        ),
      ),
      PersistentBottomNavBarItem(
        icon: PersistentIcon(
          path: 'assets/svg/termo.svg',
          title: "Symptoms",
        ),
      ),
      PersistentBottomNavBarItem(
        icon: PersistentIcon(
          path: 'assets/svg/medical.svg',
          title: "Medical",
        ),
      ),
      PersistentBottomNavBarItem(
        icon: PersistentIcon(
          path: 'assets/svg/Activity.svg',
          title: "Activity",
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
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
      ),
    );
  }
}

class PersistentIcon extends StatelessWidget {
  const PersistentIcon({
    Key key,
    this.title,
    this.path,
  }) : super(key: key);

  final String title;
  final String path;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        SvgPicture.asset(
          path,
          width: 28.0,
          height: 28.0,
        ),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    ));
  }
}
