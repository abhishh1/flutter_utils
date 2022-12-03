import 'package:flutter/material.dart';
import 'package:ig_posts/features/1.flutter_frost_glass.view.dart';
import 'package:ig_posts/features/5.flutter_swiggy_button.dart';
import 'package:provider/provider.dart';

class BottomSheetNotifier extends ChangeNotifier {
  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;

  void toggleExpansion() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }
}

class FlutterAnimatedBottomSheet extends StatelessWidget {
  const FlutterAnimatedBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    myBottomSheet() {
      return showModalBottomSheet(
          isScrollControlled: true,
          isDismissible: true,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          context: context,
          builder: (context) {
            BottomSheetNotifier bottomSheetNotifier({required bool renderUI}) =>
                Provider.of<BottomSheetNotifier>(context, listen: renderUI);
            bool isExpanded = bottomSheetNotifier(renderUI: true).isExpanded;

            return AnimatedContainer(
                color: bgColorFaint,
                height: isExpanded ? 700 : 300,
                width: 500,
                duration: const Duration(seconds: 1),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        bottomSheetNotifier(renderUI: false).toggleExpansion();
                      },
                      child: CircleAvatar(
                        backgroundColor: bgColor,
                        child: Icon(
                            bottomSheetNotifier(renderUI: true).isExpanded
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text("Some content here", style: boldText()),
                    Text("Some more additional content here",
                        style: regulerText),
                  ],
                )));
          });
    }

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
          backgroundColor: bgColorFaint,
          title: Text("Flutter Expandable Sheet 🔥", style: boldText())),
      body: Center(
        child: ElevatedButton(
          child: Text("Show sheet", style: regulerText),
          onPressed: () {
            myBottomSheet();
          },
        ),
      ),
    );
  }
}
