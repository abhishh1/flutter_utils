import 'package:flutter/material.dart';
import 'package:ig_posts/features/1.flutter_frost_glass.view.dart';
import 'package:provider/provider.dart';

class FakeData {
  final String title;
  final String category;

  const FakeData({required this.title, required this.category});
}

class FilterDataNotifier extends ChangeNotifier {
  List<String> categories = ["animal", "bird", "fish"];

  List<FakeData> data = const [
    FakeData(title: "Lion", category: "animal"),
    FakeData(title: "Elephant", category: "animal"),
    FakeData(title: "Dolphin", category: "fish"),
    FakeData(title: "Tiger", category: "animal"),
    FakeData(title: "Eagle", category: "bird"),
    FakeData(title: "Gold fish", category: "fish"),
    FakeData(title: "Rabbit", category: "animal"),
    FakeData(title: "Vulture", category: "bird"),
    FakeData(title: "Swallow", category: "bird"),
    FakeData(title: "Whale", category: "fish"),
    FakeData(title: "Shark", category: "fish"),
    FakeData(title: "Cat", category: "animal"),
    FakeData(title: "Duck", category: "bird"),
    FakeData(title: "Swallow", category: "bird"),
    FakeData(title: "Pigeon", category: "bird"),
  ];

  List<FakeData> queriedData = [];

  bool isFilterMode = false;

  String? _query;
  String? get query => _query;

  setQuery({required String kValue}) {
    isFilterMode = true;
    _query = kValue;
    debugPrint(_query);
    notifyListeners();
  }

  disableFilter() {
    isFilterMode = false;
    _query = null;
    notifyListeners();
  }

  queryData() {
    queriedData.clear();
    for (FakeData kData in data) {
      if (!queriedData.contains(kData)) {
        if (_query != null) {
          if (kData.category.contains(_query!)) {
            queriedData.add(kData);
            notifyListeners();
          }
        }
      }
    }
  }
}

class FlutterFilterDataView extends StatelessWidget {
  const FlutterFilterDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FilterDataNotifier filterDataNotifier({required bool renderUI}) =>
        Provider.of<FilterDataNotifier>(context, listen: renderUI);

    List<FakeData> data = filterDataNotifier(renderUI: true).isFilterMode
        ? filterDataNotifier(renderUI: true).queriedData
        : filterDataNotifier(renderUI: true).data;

    List<String> categories = filterDataNotifier(renderUI: false).categories;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
          backgroundColor: bgColorFaint,
          title: const Text("Flutter Filter mode")),
      floatingActionButton: filterDataNotifier(renderUI: true).isFilterMode
          ? FloatingActionButton(
              backgroundColor: Colors.blue,
              child: const Icon(Icons.clear),
              onPressed: () {
                filterDataNotifier(renderUI: false).disableFilter();
              })
          : const SizedBox.shrink(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              width: 400,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ActionChip(
                        backgroundColor:
                            filterDataNotifier(renderUI: true).query ==
                                    categories[index]
                                ? Colors.blue
                                : bgColorFaint,
                        label: Text(categories[index]),
                        onPressed: () {
                          filterDataNotifier(renderUI: false)
                              .setQuery(kValue: categories[index]);
                          filterDataNotifier(renderUI: false).queryData();
                        }),
                  );
                },
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                FakeData fakeData = data[index];
                return ListTile(
                  leading: const Icon(Icons.animation),
                  title: Text(fakeData.title),
                  subtitle: Text(fakeData.category),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
