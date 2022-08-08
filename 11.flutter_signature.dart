import 'package:finance_logs/app/shared/colors.dart';
import 'package:finance_logs/app/shared/dimensions.dart';
import 'package:finance_logs/app/shared/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';

// ADD https://pub.dev/packages/signature in pubspec.yaml

class FlutterSignatureNotifier extends ChangeNotifier {
  double penWidth = 5;

  setPenWidth({required double kValue}) {
    penWidth = kValue;
    notifyListeners();
  }

  SignatureController controller({required double width}) =>
      SignatureController(
          penStrokeWidth: width,
          penColor: Colors.white,
          exportPenColor: KConstantColors.bgColor,
          exportBackgroundColor: Colors.white);
}

class FlutterSignatureUsageView extends StatelessWidget {
  const FlutterSignatureUsageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterSignatureNotifier flutterSignatureNotifier(
            {required bool renderUI}) =>
        Provider.of<FlutterSignatureNotifier>(context, listen: renderUI);

    Widget getCanvas() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Signature(
            controller: flutterSignatureNotifier(renderUI: false).controller(
                width: flutterSignatureNotifier(renderUI: true).penWidth),
            width: 500,
            height: 400,
            backgroundColor: KConstantColors.bgColorFaint,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: KConstantColors.bgColorFaint,
          title: const Text("Flutter signature pad")),
      backgroundColor: KConstantColors.bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Add signature", style: KCustomTextStyle.kBold(context, 30)),
          vSizedBox2,
          getCanvas(),
          Slider(
              min: 1,
              max: 10,
              value: flutterSignatureNotifier(renderUI: true).penWidth,
              onChanged: (val) {
                flutterSignatureNotifier(renderUI: false)
                    .setPenWidth(kValue: val);
              }),
          vSizedBox2,
          ActionChip(
              backgroundColor: KConstantColors.blueColor,
              label: Text("Continue",
                  style: KCustomTextStyle.kMedium(context, 10)),
              onPressed: () {
                if (flutterSignatureNotifier(renderUI: false)
                    .controller(
                        width:
                            flutterSignatureNotifier(renderUI: true).penWidth)
                    .isEmpty) {
                  // DO SOMETHING
                }
              })
        ],
      ),
    );
  }
}
