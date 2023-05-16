import 'package:flutter/material.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';


class DoubleSliderNotifier extends ChangeNotifier {
  RangeValues rangeValues = RangeValues(0, 1);

  void setSliderValue({required RangeValues value}) {
    rangeValues = value;
    notifyListeners();
    debugPrint(rangeValues.toString());
  }

  String renderEmoji() {
    if (rangeValues.start >= 0 && rangeValues.end <= 0.2) {
      return "🔥";
    } else if (rangeValues.start >= 0.2 && rangeValues.end <= 0.4) {
      return "👀";
    } else if (rangeValues.start >= 0.4 && rangeValues.end <= 0.6) {
      return "👋🏻";
    } else if (rangeValues.start >= 0.6 && rangeValues.end <= 0.8) {
      return "✅";
    } else if (rangeValues.start >= 0.8 && rangeValues.end <= 1) {
      return "🍕";
    }
    return "🔗";
  }
}

class FlutterDoubleSliderView extends StatelessWidget {
  const FlutterDoubleSliderView({super.key});

  @override
  Widget build(BuildContext context) {
    DoubleSliderNotifier doubleSliderNotifier({required bool renderUI}) =>
        Provider.of<DoubleSliderNotifier>(context, listen: renderUI);

    return Scaffold(
      backgroundColor: KConstantColors.bgColor,
      appBar: CustomAppBar(title: "Double slider"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Rate your experience in a partition",
              style: KConstantTextstyles.light(fontSize: 16)),
          SizedBox(height: 25),
          RangeSlider(
              activeColor: KConstantColors.whiteColor,
              divisions: 5,
              values: doubleSliderNotifier(renderUI: true).rangeValues,
              onChanged: (val) {
                doubleSliderNotifier(renderUI: false)
                    .setSliderValue(value: val);
              }),
          SizedBox(height: 30),
          Text(doubleSliderNotifier(renderUI: true).renderEmoji(),
              style: KConstantTextstyles.bold(fontSize: 75))
        ],
      ),
    );
  }
}
