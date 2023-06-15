import 'package:flutter/material.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class SubtitleSectionNotifier extends ChangeNotifier {
  String? selectedAudio = "English";
  String? selectedSubtitle = "Off";

  void setSubtitles({required String title}) {
    selectedSubtitle = title;
    notifyListeners();
  }

  void setAudio({required String title}) {
    selectedAudio = title;
    notifyListeners();
  }
}

class FlutterSubtitleSectionView extends StatelessWidget {
  const FlutterSubtitleSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> languages = [
      "English",
      "मराठी",
      "हिंदी",
      "ગુજરાતી",
      "આસામી",
      "অসমীয়া"
    ];

    List<String> subtitles = ["Off", "English", "Hindi"];

    SubtitleSectionNotifier subtitleSectionNotifier({required bool renderUI}) =>
        Provider.of<SubtitleSectionNotifier>(context, listen: renderUI);

    subtitleBlock({required String title}) {
      bool isSelected =
          subtitleSectionNotifier(renderUI: true).selectedSubtitle == title;

      return GestureDetector(
        onTap: () {
          subtitleSectionNotifier(renderUI: false).setSubtitles(title: title);
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
                color: isSelected
                    ? KConstantColors.bgColor
                    : KConstantColors.bgColorFaint,
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  SizedBox(
                      width: 100,
                      child: Text(title,
                          style: KConstantTextstyles.light(fontSize: 14))),
                  SizedBox(width: 20),
                  if (isSelected)
                    CircleAvatar(radius: 8, child: Icon(Icons.check, size: 12))
                ],
              ),
            ),
          ),
        ),
      );
    }

    audioBlock({required String title}) {
      bool isSelected =
          subtitleSectionNotifier(renderUI: true).selectedAudio == title;

      return GestureDetector(
        onTap: () {
          subtitleSectionNotifier(renderUI: false).setAudio(title: title);
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            decoration: BoxDecoration(
                color: isSelected
                    ? KConstantColors.bgColor
                    : KConstantColors.bgColorFaint,
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  SizedBox(
                      width: 100,
                      child: Text(title,
                          style: KConstantTextstyles.light(fontSize: 14))),
                  SizedBox(width: 20),
                  if (isSelected)
                    CircleAvatar(radius: 8, child: Icon(Icons.check, size: 12))
                ],
              ),
            ),
          ),
        ),
      );
    }

    showSubtitleSection() {
      return showModalBottomSheet(
          backgroundColor: KConstantColors.bgColorFaint,
          context: context,
          builder: (context) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Center(
                    child: Container(
                        width: 100,
                        height: 6,
                        decoration: BoxDecoration(
                            color: KConstantColors.greyColor,
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text("Audio",
                              style: KConstantTextstyles.bold(fontSize: 22)),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 300,
                            width: 170,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: languages.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return audioBlock(title: languages[index]);
                              },
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text("Subtitles",
                              style: KConstantTextstyles.bold(fontSize: 22)),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 200,
                            width: 170,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: subtitles.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return subtitleBlock(title: subtitles[index]);
                              },
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 60),
                  Center(
                    child: Text(
                        "You can change audio and subtitle at any moment in the show",
                        style: KConstantTextstyles.light(
                            fontSize: 12, color: KConstantColors.greyColor)),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                  color: KConstantColors.bgColorFaint,
                  borderRadius: BorderRadius.circular(12)),
            );
          });
    }

    String audio = subtitleSectionNotifier(renderUI: true).selectedAudio ??
        "Please select on";
    String subtitle =
        subtitleSectionNotifier(renderUI: true).selectedSubtitle ??
            "Please select on";

    return Scaffold(
      backgroundColor: KConstantColors.bgColorFaint,
      appBar: CustomAppBar(title: "JioCinema Subtitle Section"),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
                icon: Icon(Icons.subtitles, color: Colors.pink),
                onPressed: () {
                  showSubtitleSection();
                }),
          ),
          SizedBox(height: 100),
          Text("Selected Audio : ${audio}",
              style: KConstantTextstyles.bold(fontSize: 20)),
          SizedBox(height: 10),
          Text("Selected Subtitle : ${subtitle}",
              style: KConstantTextstyles.bold(fontSize: 20))
        ],
      ),
    );
  }
}
