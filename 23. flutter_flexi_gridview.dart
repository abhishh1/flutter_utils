import 'package:flutter/material.dart';
import 'package:ig_posts/features/0.abhishvek_header.dart';
import 'package:ig_posts/features/1.flutter_frost_glass.view.dart';
import 'package:ig_posts/features/5.flutter_swiggy_button.dart';
import 'package:provider/provider.dart';

class FlexiGridNotifier extends ChangeNotifier {
  double gridCount = 1;
  void setGridCount({required double kCount}) {
    gridCount = kCount;
    notifyListeners();
  }
}

class FlutterFlexibleGridView extends StatelessWidget {
  const FlutterFlexibleGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlexiGridNotifier flexiGridNotifier({required bool renderUI}) =>
        Provider.of<FlexiGridNotifier>(context, listen: renderUI);

    double gridCount = flexiGridNotifier(renderUI: true).gridCount;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: bgColorFaint,
          title: Text("Flutter Flexi GridView", style: boldText())),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Slider(
                activeColor: Colors.green,
                inactiveColor: Colors.greenAccent,
                min: 1,
                max: 5,
                value: gridCount,
                onChanged: ((value) {
                  flexiGridNotifier(renderUI: false)
                      .setGridCount(kCount: value);
                })),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridCount.toInt()),
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: bgColorFaint,
                          image: const DecorationImage(
                              image: AssetImage("assets/sasuke.jpeg")),
                          borderRadius: BorderRadius.circular(25))),
                );
              },
            ),
            const AbhishvekHeaderWidget()
          ],
        ),
      ),
    );
  }
}
