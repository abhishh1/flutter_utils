import 'package:flutter/material.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class PalleteData {
  final palleteId;
  final String colorTitle;
  final String colorDescription;
  final Color color;
  final hexValue;

  const PalleteData(
      {required this.palleteId,
      required this.colorTitle,
      required this.colorDescription,
      required this.color,
      required this.hexValue});
}

class ColorPalleteNotifier extends ChangeNotifier {
  PalleteData? selectedPalleteData = PalleteData(
      palleteId: 0,
      colorTitle: "Blue",
      colorDescription: "Demo description",
      color: Colors.blue,
      hexValue: "fb8500");

  void setPalleteData({required PalleteData palleteData}) {
    selectedPalleteData = palleteData;
    notifyListeners();
    debugPrint(selectedPalleteData?.colorTitle.toString());
  }
}

class CustomColorPalletePickerView extends StatelessWidget {
  const CustomColorPalletePickerView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorPalleteNotifier colorPalleteNotifier({required bool renderUI}) =>
        Provider.of<ColorPalleteNotifier>(context, listen: renderUI);

    PalleteData? selectedPallete =
        colorPalleteNotifier(renderUI: true).selectedPalleteData;

    List<PalleteData> data = [
      PalleteData(
          palleteId: 0,
          colorTitle: "Blue",
          colorDescription: "Demo description",
          color: Colors.blue,
          hexValue: "fb8500"),
      PalleteData(
          palleteId: 1,
          colorTitle: "Red",
          colorDescription: "Demo description",
          color: Colors.red,
          hexValue: "219ebc"),
      PalleteData(
          palleteId: 2,
          colorTitle: "Yellow",
          colorDescription: "Demo description",
          color: Colors.yellow,
          hexValue: "ccd5ae"),
      PalleteData(
          palleteId: 3,
          colorTitle: "Green",
          colorDescription: "Demo description",
          color: Colors.green,
          hexValue: "ffc8dd"),
      PalleteData(
          palleteId: 4,
          colorTitle: "Orange",
          colorDescription: "Demo description",
          color: Colors.orange,
          hexValue: "ccd5ae"),
    ];

    buildPalleteBlock({required List<PalleteData> renderData}) {
      singlePallete({required PalleteData kData}) {
        bool isSelected = colorPalleteNotifier(renderUI: true)
                .selectedPalleteData!
                .palleteId ==
            kData.palleteId;

        return GestureDetector(
          onTap: () {
            colorPalleteNotifier(renderUI: false)
                .setPalleteData(palleteData: kData);
          },
          child: Container(
            width: isSelected ? 105 : 85,
            child: isSelected
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(kData.colorTitle,
                          style: KConstantTextstyles.bold(fontSize: 12)),
                      Text(kData.hexValue,
                          style: KConstantTextstyles.light(fontSize: 12)),
                    ],
                  ))
                : null,
            decoration: BoxDecoration(
                borderRadius: kData.palleteId == 0
                    ? BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      )
                    : kData.palleteId == 4
                        ? BorderRadius.only(
                            bottomRight: Radius.circular(12),
                            topRight: Radius.circular(12),
                          )
                        : null,
                border: Border.all(),
                color: kData.color),
          ),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView.builder(
            itemCount: renderData.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return singlePallete(kData: renderData[index]);
            },
          ),
          width: 400,
          height: 150,
          decoration: BoxDecoration(
              color: selectedPallete?.color,
              borderRadius: BorderRadius.circular(25)),
        ),
      );
    }

    return Scaffold(
        backgroundColor: selectedPallete?.color ?? KConstantColors.bgColor,
        appBar: CustomAppBar(
            color: selectedPallete?.color ?? KConstantColors.bgColor,
            title: "Custom Pallete"),
        body: Center(child: buildPalleteBlock(renderData: data)));
  }
}
