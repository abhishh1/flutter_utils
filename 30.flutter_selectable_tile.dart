import 'package:flutter/material.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class SelectableTileNotifier extends ChangeNotifier {
  List<String> _selectedTilesId = [];
  List<String> get selectedTilesId => _selectedTilesId;

  void selectTiles({required String tileId}) {
    if (_selectedTilesId.contains(tileId)) {
      _selectedTilesId.remove(tileId);
      notifyListeners();
    } else {
      _selectedTilesId.add(tileId);
      notifyListeners();
    }
  }

  void clearAllTiles() {
    selectedTilesId.clear();
    notifyListeners();
  }

  void selectAllTiles({required List<String> ids}) {
    selectedTilesId.clear();
    selectedTilesId.addAll(ids);
    notifyListeners();
  }
}

class FlutterSelectableTilesView extends StatelessWidget {
  const FlutterSelectableTilesView({super.key});

  @override
  Widget build(BuildContext context) {
    SelectableTileNotifier selectableTileNotifier({required bool renderUI}) =>
        Provider.of<SelectableTileNotifier>(context, listen: renderUI);

    List<Map> data = [
      {"title": "Cricket", "iconData": Icons.star},
      {"title": "Football", "iconData": Icons.star},
      {"title": "Tennis", "iconData": Icons.star},
      {"title": "Swimming", "iconData": Icons.star},
      {"title": "Karate", "iconData": Icons.star},
      {"title": "Boxing", "iconData": Icons.star},
      {"title": "Chess", "iconData": Icons.star},
      {"title": "Badminton", "iconData": Icons.star},
    ];

    tileBlock({required IconData iconData, required String title}) {
      bool isSelected = selectableTileNotifier(renderUI: true)
          .selectedTilesId
          .contains(title);

      return GestureDetector(
        onTap: () {
          selectableTileNotifier(renderUI: false).selectTiles(tileId: title);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Icon(iconData, color: KConstantColors.whiteColor),
                  backgroundColor: KConstantColors.bgColor,
                ),
                SizedBox(height: 5),
                Text(title, style: KConstantTextstyles.light(fontSize: 10)),
              ],
            ),
            decoration: BoxDecoration(
                color: isSelected
                    ? KConstantColors.blueColor
                    : KConstantColors.bgColorFaint,
                borderRadius: BorderRadius.circular(25)),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: KConstantColors.blueColor,
          title: Text("Flutter Selectable Tiles",
              style: KConstantTextstyles.bold(fontSize: 15))),
      backgroundColor: KConstantColors.bgColor,
      body: Container(
        child: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GridView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (context, index) {
                      return tileBlock(
                        iconData: data[index]['iconData'],
                        title: data[index]['title'],
                      );
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (selectableTileNotifier(renderUI: true)
                        .selectedTilesId
                        .isNotEmpty)
                      ActionChip(
                          backgroundColor: KConstantColors.redColor,
                          label: Text("Clear all",
                              style: KConstantTextstyles.light(fontSize: 12)),
                          onPressed: () {
                            selectableTileNotifier(renderUI: false)
                                .clearAllTiles();
                          }),
                    SizedBox(width: 20),
                    ActionChip(
                        backgroundColor: KConstantColors.blueColor,
                        label: Text("Select all",
                            style: KConstantTextstyles.light(fontSize: 12)),
                        onPressed: () {
                          List<String> d = [];
                          data.forEach((element) {
                            d.add(element['title']);
                          });

                          selectableTileNotifier(renderUI: false)
                              .selectAllTiles(ids: d);
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (selectableTileNotifier(renderUI: true)
                        .selectedTilesId
                        .isNotEmpty)
                      ActionChip(
                          backgroundColor: KConstantColors.bgColorFaint,
                          label: Text("Continue",
                              style: KConstantTextstyles.light(fontSize: 12)),
                          onPressed: () {}),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
