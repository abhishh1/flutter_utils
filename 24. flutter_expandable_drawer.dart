import 'package:flutter/material.dart';
import 'package:ig_posts/features/1.flutter_frost_glass.view.dart';
import 'package:ig_posts/features/5.flutter_swiggy_button.dart';
import 'package:provider/provider.dart';

class DrawerNotifier extends ChangeNotifier {
  double drawerWidth = 300;
  bool isHalfExpanded = false;

  void setExpansion({required bool isHalf}) {
    isHalfExpanded = !isHalfExpanded;
    if (isHalf) {
      drawerWidth = 250;
      notifyListeners();
    } else {
      drawerWidth = 100;
      notifyListeners();
    }
  }
}

class FlutterExpandableDrawer extends StatelessWidget {
  const FlutterExpandableDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    DrawerNotifier drawerNotifier({required bool renderUI}) =>
        Provider.of<DrawerNotifier>(context, listen: renderUI);

    bool isHalfExpanded = drawerNotifier(renderUI: true).isHalfExpanded;
    double drawerWidth = drawerNotifier(renderUI: true).drawerWidth;

    Widget buildExpansionButton() {
      if (isHalfExpanded) {
        return CircleAvatar(
          backgroundColor: bgColor,
          child: IconButton(
              onPressed: () {
                drawerNotifier(renderUI: false).setExpansion(isHalf: false);
              },
              icon: const Icon(Icons.close, color: Colors.white)),
        );
      } else {
        return CircleAvatar(
          backgroundColor: bgColor,
          child: IconButton(
              onPressed: () {
                drawerNotifier(renderUI: false).setExpansion(isHalf: true);
              },
              icon: const Icon(Icons.open_in_browser, color: Colors.white)),
        );
      }
    }

    Widget shell(
        {required double width,
        required IconData iconData,
        required String title,
        required bool isHalfExpanded}) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          width: width,
          height: 50,
          decoration: BoxDecoration(
              color: bgColor, borderRadius: BorderRadius.circular(25)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(iconData, color: Colors.white),
              if (isHalfExpanded) const SizedBox(width: 20),
              if (isHalfExpanded) Text(title, style: regulerText),
            ],
          ),
        ),
      );
    }

    Widget buildSecondaryButton(
        {required IconData iconData, required String title}) {
      if (isHalfExpanded) {
        return shell(
            isHalfExpanded: isHalfExpanded,
            width: 200,
            iconData: iconData,
            title: title);
      } else {
        return shell(
            isHalfExpanded: isHalfExpanded,
            width: 50,
            iconData: iconData,
            title: title);
      }
    }

    return Scaffold(
      appBar: AppBar(
          title: Text("Flutter Expandable Drawer", style: boldText()),
          backgroundColor: bgColorFaint),
      backgroundColor: bgColor,
      drawer: Drawer(
        width: drawerWidth,
        backgroundColor: Colors.transparent,
        child: Container(
            decoration: BoxDecoration(
                color: bgColorFaint, borderRadius: BorderRadius.circular(50)),
            child: Column(
              children: [
                const SizedBox(height: 100),
                buildExpansionButton(),
                const SizedBox(height: 20),
                buildSecondaryButton(iconData: Icons.home, title: "Home"),
                buildSecondaryButton(iconData: Icons.info, title: "Info"),
                buildSecondaryButton(iconData: Icons.data_array, title: "Data"),
                buildSecondaryButton(
                    iconData: Icons.meeting_room, title: "Meeting"),
                buildSecondaryButton(
                    iconData: Icons.severe_cold, title: "Weather"),
                buildSecondaryButton(
                    iconData: Icons.perm_device_info, title: "Device"),
                buildSecondaryButton(
                    iconData: Icons.fullscreen, title: "Webview"),
                buildSecondaryButton(
                    iconData: Icons.settings, title: "Settings"),
                buildSecondaryButton(iconData: Icons.logout, title: "Logout"),
              ],
            )),
      ),
      body: Container(),
    );
  }
}
