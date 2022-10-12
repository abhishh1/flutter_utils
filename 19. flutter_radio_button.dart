import 'package:flutter/material.dart';
import 'package:ig_posts/features/1.flutter_frost_glass.view.dart';
import 'package:ig_posts/features/5.flutter_swiggy_button.dart';
import 'package:provider/provider.dart';

class ButtonNotifier extends ChangeNotifier {
  String? radioValue;
  void setRadioValue({required String kValue}) {
    radioValue = kValue;
    notifyListeners();
  }
}

class FlutterClassicButtons extends StatelessWidget {
  const FlutterClassicButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ButtonNotifier buttonNotifier({required bool renderUI}) =>
        Provider.of<ButtonNotifier>(context, listen: renderUI);

    List values = [
      "India 🇮🇳",
      "Germany 🇩🇪",
      "China 🇨🇳",
      "England 🏴󠁧󠁢󠁥󠁮󠁧󠁿",
      "Poland 󠁧󠁢󠁥󠁮󠁧🇵🇱",
      "Japan 🇯🇵",
      "Romania 🇷🇴",
      "Argentina 🇦🇷",
    ];

    radioButtons() {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          return RadioListTile<String>(
              title: Text(values[index], style: regulerText),
              value: values[index],
              groupValue: buttonNotifier(renderUI: true).radioValue,
              onChanged: (value) {
                buttonNotifier(renderUI: false)
                    .setRadioValue(kValue: values[index]);
              });
        },
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
          backgroundColor: bgColorFaint,
          title: Text("Flutter Radio Buttons ⭕️", style: boldText())),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(25)),
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(buttonNotifier(renderUI: true).radioValue ?? "",
                      style: boldText()))),
          const SizedBox(height: 20),
          radioButtons(),
        ],
      ),
    );
  }
}
