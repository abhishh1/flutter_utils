import 'package:flutter/material.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class DropDownSearchNotifier extends ChangeNotifier {
  bool isExpanded = false;
  void toggleExpansion() {
    isExpanded = !isExpanded;
    notifyListeners();
  }

  List<String> queriedItems = [];
  List<String> defaultOptions = ["Apple", "Cat", "Dog", "Puppy", "Coffee"];

  String? query;
  void setQuery({required String value}) {
    query = value;
    notifyListeners();
    debugPrint(query);
  }

  clearSearch() {
    query = null;
    queriedItems.clear();
    notifyListeners();
  }

  void queryData() {
    queriedItems.clear();

    for (String item in defaultOptions) {
      if (query != null) {
        if (!queriedItems.contains(item)) {
          if (item.toLowerCase().contains(query!.toLowerCase())) {
            queriedItems.add(item);
            notifyListeners();
          }
        }
      }
    }
  }

  String? selectedOption;

  void setOption({required String value}) {
    selectedOption = value;
    isExpanded = false;
    queriedItems.clear();
    query = null;
    notifyListeners();
  }
}

class FlutteCustomDropdownSearchWidget extends StatefulWidget {
  const FlutteCustomDropdownSearchWidget({super.key});

  @override
  State<FlutteCustomDropdownSearchWidget> createState() =>
      _FlutteCustomDropdownSearchWidgetState();
}

class _FlutteCustomDropdownSearchWidgetState
    extends State<FlutteCustomDropdownSearchWidget> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DropDownSearchNotifier dropDownSearchNotifier({required bool renderUI}) =>
        Provider.of<DropDownSearchNotifier>(context, listen: renderUI);

    bool isExpanded = dropDownSearchNotifier(renderUI: true).isExpanded;
    String? selectedOption =
        dropDownSearchNotifier(renderUI: true).selectedOption;

    bool isQueryAdded = dropDownSearchNotifier(renderUI: true).query != null;

    List<String> items = isQueryAdded
        ? dropDownSearchNotifier(renderUI: true).queriedItems
        : dropDownSearchNotifier(renderUI: true).defaultOptions;

    expandedMenu() {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: KConstantTextstyles.light(fontSize: 12),
              onChanged: (val) {
                if (val != "") {
                  dropDownSearchNotifier(renderUI: false).setQuery(value: val);
                  dropDownSearchNotifier(renderUI: false).queryData();
                } else {
                  dropDownSearchNotifier(renderUI: false).clearSearch();
                }
              },
              decoration: InputDecoration(
                  hintStyle: KConstantTextstyles.light(fontSize: 12),
                  hintText: "Search anything"),
              controller: textEditingController,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onTap: () {
                  dropDownSearchNotifier(renderUI: false)
                      .setOption(value: items[index]);
                },
                title: Text(items[index],
                    style: KConstantTextstyles.light(fontSize: 12)),
              );
            },
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: KConstantColors.bgColor,
      appBar: CustomAppBar(title: "Flutter Custom Dropdown search"),
      body: Center(
        child: Align(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              width: 400,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 10),
                        Text(selectedOption ?? "Select option",
                            style: isExpanded
                                ? KConstantTextstyles.bold(fontSize: 14)
                                : KConstantTextstyles.light(fontSize: 12)),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              dropDownSearchNotifier(renderUI: false)
                                  .toggleExpansion();
                            },
                            icon: Icon(
                                isExpanded
                                    ? Icons.arrow_drop_up_outlined
                                    : Icons.arrow_drop_down_outlined,
                                color: KConstantColors.whiteColor))
                      ],
                    ),
                    if (isExpanded) expandedMenu()
                  ],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: KConstantColors.bgColorFaint,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
