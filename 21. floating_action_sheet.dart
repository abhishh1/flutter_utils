import 'package:flutter/material.dart';
import 'package:ig_posts/features/1.flutter_frost_glass.view.dart';
import 'package:ig_posts/features/5.flutter_swiggy_button.dart';

class FlutterFloatingSheetWidget extends StatelessWidget {
  const FlutterFloatingSheetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    kDivider() => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Divider(thickness: 0.5, color: Colors.white.withOpacity(0.5)),
        );

    kButton({required IconData iconData, required String title}) => Row(
          children: [
            const SizedBox(width: 20),
            Icon(iconData, size: 16),
            const SizedBox(width: 10),
            Text(title, style: boldText(fSize: 16))
          ],
        );

    showSheet() {
      return showModalBottomSheet(
          backgroundColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          barrierColor: Colors.transparent,
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    color: bgColor, borderRadius: BorderRadius.circular(26)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          const CircleAvatar(
                              radius: 16,
                              backgroundImage:
                                  AssetImage("assets/naruto.jpeg")),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Naruto : Shippuden", style: boldText()),
                              Text("Anime about naruto and his adventures",
                                  style: regulerText)
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_forward_ios,
                                  size: 12, color: Colors.white)),
                          const SizedBox(width: 5)
                        ],
                      ),
                      kDivider(),
                      kButton(
                          iconData: Icons.remove_red_eye, title: "Watch now"),
                      kDivider(),
                      kButton(iconData: Icons.thumb_up, title: "Dislike"),
                      kDivider(),
                      kButton(iconData: Icons.thumb_down, title: "Dislike"),
                      kDivider(),
                      kButton(iconData: Icons.share, title: "Share"),
                    ],
                  ),
                ),
              ),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
            backgroundColor: bgColor,
            title: Text("Flutter Floating Bottom Sheet", style: boldText())),
        backgroundColor: bgColorFaint,
        body: Center(
            child: ActionChip(
                label: Text("Show sheet", style: regulerText),
                onPressed: () {
                  showSheet();
                })));
  }
}
