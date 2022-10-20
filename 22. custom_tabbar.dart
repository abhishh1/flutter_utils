import 'package:flutter/material.dart';
import 'package:ig_posts/features/0.abhishvek_header.dart';
import 'package:ig_posts/features/1.flutter_frost_glass.view.dart';
import 'package:ig_posts/features/5.flutter_swiggy_button.dart';
import 'package:provider/provider.dart';

class TabNotifier extends ChangeNotifier {
  int tabIndex = 0;

  void setTabIndex({required int kValue}) {
    tabIndex = kValue;
    notifyListeners();
  }
}

class CustomTabBarWidget extends StatelessWidget {
  const CustomTabBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TabNotifier tabNotifier({required bool renderUI}) =>
        Provider.of<TabNotifier>(context, listen: renderUI);

    Widget tabHolder({required int index, required String title}) {
      return ActionChip(
        backgroundColor: tabNotifier(renderUI: true).tabIndex == index
            ? Colors.blue
            : bgColorFaint,
        onPressed: () {
          tabNotifier(renderUI: false).setTabIndex(kValue: index);
        },
        label: Text(title, style: boldText()),
      );
    }

    int kIndex = tabNotifier(renderUI: true).tabIndex;

    Widget mainWidget() {
      subWidget({required String title}) {
        return Container(
          height: 650,
          width: 400,
          decoration: BoxDecoration(
              border: Border.all(width: 0.2, color: Colors.white),
              borderRadius: BorderRadius.circular(25)),
          child: Center(child: Text(title, style: boldText(fSize: 26))),
        );
      }

      if (kIndex == 0) {
        return subWidget(title: "Content for home");
      }
      if (kIndex == 1) {
        return subWidget(title: "Content for profile");
      }
      return subWidget(title: "Content for settings");
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: bgColorFaint,
            title: Text("Flutter Custom TabBar", style: boldText(fSize: 16))),
        backgroundColor: bgColor,
        body: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                tabHolder(index: 0, title: "Home"),
                tabHolder(index: 1, title: "Profile"),
                tabHolder(index: 2, title: "Settings"),
              ],
            ),
            const Divider(color: Colors.white, thickness: 0.1),
            const SizedBox(height: 10),
            mainWidget(),
            const SizedBox(height: 20),
            const AbhishvekHeaderWidget(),
          ],
        ));
  }
}
