import 'package:flutter/material.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class StackedBottomSheetNotifier extends ChangeNotifier {
  bool _isSheetExpanded = false;
  bool get isSheetExpanded => _isSheetExpanded;

  void toggleSheetExpansion() {
    _isSheetExpanded = !_isSheetExpanded;
    notifyListeners();
  }
}

class StackedBottomSheetView extends StatelessWidget {
  const StackedBottomSheetView({super.key});

  @override
  Widget build(BuildContext context) {
    StackedBottomSheetNotifier stackedBottomSheetNotifier(
            {required bool renderUI}) =>
        Provider.of<StackedBottomSheetNotifier>(context, listen: renderUI);

    bool isSheetExpanded =
        stackedBottomSheetNotifier(renderUI: true).isSheetExpanded;

    Widget baseWidget() {
      return Stack(
        children: [
          Container(width: 500, height: 400),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.easeIn,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Some content",
                            style: KConstantTextstyles.bold(fontSize: 32)),
                        Text("Some more content header line",
                            style: KConstantTextstyles.light(fontSize: 12)),
                        if (isSheetExpanded) SizedBox(height: 10),
                        if (isSheetExpanded)
                          AnimatedOpacity(
                              curve: Curves.ease,
                              child: GridView.builder(
                                  itemCount: 8,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4),
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          height: 100,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: KConstantColors.redColor)),
                                    );
                                  }),
                              opacity: isSheetExpanded ? 1 : 0,
                              duration: Duration(seconds: 2))
                      ],
                    ),
                  ),
                ),
                width: 400,
                height: isSheetExpanded ? 320 : 90,
                decoration: BoxDecoration(
                    color: KConstantColors.bgColorFaint,
                    borderRadius: BorderRadius.circular(25))),
          ),
          Positioned(
            right: 30,
            child: CircleAvatar(
              backgroundColor: KConstantColors.bgColor,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: GestureDetector(
                  onTap: () {
                    stackedBottomSheetNotifier(renderUI: false)
                        .toggleSheetExpansion();
                  },
                  child: CircleAvatar(
                      child: Center(
                          child: Icon(isSheetExpanded
                              ? Icons.arrow_drop_down_rounded
                              : Icons.arrow_drop_up_rounded)),
                      backgroundColor: KConstantColors.bgColorFaint),
                ),
              ),
            ),
          )
        ],
      );
    }

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20),
          baseWidget(),
        ],
      ),
      backgroundColor: KConstantColors.bgColor,
      appBar: AppBar(
          backgroundColor: KConstantColors.bgColorFaint,
          title: Text("Stacked Expandable Container",
              style: KConstantTextstyles.bold(fontSize: 16))),
    );
  }
}
