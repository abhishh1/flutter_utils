import 'package:flutter/material.dart';
import 'package:ig_posts/features/1.flutter_frost_glass.view.dart';
import 'package:provider/provider.dart';

class DropDownNotifier extends ChangeNotifier {
  String? selectedItem;

  void setSelectedItem({required String value}) {
    selectedItem = value;
    notifyListeners();
    debugPrint(selectedItem);
  }

  void clearMenu() {
    selectedItem = null;
    notifyListeners();
  }
}

class FlutterDropDownView extends StatelessWidget {
  const FlutterDropDownView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DropDownNotifier downNotifier({required bool renderUI}) =>
        Provider.of<DropDownNotifier>(context, listen: renderUI);

    List<String> items = [
      "India 🇮🇳",
      "Chile 🇨🇱",
      "France 🇫🇷",
      "Argetina 🇦🇷",
      "Indonesia 🇮🇩"
    ];

    String? kSelectedData = downNotifier(renderUI: true).selectedItem;
    String? parsedString = kSelectedData?.substring(kSelectedData.length - 5);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: bgColorFaint,
          title: const Text("Clean Dropdown Menu 🚀")),
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (parsedString != null)
              Text(parsedString,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 100)),
            if (kSelectedData != null)
              Text(
                  "The selected country is ${downNotifier(renderUI: true).selectedItem}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 20),
            DropdownButton<String>(
              menuMaxHeight: 200,
              icon: const Icon(Icons.arrow_forward_ios, size: 12),
              dropdownColor: bgColorFaint,
              hint: const Text("Select your country",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              borderRadius: BorderRadius.circular(25),
              value: downNotifier(renderUI: true).selectedItem,
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ));
              }).toList(),
              onChanged: (kValue) {
                if (kValue != null) {
                  downNotifier(renderUI: false).setSelectedItem(value: kValue);
                }
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (kSelectedData != null)
                  ActionChip(
                      backgroundColor: Colors.red,
                      label: const Text("Clear",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        downNotifier(renderUI: false).clearMenu();
                      }),
                const SizedBox(width: 20),
                if (kSelectedData != null)
                  ActionChip(
                      backgroundColor: Colors.blue,
                      label: const Text("Continue",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      onPressed: () {
                        downNotifier(renderUI: false).clearMenu();
                      })
              ],
            )
          ],
        ),
      ),
    );
  }
}
