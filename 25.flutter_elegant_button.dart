import 'package:flutter/material.dart';
import 'package:ig_posts/features/1.flutter_frost_glass.view.dart';
import 'package:ig_posts/features/5.flutter_swiggy_button.dart';
import 'package:provider/provider.dart';

class SpotifyButtonNotifier extends ChangeNotifier {
  int? buttonIndex;

  void setButtonIndex({required int newIndex}) {
    buttonIndex = newIndex;
    notifyListeners();
  }

  void setNullIndex() {
    buttonIndex = null;
    notifyListeners();
  }
}

class FlutterSpotifyButtonWidget extends StatelessWidget {
  const FlutterSpotifyButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SpotifyButtonNotifier spotifyButtonNotifie({required bool renderUI}) =>
        Provider.of<SpotifyButtonNotifier>(context, listen: renderUI);

    bool isIndexSelected =
        spotifyButtonNotifie(renderUI: true).buttonIndex != null;

    int? selectedIndex = spotifyButtonNotifie(renderUI: true).buttonIndex;

    Widget directChip({required int kIndex, required String title}) {
      return ActionChip(
        onPressed: () {
          spotifyButtonNotifie(renderUI: false)
              .setButtonIndex(newIndex: kIndex);
        },
        backgroundColor: selectedIndex == kIndex ? Colors.green : bgColorFaint,
        label: Row(
          children: [Text(title, style: regulerText)],
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
          backgroundColor: bgColorFaint,
          title: Text("Flutter Elegant Action Chips", style: boldText())),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (isIndexSelected)
                GestureDetector(
                  onTap: () {
                    spotifyButtonNotifie(renderUI: false).setNullIndex();
                  },
                  child: const CircleAvatar(
                    backgroundColor: bgColorFaint,
                    child: Icon(Icons.backspace_outlined, color: Colors.white),
                  ),
                ),
              directChip(title: "Music", kIndex: 0),
              directChip(title: "Podcasts", kIndex: 1),
              directChip(title: "Videos", kIndex: 2),
              directChip(title: "Others", kIndex: 3),
            ],
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
