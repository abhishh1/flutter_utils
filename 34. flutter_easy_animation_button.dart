import 'package:flutter/material.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class AnimatedSubscribeButtonNotifier extends ChangeNotifier {
  AnimationController? animationController;

  bool isAnimated = false;
  void toggleAnimationState() {
    isAnimated = !isAnimated;
    if (isAnimated) {
      animationController?.forward();
    } else {
      animationController?.reverse();
    }
    notifyListeners();
  }
}

class AnimatedSubscribeButtonWidget extends StatefulWidget {
  const AnimatedSubscribeButtonWidget({super.key});

  @override
  State<AnimatedSubscribeButtonWidget> createState() =>
      _AnimatedSubscribeButtonWidgetState();
}

class _AnimatedSubscribeButtonWidgetState
    extends State<AnimatedSubscribeButtonWidget>
    with SingleTickerProviderStateMixin {
  AnimatedSubscribeButtonNotifier animatedSubscribeButtonNotifier(
          {required bool renderUI}) =>
      Provider.of<AnimatedSubscribeButtonNotifier>(context, listen: renderUI);

  @override
  void initState() {
    animatedSubscribeButtonNotifier(renderUI: false).animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isAnimated =
        animatedSubscribeButtonNotifier(renderUI: true).isAnimated;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: KConstantColors.bgColor,
          title: Text("Flutter Easy Animation",
              style: KConstantTextstyles.bold(fontSize: 16))),
      backgroundColor: KConstantColors.bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionChip(
              label: Text(isAnimated ? "Hide information" : "Show information",
                  style: KConstantTextstyles.light(fontSize: 14)),
              backgroundColor: isAnimated
                  ? KConstantColors.redColor
                  : KConstantColors.blueColor,
              onPressed: () {
                animatedSubscribeButtonNotifier(renderUI: false)
                    .toggleAnimationState();
              },
            ),
            const SizedBox(height: 20),
            SizeTransition(
              sizeFactor: animatedSubscribeButtonNotifier(renderUI: true)
                  .animationController!,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: KConstantColors.bgColorFaint),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                          style: KConstantTextstyles.light(fontSize: 12)),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
