import 'package:flutter/material.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class ColorDragNotifier extends ChangeNotifier {
  Color defColor = KConstantColors.bgColorFaint;

  void setDraggedColor({required Color value}) {
    defColor = value;
    notifyListeners();
  }
}

class FlutterColorDragAndDropView extends StatelessWidget {
  const FlutterColorDragAndDropView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorDragNotifier colorDragNotifier({required bool renderUI}) =>
        Provider.of<ColorDragNotifier>(context, listen: renderUI);

    renderDragTarget() {
      return DragTarget<Color>(
        onAccept: (val) {
          colorDragNotifier(renderUI: false).setDraggedColor(value: val);
        },
        builder: (context, candidateItems, rejectedItems) {
          return Container(
            height: 300,
            width: 400,
            decoration: BoxDecoration(
                color: colorDragNotifier(renderUI: true).defColor,
                borderRadius: BorderRadius.circular(12)),
          );
        },
      );
    }

    renderColorToDrop() {
      _colorBlock({required Color color}) {
        return LongPressDraggable<Color>(
            data: color,
            dragAnchorStrategy: pointerDragAnchorStrategy,
            child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(12))),
            feedback: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset("assets/brush.png"),
            ));
      }

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _colorBlock(color: KConstantColors.redColor),
          _colorBlock(color: KConstantColors.blueColor),
          _colorBlock(color: KConstantColors.whiteColor),
          _colorBlock(color: KConstantColors.textFieldTextColor),
        ],
      );
    }

    return Scaffold(
      backgroundColor: KConstantColors.bgColor,
      appBar: CustomAppBar(title: "Flutter Custom Color Dropper"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            renderDragTarget(),
            SizedBox(height: 50),
            renderColorToDrop()
          ],
        ),
      ),
    );
  }
}
