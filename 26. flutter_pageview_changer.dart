import 'package:flutter/material.dart';
import 'package:ig_posts/features/1.flutter_frost_glass.view.dart';
import 'package:ig_posts/features/5.flutter_swiggy_button.dart';
import 'package:provider/provider.dart';

class PageChangerNotifier extends ChangeNotifier {
  int intialIndex = 0;

  final PageController pageController = PageController();

  changeIndex({required bool forward}) {
    debugPrint(forward.toString());
    if (forward) {
      intialIndex++;
      pageController.jumpToPage(intialIndex);
      notifyListeners();
    } else {
      if (intialIndex > 0) {
        intialIndex--;
        pageController.jumpToPage(intialIndex);
        notifyListeners();
      }
    }
  }
}

class FlutterPageChangerWidget extends StatelessWidget {
  const FlutterPageChangerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    PageChangerNotifier pageChangerNotifier({required bool renderUI}) =>
        Provider.of<PageChangerNotifier>(context, listen: renderUI);

    PageController pageController =
        pageChangerNotifier(renderUI: true).pageController;

    Widget changerButton(
        {required IconData iconData, required Function onTap}) {
      return GestureDetector(
        onTap: () {
          onTap();
        },
        child: CircleAvatar(
          backgroundColor: bgColor,
          child: Icon(iconData, color: Colors.white),
        ),
      );
    }

    int currentPageIndex = pageChangerNotifier(renderUI: true).intialIndex;

    return Scaffold(
      backgroundColor: bgColorFaint,
      appBar: AppBar(
          backgroundColor: bgColor,
          title: Text("Flutter page changer", style: boldText())),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Page index : $currentPageIndex", style: boldText(fSize: 30)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                changerButton(
                    iconData: Icons.arrow_back_ios,
                    onTap: () {
                      pageChangerNotifier(renderUI: false)
                          .changeIndex(forward: false);
                    }),
                SizedBox(
                  height: 600,
                  width: 300,
                  child: PageView.builder(
                    controller: pageController,
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 600,
                          width: 300,
                          decoration: BoxDecoration(
                              color: currentPageIndex % 2 == 0
                                  ? Colors.blue
                                  : Colors.red,
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: Text(index.toString(), style: boldText())),
                        ),
                      );
                    },
                  ),
                ),
                changerButton(
                    iconData: Icons.arrow_forward_ios,
                    onTap: () {
                      debugPrint("agaga");
                      pageChangerNotifier(renderUI: false)
                          .changeIndex(forward: true);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
