import 'package:flutter/material.dart';
import 'package:pine_app/screens/screen1.dart';
import 'package:pine_app/screens/screen2.dart';
import 'package:pine_app/widgets/bottom_nav.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = [
    const Screen1(),
    const Screen2(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNav(),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: selectedIndexNotifier,
        builder: (context, int updatedIndex, _) {
          return _pages[updatedIndex];
        },
      )),
    );
  }
}
