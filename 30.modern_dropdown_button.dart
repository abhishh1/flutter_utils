import 'package:flutter/material.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class ModernDropDownNotifier extends ChangeNotifier {
  bool _isButtonOpened = false;
  bool get isButtonOpened => _isButtonOpened;

  void toggleButtonState() {
    _isButtonOpened = !_isButtonOpened;
    notifyListeners();
  }
}

class ModernDropdownButtonView extends StatelessWidget {
  const ModernDropdownButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    ModernDropDownNotifier modernDropDownNotifier({required bool renderUI}) =>
        Provider.of<ModernDropDownNotifier>(context, listen: renderUI);

    bool isButtonOpened = modernDropDownNotifier(renderUI: true).isButtonOpened;

    Widget headerComponent() {
      return GestureDetector(
        onTap: () {
          modernDropDownNotifier(renderUI: false).toggleButtonState();
        },
        child: Container(
            decoration: BoxDecoration(
                color: KConstantColors.blueColor,
                borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Components",
                      style: KConstantTextstyles.bold(fontSize: 16)),
                  Column(
                    children: [
                      Icon(
                          !isButtonOpened
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          color: KConstantColors.whiteColor,
                          size: 10),
                      Icon(
                          isButtonOpened
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          color: KConstantColors.whiteColor,
                          size: 10)
                    ],
                  )
                ],
              ),
            )),
      );
    }

    Widget miniComponent({required IconData iconData, required String title}) {
      return ClipRRect(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 27),
                Text(title, style: KConstantTextstyles.bold(fontSize: 16)),
                const Spacer(),
                Icon(iconData, color: KConstantColors.blueColor, size: 17),
                SizedBox(width: 27),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: KConstantColors.bgColor,
        appBar: AppBar(
          title: Text("Modern dropdown button",
              style: KConstantTextstyles.light(fontSize: 16)),
        ),
        body: Center(
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            height: isButtonOpened ? 170 : 60,
            width: 200,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  headerComponent(),
                  SizedBox(height: 10),
                  if (isButtonOpened)
                    miniComponent(iconData: Icons.view_sidebar, title: "Pages"),
                  if (isButtonOpened)
                    miniComponent(
                        iconData: Icons.view_array_outlined, title: "Views"),
                  if (isButtonOpened)
                    miniComponent(
                        iconData: Icons.build_circle_outlined,
                        title: "Widgets"),
                  if (isButtonOpened) SizedBox(height: 5),
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: KConstantColors.bgColorFaint,
                borderRadius: BorderRadius.circular(25)),
          ),
        ));
  }
}
