import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:ig_posts/utils/custom_buttons.dart';
import 'package:ig_posts/utils/dimensions.dart';
import 'package:ig_posts/utils/font_size.widget.dart';
import 'package:ig_posts/utils/text_styles.dart';

showBlurDialogBox(
    {required String title,
    String? description,
    required Function() actionTap,
    required BuildContext context}) {
  return showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AlertDialog(
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomRoundedButton(
                        radius: 50,
                        backgroundColor: KConstantColors.bgColorFaint,
                        width: 30,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        label: "No"),
                    hSizedBox2,
                    CustomRoundedButton(
                        backgroundColor: KConstantColors.redColor,
                        width: 30,
                        radius: 50,
                        onTap: () {
                          actionTap();
                        },
                        label: "Yes")
                  ],
                )
              ],
              backgroundColor: KConstantColors.bgColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              title: Text(title,
                  style: KCustomTextStyle.kBold(context, FontSize.kMedium + 2)),
              content: Text(description ?? "This action cannot be undone.👀",
                  style: KCustomTextStyle.kMedium(context, FontSize.kMedium)),
            ));
      });
}

class FlutterShowBlurBackgroundView extends StatelessWidget {
  const FlutterShowBlurBackgroundView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Text("Content by @abhishvek",
          style: KConstantTextstyles.light(fontSize: 12)),
      backgroundColor: KConstantColors.bgColor,
      body: Center(
        child: Column(
          children: [
            Image.network(
                "https://img.freepik.com/free-photo/forest-landscape_71767-127.jpg"),
            vSizedBox1,
            PrimaryActionButton(
                radius: 25,
                onTap: () {
                  showBlurDialogBox(
                      title: "Exit Flamingo?",
                      actionTap: () {},
                      context: context);
                },
                label: "Tap here"),
          ],
        ),
      ),
    );
  }
}
