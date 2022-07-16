import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*

@SUBSCRIBE - [https://www.youtube.com/channel/UCIxJGxcB4pSrIvuv8FyuqUA]

*/

class FlutterBlueEffectNotifier extends ChangeNotifier {
  double _blurValue = 0;
  double get blurValue => _blurValue;

  setBlueValue({required double val}) {
    _blurValue = val;
    notifyListeners();
  }
}

class FlutterBlurEffectView extends StatelessWidget {
  const FlutterBlurEffectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterBlueEffectNotifier flutterBlueEffectNotifier(
            {required bool renderUI}) =>
        Provider.of<FlutterBlueEffectNotifier>(context, listen: renderUI);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("Flutter Blur Effect")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 500,
            child: Stack(
              fit: StackFit.expand,
              children: [
                SizedBox(
                    height: 500,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset("assets/car.jpeg"))),
                SizedBox(
                  height: 500,
                  child: BackdropFilter(
                      child: const SizedBox.shrink(),
                      filter: ImageFilter.blur(
                          sigmaX: flutterBlueEffectNotifier(renderUI: false)
                              .blurValue,
                          sigmaY: flutterBlueEffectNotifier(renderUI: false)
                              .blurValue)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Slider(
              min: 0,
              max: 10,
              value: flutterBlueEffectNotifier(renderUI: true).blurValue,
              onChanged: (val) {
                flutterBlueEffectNotifier(renderUI: false)
                    .setBlueValue(val: val);
              }),
        ],
      ),
    );
  }
}
