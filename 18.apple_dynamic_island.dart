import 'package:flutter/material.dart';
import 'package:ig_posts/features/1.flutter_frost_glass.view.dart';
import 'package:ig_posts/features/5.flutter_swiggy_button.dart';

class FlutterDynamicIslandMenu extends StatefulWidget {
  const FlutterDynamicIslandMenu({Key? key}) : super(key: key);

  @override
  State<FlutterDynamicIslandMenu> createState() =>
      _FlutterDynamicIslandMenuState();
}

class _FlutterDynamicIslandMenuState extends State<FlutterDynamicIslandMenu>
    with TickerProviderStateMixin {
  late final AnimationController callRecController =
      AnimationController(duration: const Duration(seconds: 1), vsync: this);
  late final Animation<double> _animation =
      CurvedAnimation(parent: callRecController, curve: Curves.fastOutSlowIn);

  late final AnimationController userController =
      AnimationController(duration: const Duration(seconds: 1), vsync: this);
  late final Animation<double> _userAnimation =
      CurvedAnimation(parent: userController, curve: Curves.fastOutSlowIn);

  bool isRecAnimating = false;
  bool isUserAnimating = false;
  bool showBaseTile = true;

  void playRecording() {
    setState(() {
      showBaseTile = !showBaseTile;
      isRecAnimating = !isRecAnimating;
      if (isRecAnimating) {
        callRecController.reset();
      } else {
        callRecController.forward();
      }
    });
  }

  void playUserTile() {
    setState(() {
      showBaseTile = !showBaseTile;
      isUserAnimating = !isUserAnimating;
      if (isUserAnimating) {
        userController.forward();
      } else {
        userController.reset();
      }
    });
  }

  void clearCall() {
    setState(() {
      showBaseTile = true;
      isRecAnimating = false;
      isUserAnimating = false;
      callRecController.reset();
      userController.reset();
    });
  }

  @override
  void dispose() {
    callRecController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _callRecordingChip() {
      return SizeTransition(
          sizeFactor: _animation,
          axis: Axis.horizontal,
          child: GestureDetector(
            onTap: () {
              // playRecording();
              playUserTile();
            },
            child: Container(
              width: 200,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: bgColorFaint),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  const Icon(Icons.call_end, color: Colors.green),
                  const SizedBox(width: 10),
                  Text("1:23", style: regulerText),
                  const Spacer(),
                  Image.asset("assets/voice.png"),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ));
    }

    userChip() {
      return SizeTransition(
          sizeFactor: _userAnimation,
          axis: Axis.vertical,
          axisAlignment: -1,
          child: GestureDetector(
            onTap: () {
              clearCall();
            },
            child: Container(
              width: 400,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: bgColorFaint),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    const CircleAvatar(
                        child: Icon(Icons.person, color: Colors.green)),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Mobile", style: regulerText),
                        Text("Abhishvek", style: boldText(fSize: 20)),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: const CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          child: Icon(Icons.call, color: Colors.white)),
                    ),
                    const SizedBox(width: 10),
                    const CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(Icons.call, color: Colors.white)),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ),
          ));
    }

    _baseChip() {
      return AnimatedOpacity(
        duration: const Duration(seconds: 1),
        opacity: 1, // showBaseTile ? 1 : 0,
        child: GestureDetector(
          onTap: () {
            playRecording();
          },
          child: Container(
            width: 150,
            height: 25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: bgColorFaint),
          ),
        ),
      );
    }

    _mainStack() {
      return Stack(
        alignment: Alignment.center,
        children: [
          _baseChip(),
          _callRecordingChip(),
          userChip(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: bgColor.withOpacity(0.8),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            _mainStack(),
            const SizedBox(height: 200),
            Text("🚀 Flutter\n Apple Dynamic Island",
                textAlign: TextAlign.center, style: boldText(fSize: 30)),
            const SizedBox(height: 10),
            Text("@abhishvek",
                textAlign: TextAlign.center, style: boldText(fSize: 10))
          ],
        ),
      ),
    );
  }
}
