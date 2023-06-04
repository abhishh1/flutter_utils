import 'package:flutter/material.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class SpiderManNotifier extends ChangeNotifier {
  double spidySense = 0;

  void setSpidySense({required double value}) {
    spidySense = value;
    notifyListeners();
    debugPrint(spidySense.toString());
  }
}

class FlutterSpidermanSliderView extends StatelessWidget {
  const FlutterSpidermanSliderView({super.key});

  @override
  Widget build(BuildContext context) {
    SpiderManNotifier spiderManNotifier({required bool renderUI}) =>
        Provider.of<SpiderManNotifier>(context, listen: renderUI);

    String renderSpiderman() {
      double value = spiderManNotifier(renderUI: true).spidySense;

      if (value == 0) {
        return "assets/spider.png";
      } else if (value == 2.5) {
        return "assets/gwen.png";
      } else if (value == 5) {
        return "assets/spiderman.png";
      } else if (value == 7.5) {
        return "assets/peter.png";
      } else {
        return "assets/miguel.png";
      }
    }

    return Scaffold(
      backgroundColor: KConstantColors.bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Set spidy sense level",
              style: KConstantTextstyles.bold(fontSize: 26)),
          Text("Start the game with your favorite character",
              style: KConstantTextstyles.light(
                  fontSize: 14, color: KConstantColors.textColor)),
          SizedBox(height: 15),
          Slider(
              activeColor: KConstantColors.redColor,
              min: 0,
              max: 10,
              divisions: 4,
              value: spiderManNotifier(renderUI: true).spidySense,
              onChanged: (val) {
                spiderManNotifier(renderUI: false).setSpidySense(value: val);
              }),
          SizedBox(height: 20),
          SizedBox(
            child: Image.asset(renderSpiderman()),
            height: 200,
            width: 500,
          ),
          SizedBox(height: 40),
          Container(
            height: 70,
            width: 200,
            child: Center(
                child: Text(
                    spiderManNotifier(renderUI: true).spidySense == 0
                        ? "Select level"
                        : "Start game",
                    style: KConstantTextstyles.light(fontSize: 12))),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: spiderManNotifier(renderUI: true).spidySense == 0
                    ? KConstantColors.bgColorFaint
                    : KConstantColors.redColor),
          )
        ],
      ),
    );
  }
}
