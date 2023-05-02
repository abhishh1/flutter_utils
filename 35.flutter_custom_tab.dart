import 'package:flutter/material.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class TabNavigatorNotifier extends ChangeNotifier {
  int selectedIndex = 0;

  void setTabIndex({required int newIndex}) {
    selectedIndex = newIndex;
    notifyListeners();
  }
}

class FlutterTabNavigataorView extends StatefulWidget {
  const FlutterTabNavigataorView({super.key});

  @override
  State<FlutterTabNavigataorView> createState() =>
      _FlutterTabNavigataorViewState();
}

class _FlutterTabNavigataorViewState extends State<FlutterTabNavigataorView> {
  TabNavigatorNotifier tabNavigatorNotifier({required bool renderUI}) =>
      Provider.of<TabNavigatorNotifier>(context, listen: renderUI);

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    showTabHolder() {
      miniTab(
          {required int index,
          required IconData iconData,
          required String title}) {
        bool isSelectedIndex =
            tabNavigatorNotifier(renderUI: true).selectedIndex == index;

        return GestureDetector(
          onTap: () {
            pageController.jumpToPage(index);
            tabNavigatorNotifier(renderUI: false).setTabIndex(newIndex: index);
          },
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(iconData, color: KConstantColors.whiteColor),
                  SizedBox(height: 10),
                  if (isSelectedIndex)
                    Container(
                      width: 20,
                      height: 2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: KConstantColors.purpleColor),
                    )
                ],
              ),
            ),
          ),
        );
      }

      return Row(
        children: [
          miniTab(index: 0, iconData: Icons.home, title: "Home"),
          SizedBox(width: 10),
          miniTab(index: 1, iconData: Icons.wifi, title: "Wifi"),
          SizedBox(width: 10),
          miniTab(index: 2, iconData: Icons.label, title: "Tag"),
        ],
      );
    }

    showPageContent() {
      _pageContent({required String title, required String data}) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: KConstantTextstyles.bold(fontSize: 42)),
            Text(data, style: KConstantTextstyles.light(fontSize: 12)),
          ],
        );
      }

      return SizedBox(
        height: 400,
        width: 500,
        child: PageView(
          controller: pageController,
          children: [
            _pageContent(title: "Home", data: "Some data reguarding home view"),
            _pageContent(title: "Wifi", data: "Some data reguarding wifi view"),
            _pageContent(title: "Tag", data: "Some data reguarding tag view")
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: KConstantColors.bgColor,
      appBar: CustomAppBar(title: "Custom Tab Navigator"),
      body: Column(
        children: [
          SizedBox(height: 50),
          showTabHolder(),
          SizedBox(height: 5),
          showPageContent()
        ],
      ),
    );
  }
}
