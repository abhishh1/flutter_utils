import 'package:flutter/material.dart';
import 'package:ig_posts/features/1.flutter_frost_glass.view.dart';
import 'package:ig_posts/features/5.flutter_swiggy_button.dart';
import 'package:provider/provider.dart';

class BottomSheetNotifier extends ChangeNotifier {
  List<String> tags = [
    "Lion",
    "Tiger",
    "Elephant",
    "Cheetah",
    "Fish",
    "Dolphin",
    "Rabbit",
    "Dog",
    "Swan",
    "Cat",
    "Donkey",
    "Frog"
  ];
  List<String> queriedData = [];

  addToList({required String kValue}) {
    if (queriedData.contains(kValue)) {
      queriedData.remove(kValue);
      notifyListeners();
    } else {
      queriedData.add(kValue);
      notifyListeners();
    }
  }
}

class FlutterBottomSheetView extends StatelessWidget {
  const FlutterBottomSheetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BottomSheetNotifier bottomSheetNotifier({required bool renderUI}) =>
        Provider.of<BottomSheetNotifier>(context, listen: renderUI);

    List<String> data = bottomSheetNotifier(renderUI: true).queriedData;

    _showTags() {
      return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 2, crossAxisCount: 4),
        itemCount: bottomSheetNotifier(renderUI: false).tags.length,
        itemBuilder: (BuildContext context, int index) {
          BottomSheetNotifier bottomSheetNotifier({required bool renderUI}) =>
              Provider.of<BottomSheetNotifier>(context, listen: renderUI);
          return ActionChip(
              backgroundColor: bottomSheetNotifier(renderUI: true)
                      .queriedData
                      .contains(
                          bottomSheetNotifier(renderUI: false).tags[index])
                  ? Colors.blue
                  : bgColor,
              label: Text(bottomSheetNotifier(renderUI: false).tags[index],
                  style: regulerText),
              onPressed: () {
                bottomSheetNotifier(renderUI: false).addToList(
                    kValue: bottomSheetNotifier(renderUI: false).tags[index]);
              });
        },
      );
    }

    _showBottomSheet() {
      return showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: bgColorFaint,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          context: context,
          builder: (context) {
            return SizedBox(
              height: 800,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Select tags", style: boldText(fSize: 50)),
                  Text("You can select more than 5 tags for the app",
                      style: regulerText),
                  const SizedBox(height: 50),
                  _showTags(),
                  const SizedBox(height: 10),
                  ActionChip(
                      backgroundColor: Colors.blue,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      label: Text("Dismiss", style: regulerText)),
                  const SizedBox(height: 80),
                  Text("Follow @abhishvek for more! 🚀",
                      style: boldText(fSize: 16)),
                ],
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: bgColorFaint,
          title: Text("Flutter bottom sheet 🔥", style: boldText(fSize: 20))),
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (bottomSheetNotifier(renderUI: true).queriedData.isNotEmpty)
              Text("Selected Tags", style: boldText(fSize: 30)),
            const SizedBox(height: 10),
            if (bottomSheetNotifier(renderUI: true).queriedData.isNotEmpty)
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 2, crossAxisCount: 4),
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Chip(
                      backgroundColor: bgColorFaint, label: Text(data[index]));
                },
              ),
            ActionChip(
                backgroundColor: Colors.blue,
                onPressed: () {
                  _showBottomSheet();
                },
                label: Text("Select tags", style: regulerText)),
          ],
        ),
      ),
    );
  }
}
