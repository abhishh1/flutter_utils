import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:ig_posts/features/1.flutter_frost_glass.view.dart';
import 'package:ig_posts/features/5.flutter_swiggy_button.dart';

class FlutteHeroAnimationWidget extends StatelessWidget {
  const FlutteHeroAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> fakeData = [
      "🍔 Burger",
      "🍟 Fries",
      "🍗 Chicken",
      "🍅 Ketchup",
      "🍗 Meat",
      "💧 Water",
      "🍕 Pizza",
      "🍜 Noodles",
      "🍨 Ice cream",
      "🍊 Orange",
      "🌭 Sausage",
      "🍱 Meal"
    ];

    return Scaffold(
      appBar: AppBar(
          backgroundColor: bgColorFaint,
          title:
              Text("Flutter Animated Navigation", style: boldText(fSize: 20))),
      backgroundColor: bgColor,
      body: GridView.builder(
        shrinkWrap: true,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: fakeData.length,
        itemBuilder: (BuildContext context, int index) {
          return OpenContainer(
              openColor: bgColor,
              closedBuilder: (_, openContainer) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Center(
                        child:
                            Text(fakeData[index], style: boldText(fSize: 28))),
                    decoration: BoxDecoration(
                        color: bgColorFaint,
                        borderRadius: BorderRadius.circular(12)),
                  ),
                );
              },
              closedColor: bgColor,
              closedElevation: 5.0,
              openBuilder: (_, closeContainer) {
                return OpenedUpPage(callbackData: fakeData[index]);
              });
        },
      ),
    );
  }
}

class OpenedUpPage extends StatelessWidget {
  final String callbackData;
  const OpenedUpPage({required this.callbackData, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
          backgroundColor: bgColorFaint,
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      backgroundColor: bgColor,
      body: Center(
        child: Text(callbackData, style: boldText(fSize: 30)),
      ),
    );
  }
}
