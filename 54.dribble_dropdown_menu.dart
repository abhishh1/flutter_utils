import 'package:flutter/material.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:ig_posts/utils/dimensions.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:ig_posts/utils/font_size.widget.dart';

class MenuOption {
  final String title;
  final String description;

  const MenuOption({required this.title, required this.description});
}

List<MenuOption> options = [
  MenuOption(title: "Pictures", description: "Please add some more data"),
  MenuOption(title: "Videos", description: "Please add some more data"),
  MenuOption(title: "Audio", description: "Please add some more data"),
  MenuOption(title: "Other", description: "Please add some more data"),
];

class DribbleDropdownMenuNotifier extends ChangeNotifier {
  bool isExpanded = false;
  void toggleMenuExpansion() {
    isExpanded = !isExpanded;
    notifyListeners();
  }
}

class FlutterDribbleMenuDropDownView extends StatelessWidget {
  const FlutterDribbleMenuDropDownView({super.key});

  @override
  Widget build(BuildContext context) {
    DribbleDropdownMenuNotifier dribbleDropdownMenuNotifier(
            {required bool renderUI}) =>
        Provider.of<DribbleDropdownMenuNotifier>(context, listen: renderUI);

    bool isExpanded = dribbleDropdownMenuNotifier(renderUI: true).isExpanded;

    baseMenuButton() {
      return GestureDetector(
        onTap: () {
          dribbleDropdownMenuNotifier(renderUI: false).toggleMenuExpansion();
        },
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Container(
            height: 8.h,
            width: 40.w,
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Content",
                    style: KConstantTextstyles.bold(
                        fontSize: FontSize.kMedium + 8,
                        color: KConstantColors.bgColor)),
                hSizedBox2,
                Icon(!isExpanded ? Icons.arrow_drop_down : Icons.arrow_drop_up,
                    size: 30)
              ],
            )),
            decoration: BoxDecoration(
                border: isExpanded
                    ? Border.all(width: 5, color: KConstantColors.blueColor)
                    : null,
                color: KConstantColors.whiteColor,
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      );
    }

    showMenuOptions() {
      optionBlock({required MenuOption menuOption}) {
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(menuOption.title,
                    style: KConstantTextstyles.bold(
                        fontSize: FontSize.kMedium + 8,
                        color: KConstantColors.bgColor)),
                Text(menuOption.description,
                    style: KConstantTextstyles.light(
                        fontSize: FontSize.kMedium + 4,
                        color: KConstantColors.bgColor))
              ],
            ),
          ),
        );
      }

      return AnimatedOpacity(
        opacity: isExpanded ? 1 : 0,
        curve: Curves.ease,
        duration: const Duration(seconds: 1),
        child: Container(
          width: 70.w,
          child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              removeTop: true,
              child: ListView.builder(
                  itemCount: options.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return optionBlock(menuOption: options[index]);
                  })),
          decoration: BoxDecoration(
              color: KConstantColors.whiteColor,
              borderRadius: BorderRadius.circular(12)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: KConstantColors.bgColor,
      appBar: CustomAppBar(color: Colors.pink, title: "Dribble DropDown Menu"),
      body: Container(
        width: 100.w,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              vSizedBox3,
              baseMenuButton(),
              vSizedBox1,
              showMenuOptions()
            ],
          ),
        ),
      ),
    );
  }
}
