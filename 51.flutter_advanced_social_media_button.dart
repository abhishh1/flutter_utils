import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class ButtonNotifier extends ChangeNotifier {
  bool isExpanded = false;

  void toggleButtonExapnsion() {
    isExpanded = !isExpanded;
    notifyListeners();
  }
}

class FlutterSocialMediaButtonView extends StatelessWidget {
  const FlutterSocialMediaButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    ButtonNotifier buttonNotifier({required bool renderUI}) =>
        Provider.of<ButtonNotifier>(context, listen: renderUI);

    showDefaultButton() {
      return GestureDetector(
        onTap: () {
          buttonNotifier(renderUI: false).toggleButtonExapnsion();
        },
        child: Container(
          height: 70,
          width: 220,
          child: Center(
              child: Text("Checkout my socials 🚀",
                  style: KConstantTextstyles.bold(fontSize: 14))),
          decoration: BoxDecoration(
              color: KConstantColors.bgColorFaint,
              borderRadius: BorderRadius.circular(12)),
        ),
      );
    }

    showExpandedButton() {
      return GestureDetector(
        onTap: () {
          buttonNotifier(renderUI: false).toggleButtonExapnsion();
        },
        child: Container(
          height: 70,
          width: 260,
          child: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(FontAwesomeIcons.twitter, color: KConstantColors.whiteColor),
              Icon(FontAwesomeIcons.facebook,
                  color: KConstantColors.whiteColor),
              Icon(FontAwesomeIcons.instagram,
                  color: KConstantColors.whiteColor),
              Icon(FontAwesomeIcons.linkedin, color: KConstantColors.whiteColor)
            ],
          )),
          decoration: BoxDecoration(
              color: KConstantColors.bgColorFaint,
              borderRadius: BorderRadius.circular(12)),
        ),
      );
    }

    return Scaffold(
        backgroundColor: KConstantColors.bgColor,
        appBar: CustomAppBar(title: "Custom Social Media Button"),
        body: Center(
          child: AnimatedCrossFade(
              secondCurve: Curves.easeInExpo,
              firstCurve: Curves.easeInCubic,
              firstChild: showDefaultButton(),
              secondChild: showExpandedButton(),
              crossFadeState: buttonNotifier(renderUI: true).isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: Duration(seconds: 1)),
        ));
  }
}
