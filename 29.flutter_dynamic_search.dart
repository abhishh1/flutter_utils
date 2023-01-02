import 'package:flutter/material.dart';
import 'package:ig_posts/features/1.flutter_frost_glass.view.dart';
import 'package:ig_posts/features/5.flutter_swiggy_button.dart';
import 'package:provider/provider.dart';

class DynamicSearchNotifier extends ChangeNotifier {
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

  List<String> queriedData = [];

  String _query = "";
  String get query => _query;

  void setQuery({required String kValue}) {
    _query = kValue;
    notifyListeners();
  }

  void queryData() {
    queriedData.clear();
    for (String data in fakeData) {
      if (data.contains(query)) {
        queriedData.add(data);
        notifyListeners();
      }
    }
  }

  void clearSearch() {
    queriedData.clear();
    notifyListeners();
  }
}

class FlutterDyanmicSearchWidget extends StatelessWidget {
  const FlutterDyanmicSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    DynamicSearchNotifier dynamicSearchNotifier({required bool renderUI}) =>
        Provider.of<DynamicSearchNotifier>(context, listen: renderUI);

    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              SizedBox(
                width: 400,
                child: TextField(
                  style: regulerText,
                  onChanged: (val) {
                    if (val == "") {
                      dynamicSearchNotifier(renderUI: false).clearSearch();
                    } else {
                      dynamicSearchNotifier(renderUI: false)
                          .setQuery(kValue: val);
                      dynamicSearchNotifier(renderUI: false).queryData();
                    }
                  },
                  decoration: InputDecoration(
                      hintStyle: regulerText, hintText: "Enter any food item"),
                ),
              ),
              // if (dynamicSearchNotifier(renderUI: true).queriedData.isEmpty)
              //   Center(
              //       child: Padding(
              //     padding: const EdgeInsets.only(top: 200),
              //     child: Text("No data found", style: boldText()),
              //   )),
              // if (dynamicSearchNotifier(renderUI: true).queriedData.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount:
                    dynamicSearchNotifier(renderUI: true).queriedData.length,
                itemBuilder: (BuildContext context, int index) {
                  String data =
                      dynamicSearchNotifier(renderUI: true).queriedData[index];

                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListTile(
                      tileColor: bgColorFaint,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      title: Text(data, style: regulerText),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
          backgroundColor: bgColorFaint,
          title: Text(
            "Flutter static search",
            style: boldText(),
          )),
    );
  }
}
