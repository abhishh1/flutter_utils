import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class FlutterParallaxCardEffectView extends StatelessWidget {
  const FlutterParallaxCardEffectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ParallaxCardWidget());
  }
}

class ParallaxCardWidget extends StatefulWidget {
  const ParallaxCardWidget({Key? key}) : super(key: key);

  @override
  State<ParallaxCardWidget> createState() => _ParallaxCardWidgetState();
}

class _ParallaxCardWidgetState extends State<ParallaxCardWidget> {
  double? _accelerometerXAxis;
  late final StreamSubscription<dynamic> _streamSubscription;

  @override
  void initState() {
    super.initState();
    _streamSubscription = accelerometerEvents.listen(
      (AccelerometerEvent event) {
        setState(() {
          _accelerometerXAxis = event.x;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedPositioned(
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 100),
                  left: 0,
                  right: _accelerometerXAxis != null
                      ? (-320 + _accelerometerXAxis! * 30)
                      : -320,
                  child: Image.asset(
                    'assets/space4.jpg',
                    fit: BoxFit.contain,
                  )),
              const Center(
                child: SizedBox(
                  height: 200,
                  width: 200,
                  child: CircleAvatar(
                      backgroundImage: AssetImage('assets/profile.png')),
                ),
              ),
              const Positioned(
                  top: 250,
                  child: Text("Hey there!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 40)))
            ],
          ),
        );
      },
    );
  }
}
