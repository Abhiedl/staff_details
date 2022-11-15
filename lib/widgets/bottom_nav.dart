import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pine_app/screens/screen1.dart';
import 'package:pine_app/screens/screen2.dart';

class BottomNav extends StatelessWidget {
  BottomNav({super.key});

  final PersistentTabController bottomController =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: bottomController,
      screens: screens(),
      items: navItem(),
      hideNavigationBarWhenKeyboardShows: true,
    );
  }

  List<Widget> screens() {
    return [
      const Screen1(),
      const Screen2(),
    ];
  }

  List<PersistentBottomNavBarItem> navItem() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person_add_alt_1_outlined),
          title: ('Screen 1'),
          textStyle: const TextStyle(fontSize: 20),
          activeColorPrimary: Colors.blue),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.group),
          title: ('Screen 2'),
          textStyle: const TextStyle(fontSize: 20),
          activeColorPrimary: Colors.blue),
    ];
  }
}
