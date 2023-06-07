import 'package:flutter/material.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class BrowseSectionNotifier extends ChangeNotifier {
  bool expandMore = false;

  void toggleExpansion() {
    expandMore = !expandMore;
    notifyListeners();
  }
}

class ModernBrowseSectionView extends StatelessWidget {
  const ModernBrowseSectionView({super.key});

  @override
  Widget build(BuildContext context) {
    BrowseSectionNotifier browseSectionNotifier({required bool renderUI}) =>
        Provider.of<BrowseSectionNotifier>(context, listen: renderUI);

    renderSmallItems() {
      smallItemBlock() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 120,
                    height: 100,
                    child: Image.asset("assets/drink_2.png")),
                SizedBox(height: 10),
                Text("Data", style: KConstantTextstyles.light(fontSize: 12))
              ],
            ),
            decoration: BoxDecoration(
                color: KConstantColors.bgColorFaint,
                borderRadius: BorderRadius.circular(12)),
          ),
        );
      }

      return SizedBox(
        width: 500,
        height: 180,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return smallItemBlock();
          },
        ),
      );
    }

    renderLargeItems() {
      largeItemBlock() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: 120,
                      height: 80,
                      child: Image.asset("assets/drink_2.png")),
                ),
                SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Data", style: KConstantTextstyles.bold(fontSize: 12)),
                    Text("Some more data",
                        style: KConstantTextstyles.light(fontSize: 12))
                  ],
                )
              ]),
              decoration: BoxDecoration(
                  color: KConstantColors.bgColorFaint,
                  borderRadius: BorderRadius.circular(12))),
        );
      }

      return ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return largeItemBlock();
        },
      );
    }

    return Scaffold(
      backgroundColor: KConstantColors.bgColor,
      appBar: CustomAppBar(title: "Modern Browse Section"),
      body: Column(
        children: [
          ListTile(
            title:
                Text("Products", style: KConstantTextstyles.bold(fontSize: 28)),
            subtitle: Text("Checkout items from our store",
                style: KConstantTextstyles.light(fontSize: 16)),
            trailing: TextButton(
              child: Text(
                  !browseSectionNotifier(renderUI: true).expandMore
                      ? "Show less"
                      : "Browse more",
                  style: KConstantTextstyles.light(fontSize: 12)),
              onPressed: () {
                browseSectionNotifier(renderUI: false).toggleExpansion();
              },
            ),
          ),
          SizedBox(height: 10),
          AnimatedCrossFade(
              firstChild: renderSmallItems(),
              secondChild: renderLargeItems(),
              crossFadeState: browseSectionNotifier(renderUI: true).expandMore
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(seconds: 1))
        ],
      ),
    );
  }
}
