import 'package:flutter/material.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class NavigationRailNotifier extends ChangeNotifier {
  int selectedIndex = 0;

  setNewIndex({required int value}) {
    selectedIndex = value;
    notifyListeners();
  }
}

class FlutterNavigationRailView extends StatelessWidget {
  const FlutterNavigationRailView({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationRailNotifier navigationRailNotifier({required bool renderUI}) =>
        Provider.of<NavigationRailNotifier>(context, listen: renderUI);

    renderRailItem(
        {required IconData defIcon,
        required IconData selectedIcon,
        required String label}) {
      return NavigationRailDestination(
          icon: Icon(defIcon, color: KConstantColors.whiteColor),
          selectedIcon: Icon(
            selectedIcon,
            color: KConstantColors.blueColor,
          ),
          label: Text(label));
    }

    renderHomeView() {
      int selectedIndex = navigationRailNotifier(renderUI: true).selectedIndex;

      buildContent({required String value}) {
        return Text("Render $value",
            style: KConstantTextstyles.bold(fontSize: 28));
      }

      switch (selectedIndex) {
        case 0:
          {
            return buildContent(value: "Home View");
          }

        case 1:
          {
            return buildContent(value: "Profile View");
          }

        default:
          {
            return buildContent(value: "Settings View");
          }
      }
    }

    return Scaffold(
        backgroundColor: KConstantColors.bgColor,
        appBar: CustomAppBar(title: "Navigation Rail"),
        body: Row(
          children: [
            NavigationRail(
                backgroundColor: KConstantColors.bgColor,
                destinations: <NavigationRailDestination>[
                  renderRailItem(
                      defIcon: Icons.home,
                      selectedIcon: Icons.home_filled,
                      label: "Home"),
                  renderRailItem(
                      defIcon: Icons.person_2_outlined,
                      selectedIcon: Icons.person,
                      label: "Home"),
                  renderRailItem(
                      defIcon: Icons.settings,
                      selectedIcon: Icons.settings,
                      label: "Home"),
                ],
                onDestinationSelected: (val) {
                  navigationRailNotifier(renderUI: false)
                      .setNewIndex(value: val);
                },
                selectedIndex:
                    navigationRailNotifier(renderUI: true).selectedIndex),
            VerticalDivider(color: KConstantColors.whiteColor),
            SizedBox(width: 30),
            renderHomeView()
          ],
        ));
  }
}
