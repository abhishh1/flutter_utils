import 'package:flutter/material.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class Item {
  final int itemId;
  final String itemTitle;

  const Item({
    required this.itemId,
    required this.itemTitle,
  });
}

class CustomSearchNotifier extends ChangeNotifier {
  final List<Item> items = [
    Item(itemId: 0, itemTitle: "Apple"),
    Item(itemId: 1, itemTitle: "Banana"),
    Item(itemId: 2, itemTitle: "Pineapple"),
    Item(itemId: 3, itemTitle: "Zebra"),
  ];

  final List<Item> queriedItems = [];

  String? query;

  void setQuery({required String value}) {
    query = value;
    notifyListeners();
  }

  void queryData() {
    queriedItems.clear();

    for (Item item in items) {
      if (query != null) {
        if (!queriedItems.contains(item)) {
          if (item.itemTitle.toLowerCase().contains(query!.toLowerCase())) {
            queriedItems.add(item);
            notifyListeners();
          }
        }
      }
    }
  }

  void clearSearch() {
    queriedItems.clear();
    query = null;
    notifyListeners();
  }
}

class CustomFlutterSearchView extends StatefulWidget {
  const CustomFlutterSearchView({super.key});

  @override
  State<CustomFlutterSearchView> createState() =>
      _CustomFlutterSearchViewState();
}

class _CustomFlutterSearchViewState extends State<CustomFlutterSearchView> {
  CustomSearchNotifier customSearchNotifier({required bool renderUI}) =>
      Provider.of<CustomSearchNotifier>(context, listen: renderUI);

  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isQueryNull = customSearchNotifier(renderUI: true).query == null;

    List<Item> items = isQueryNull
        ? customSearchNotifier(renderUI: true).items
        : customSearchNotifier(renderUI: true).queriedItems;

    return Scaffold(
        backgroundColor: KConstantColors.bgColor,
        appBar: CustomAppBar(title: "Flutter Search"),
        body: Column(
          children: [
            SizedBox(height: 20),
            TextField(
              onChanged: (val) {
                if (val != "") {
                  customSearchNotifier(renderUI: false).setQuery(value: val);
                  customSearchNotifier(renderUI: false).queryData();
                } else {
                  customSearchNotifier(renderUI: false).clearSearch();
                }
              },
              style: KConstantTextstyles.light(fontSize: 12),
              controller: textEditingController,
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: KConstantColors.whiteColor),
                  hintText: "Search anything..."),
            ),
            SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                Item item = items[index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: KConstantColors.bgColorFaint,
                    child: Center(
                      child: Text(item.itemId.toString(),
                          style: KConstantTextstyles.light(fontSize: 12)),
                    ),
                  ),
                  title: Text(item.itemTitle,
                      style: KConstantTextstyles.light(fontSize: 12)),
                );
              },
            ),
          ],
        ));
  }
}
