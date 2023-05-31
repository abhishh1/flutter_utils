import 'package:flutter/material.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class CheckboxNotifier extends ChangeNotifier {
  bool isChecked = true;

  void toggleCheckmark() {
    isChecked = !isChecked;
    notifyListeners();
  }
}

class FlutterCheckboxDemoView extends StatelessWidget {
  const FlutterCheckboxDemoView({super.key});

  @override
  Widget build(BuildContext context) {
    CheckboxNotifier checkboxNotifier({required bool renderUI}) =>
        Provider.of<CheckboxNotifier>(context, listen: renderUI);

    bool isDark = checkboxNotifier(renderUI: true).isChecked;

    return Scaffold(
        backgroundColor:
            isDark ? KConstantColors.whiteColor : KConstantColors.bgColorFaint,
        appBar: CustomAppBar(title: "Flutter Checkbox"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              title: Text("Dark theme 🧛🏻‍♀️",
                  style: KConstantTextstyles.bold(
                      fontSize: 14,
                      color: isDark
                          ? KConstantColors.bgColor
                          : KConstantColors.whiteColor)),
              subtitle: Text("Changes theme of app to dark version",
                  style: KConstantTextstyles.light(
                      fontSize: 12,
                      color: isDark
                          ? KConstantColors.bgColor
                          : KConstantColors.whiteColor)),
              leading: Checkbox(
                  value: !checkboxNotifier(renderUI: true).isChecked,
                  onChanged: (val) {
                    checkboxNotifier(renderUI: false).toggleCheckmark();
                  }),
            )
          ],
        ));
  }
}
