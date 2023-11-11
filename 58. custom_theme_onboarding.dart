import 'package:awesome_widgets/awesome_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

// 1. PLEASE ADD A STAR TO THIS REPOSITORY
// 2. FOLLOW ME ON INSTAGRAM : https://www.instagram.com/abhishvek/
// 3. SUBSCRIBE MY YOUTUBE CHANNEL : https://www.youtube.com/channel/UCIxJGxcB4pSrIvuv8FyuqUA 

class OnboardNotifier extends ChangeNotifier {
  String authType = "login";

  setAuthType({required String kValue}) {
    authType = kValue;
    notifyListeners();
  }
}

class OnBoardUI extends StatelessWidget {
  const OnBoardUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier =
        Provider.of<ThemeNotifier>(context, listen: true);
    Color dark = KConstantColors.bgColor;
    Color light = KConstantColors.whiteColor;
    OnboardNotifier onboardNotifier({required bool renderUI}) =>
        Provider.of<OnboardNotifier>(context, listen: renderUI);
    return Sizer(builder: ((context, orientation, deviceType) {
      return MaterialApp(
          theme:
              ThemeData(backgroundColor: themeNotifier.isDark ? dark : light),
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              floatingActionButton: FloatingActionButton(
                  onPressed: null,
                  backgroundColor: Colors.deepPurpleAccent,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: KConstantColors.inverseConditionalColor(
                        context: context),
                  )),
              body: Column(
                children: [
                  AwesomeDimensions.vSizedBox3,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        themeNotifier.toggleTheme();
                      },
                      child: ClipRRect(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.deepPurpleAccent,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Image.asset("assets/images/onboard.png"))),
                    ),
                  ),
                  AwesomeDimensions.vSizedBox3,
                  Text("Discover your\n dream job here!",
                      textAlign: TextAlign.center,
                      style: KCustomTextStyle.kBold(
                          context,
                          30,
                          KConstantColors.inverseConditionalColor(
                              context: context))),
                  AwesomeDimensions.vSizedBox2,
                  Text(
                      "Explore the most demanding jobs\n out there from the entire technology world!",
                      textAlign: TextAlign.center,
                      style: KCustomTextStyle.kMedium(
                          context,
                          12,
                          KConstantColors.inverseConditionalColor(
                              context: context))),
                  AwesomeDimensions.vSizedBox3,
                  AwesomeDimensions.vSizedBox1,
                  Container(
                    width: 400,
                    height: 50,
                    child: Row(
                      children: [
                        AwesomeButton.roundedIconButton(
                            titleTextstyle: KCustomTextStyle.kMedium(
                                context,
                                10,
                                KConstantColors.conditionalColor(
                                    context: context)),
                            onTap: () {
                              onboardNotifier(renderUI: false)
                                  .setAuthType(kValue: "login");
                            },
                            width: 200,
                            radius: 15,
                            backgroundColor:
                                onboardNotifier(renderUI: true)
                                            .authType ==
                                        "login"
                                    ? Colors.deepPurpleAccent
                                    : KConstantColors.inverseConditionalColor(
                                        context: context),
                            title: "Login"),
                        AwesomeButton.roundedIconButton(
                            titleTextstyle: KCustomTextStyle.kMedium(
                                context,
                                10,
                                KConstantColors.conditionalColor(
                                    context: context)),
                            onTap: () {
                              onboardNotifier(renderUI: false)
                                  .setAuthType(kValue: "signup");
                            },
                            width: 200,
                            radius: 15,
                            backgroundColor:
                                onboardNotifier(renderUI: true)
                                            .authType ==
                                        "signup"
                                    ? Colors.deepPurpleAccent
                                    : KConstantColors.inverseConditionalColor(
                                        context: context),
                            title: "Signup"),
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: KConstantColors.inverseConditionalColor(
                            context: context),
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  AwesomeDimensions.vSizedBox3,
                ],
              ),
              backgroundColor:
                  KConstantColors.conditionalColor(context: context)));
    }));
  }
}
