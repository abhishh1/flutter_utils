import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:ig_posts/features/1.flutter_frost_glass.view.dart';

class FlutterBottomBarView extends StatefulWidget {
  const FlutterBottomBarView({Key? key}) : super(key: key);

  @override
  State<FlutterBottomBarView> createState() => _FlutterBottomBarViewState();
}

class _FlutterBottomBarViewState extends State<FlutterBottomBarView> {
  int pageIndex = 0;
  PageController pageController = PageController();
  changeIndex({required int value}) {
    setState(() {
      pageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: bgColorFaint,
          title: const Text(
            "Animated bottom bar",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      backgroundColor: bgColor,
      body: PageView(
        controller: pageController,
        children: const [
          Center(
            child: Text(
              "Home view 🏠",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
            ),
          ),
          Center(
              child: Text(
            "Profile view 🧛",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          )),
        ],
      ),
      bottomNavigationBar: FluidNavBar(
        defaultIndex: pageIndex,
        style: const FluidNavBarStyle(
            iconUnselectedForegroundColor: bgColor,
            iconSelectedForegroundColor: Colors.white,
            iconBackgroundColor: Colors.deepOrangeAccent,
            barBackgroundColor: bgColorFaint),
        icons: [
          FluidNavBarIcon(icon: Icons.home),
          FluidNavBarIcon(icon: Icons.person),
        ],
        onChange: (val) {
          changeIndex(value: val);
          pageController.jumpToPage(pageIndex);
        },
      ),
    );
  }
}
