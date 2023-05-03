import 'dart:math';
import 'package:flutter/material.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class RandomIdNotifier extends ChangeNotifier {
  String? genSerialNumber;

  void generateRandomID() {
    Random random = Random();
    genSerialNumber = String.fromCharCodes(
        List.generate(8, (index) => random.nextInt(33) + 89));
    notifyListeners();
  }

  shareSerialNumber() async {
    if (genSerialNumber != null) {
      await Share.share(genSerialNumber!);
    }
  }
}

class ShareRandomIDView extends StatefulWidget {
  const ShareRandomIDView({super.key});

  @override
  State<ShareRandomIDView> createState() => _ShareRandomIDViewState();
}

class _ShareRandomIDViewState extends State<ShareRandomIDView> {
  RandomIdNotifier randomIdNotifier({required bool renderUI}) =>
      Provider.of<RandomIdNotifier>(context, listen: renderUI);

  @override
  Widget build(BuildContext context) {
    String? randomString = randomIdNotifier(renderUI: true).genSerialNumber;

    return Scaffold(
      backgroundColor: KConstantColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Serial number",
                style: KConstantTextstyles.bold(fontSize: 42)),
            Text("Press share icon to share the random serial number",
                style: KConstantTextstyles.light(fontSize: 12)),
            SizedBox(height: 40),
            if (randomString != null)
              Text(randomString, style: KConstantTextstyles.bold(fontSize: 30)),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                if (randomString == null) {
                  randomIdNotifier(renderUI: false).generateRandomID();
                } else {
                  randomIdNotifier(renderUI: false).shareSerialNumber();
                }
              },
              child: Container(
                  width: 100,
                  height: 50,
                  child: Center(
                      child: Text(randomString != null ? "Share" : "Generate",
                          style: KConstantTextstyles.light(fontSize: 12))),
                  decoration: BoxDecoration(
                      color: KConstantColors.blueColor,
                      borderRadius: BorderRadius.circular(12))),
            )
          ],
        ),
      ),
    );
  }
}
