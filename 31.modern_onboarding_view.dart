import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';

class ModernOnboardingNotifier extends ChangeNotifier {
  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;

  void setPageIndex({required int newIndex}) {
    _currentPageIndex = newIndex;
    notifyListeners();
  }
}

class ModernOnboardingView extends StatefulWidget {
  const ModernOnboardingView({super.key});

  @override
  State<ModernOnboardingView> createState() => _ModernOnboardingViewState();
}

class _ModernOnboardingViewState extends State<ModernOnboardingView> {
  ModernOnboardingNotifier modernOnboardingNotifier({required bool renderUI}) =>
      Provider.of<ModernOnboardingNotifier>(context, listen: renderUI);

  @override
  Widget build(BuildContext context) {
    int currentPageIndex =
        modernOnboardingNotifier(renderUI: true).currentPageIndex;

    Widget onboardingBlock({required Color color}) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 500,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25), color: color),
        ),
      );
    }

    Widget dotIndicator() {
      customDot({required int index}) {
        bool isCurrentIndex = currentPageIndex == index;

        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: CircleAvatar(
            radius: isCurrentIndex ? 8 : 6,
            backgroundColor: isCurrentIndex
                ? KConstantColors.blueColor
                : KConstantColors.bgColorFaint,
          ),
        );
      }

      return SizedBox(
        width: 100,
        height: 50,
        child: ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return customDot(index: index);
            }),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: KConstantColors.bgColor,
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 500,
                  width: 500,
                  child: PageView(
                    onPageChanged: (index) {
                      modernOnboardingNotifier(renderUI: false)
                          .setPageIndex(newIndex: index);
                    },
                    children: [
                      onboardingBlock(color: KConstantColors.blueColor),
                      onboardingBlock(color: KConstantColors.redColor),
                      onboardingBlock(color: KConstantColors.purpleColor),
                      onboardingBlock(color: KConstantColors.bgColorFaint),
                      onboardingBlock(color: KConstantColors.whiteColor),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                dotIndicator(),
                SizedBox(height: 5),
                Text("Welcome back",
                    style: KConstantTextstyles.bold(fontSize: 46)),
                Text("You've been missed here!",
                    style: KConstantTextstyles.light(fontSize: 16)),
                SizedBox(height: 30),
                Container(
                  height: 50,
                  width: 400,
                  child: Center(
                      child: Text("Continue",
                          style: KConstantTextstyles.bold(fontSize: 16))),
                  decoration: BoxDecoration(
                      color: KConstantColors.blueColor,
                      borderRadius: BorderRadius.circular(25)),
                ),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  width: 300,
                  child: Center(
                      child: Text("Take a tour",
                          style: KConstantTextstyles.bold(fontSize: 16))),
                  decoration: BoxDecoration(
                      color: KConstantColors.purpleColor,
                      borderRadius: BorderRadius.circular(25)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
