import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ig_posts/features/1.flutter_frost_glass.view.dart';
import 'package:ig_posts/features/5.flutter_swiggy_button.dart';
import 'package:provider/provider.dart';

class OnScrollNotifier extends ChangeNotifier {
  bool _isViewScrolling = false;
  bool get isViewScrolling => _isViewScrolling;

  void setOnViewScrolling({required bool isScrolling}) {
    _isViewScrolling = isScrolling;
    notifyListeners();
  }
}

class FlutterOnScrollContainerFab extends StatefulWidget {
  const FlutterOnScrollContainerFab({super.key});

  @override
  State<FlutterOnScrollContainerFab> createState() =>
      _FlutterOnScrollContainerFabState();
}

class _FlutterOnScrollContainerFabState
    extends State<FlutterOnScrollContainerFab> {
  OnScrollNotifier onScrollNotifier({required bool renderUI}) =>
      Provider.of<OnScrollNotifier>(context, listen: renderUI);

  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          onScrollNotifier(renderUI: false)
              .setOnViewScrolling(isScrolling: false);
        } else {
          onScrollNotifier(renderUI: false)
              .setOnViewScrolling(isScrolling: true);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isScrolling = onScrollNotifier(renderUI: true).isViewScrolling;

    Widget customFab() {
      if (!isScrolling) {
        return AnimatedContainer(
          curve: Curves.linearToEaseOut,
          duration: Duration(milliseconds: 100),
          height: 50,
          width: 300,
          child: Center(child: Text("Add your widget here", style: boldText())),
          decoration: BoxDecoration(
              color: bgColorFaint, borderRadius: BorderRadius.circular(25)),
        );
      } else {
        return AnimatedContainer(
          duration: Duration(milliseconds: 500),
          height: 50,
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.comment, color: Colors.white),
              SizedBox(width: 10),
              Text("12", style: regulerText),
              SizedBox(width: 30),
              Icon(Icons.thumb_up, color: Colors.white),
              SizedBox(width: 10),
              Text("07", style: regulerText),
            ],
          ),
          decoration: BoxDecoration(
              color: bgColorFaint, borderRadius: BorderRadius.circular(25)),
        );
      }
    }

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: customFab(),
      backgroundColor: bgColor,
      appBar: AppBar(
          title: Text("Flutter FAB animation", style: boldText()),
          backgroundColor: bgColorFaint),
      body: ListView.builder(
        controller: scrollController,
        shrinkWrap: true,
        itemCount: 50,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              leading: CircleAvatar(backgroundColor: Colors.orangeAccent),
              subtitle: Text("Some demo data", style: regulerText),
              title: Text("Item no : $index", style: boldText()));
        },
      ),
    );
  }
}
