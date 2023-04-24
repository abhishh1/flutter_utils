import 'package:flutter/material.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:ig_posts/utils/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:random_string/random_string.dart';

class PinterestSearchBarNotifier extends ChangeNotifier {
  final TextEditingController textEditingController = TextEditingController();

  settleQuery({required String value}) {
    String existingText = textEditingController.text;
    String newText = existingText + " $value";
    textEditingController..text = newText;
    textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: textEditingController.text.length));
    notifyListeners();
  }

  List<String> generatedSuggesions = [];

  void generateSuggesions({required String userInput}) {
    generatedSuggesions.clear();
    if (userInput.toLowerCase().contains("gift")) {
      generatedSuggesions
          .addAll(["for family", "flowers", "under \$5", "aesthetic"]);
      notifyListeners();
    } else if (userInput.toLowerCase().contains("learn")) {
      generatedSuggesions.addAll(["flutter", "dart", "python", "maths"]);
      notifyListeners();
    } else if (userInput.toLowerCase().contains("drive")) {
      generatedSuggesions.addAll(["mercedes", "audi", "ferrari", "me crazy"]);
      notifyListeners();
    }
  }

  void clearSuggetions() {
    generatedSuggesions.clear();
    textEditingController.clear();
    notifyListeners();
  }

  List colors = [
    Colors.brown,
    KConstantColors.purpleColor,
    KConstantColors.bgColor,
    Colors.redAccent,
    Colors.deepOrangeAccent,
    Colors.green
  ];

  Color getRandomColor() {
    int randomInt = randomBetween(0, colors.length - 1);
    return colors[randomInt];
  }
}

class PinterestSearchBarWidget extends StatefulWidget {
  const PinterestSearchBarWidget({super.key});

  @override
  State<PinterestSearchBarWidget> createState() =>
      _PinterestSearchBarWidgetState();
}

class _PinterestSearchBarWidgetState extends State<PinterestSearchBarWidget> {
  PinterestSearchBarNotifier pinterestSearchBarNotifier(
          {required bool renderUI}) =>
      Provider.of<PinterestSearchBarNotifier>(context, listen: renderUI);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController =
        pinterestSearchBarNotifier(renderUI: true).textEditingController;

    Widget suggestions() {
      suggestionBlock({required String value}) {
        return Padding(
          padding: const EdgeInsets.only(right: 16),
          child: ActionChip(
            label: Text(value, style: KConstantTextstyles.light(fontSize: 10)),
            onPressed: () {
              pinterestSearchBarNotifier(renderUI: false)
                  .settleQuery(value: value);
            },
            backgroundColor:
                pinterestSearchBarNotifier(renderUI: true).getRandomColor(),
          ),
        );
      }

      return SizedBox(
          width: 100,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: pinterestSearchBarNotifier(renderUI: true)
                  .generatedSuggesions
                  .length,
              itemBuilder: (context, index) {
                return suggestionBlock(
                    value: pinterestSearchBarNotifier(renderUI: true)
                        .generatedSuggesions[index]);
              }));
    }

    return Scaffold(
      backgroundColor: KConstantColors.bgColor,
      appBar: CustomAppBar(title: "Pinterest Suggestion Bar"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (val) {
                if (val == "") {
                  pinterestSearchBarNotifier(renderUI: false).clearSuggetions();
                } else {
                  pinterestSearchBarNotifier(renderUI: false)
                      .generateSuggesions(userInput: val);
                }
              },
              style: KCustomTextStyle.kRegular(
                  context, 16, KConstantColors.whiteColor),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  hintStyle: KCustomTextStyle.kRegular(context, 16),
                  hintText: "Search anything",
                  filled: true,
                  fillColor: KConstantColors.bgColorFaint),
              controller: textEditingController,
            ),
          ),
          SizedBox(height: 10),
          if (pinterestSearchBarNotifier(renderUI: true)
              .generatedSuggesions
              .isNotEmpty)
            Text("Refine your search",
                style: KConstantTextstyles.light(fontSize: 12)),
          suggestions()
        ],
      ),
    );
  }
}
