import 'dart:ui';
import 'package:flutter/material.dart';

const bgColorFaint = Color.fromRGBO(22, 24, 27, 1);
const bgColor = Color.fromRGBO(11, 12, 14, 1);

class FlutterFrostView extends StatelessWidget {
  const FlutterFrostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map> data = [
      {
        "title": "Naruto",
        "image": "assets/naruto.jpeg",
        "description":
            "Naruto is an orphan who has a dangerous fox-like entity known as Kurama the Nine-Tailed Fox sealed within his body by his father, the Fourth Hokage Minato Namikaze, the leader of Konoha's ninja force, at the cost of his own life and that of his wife, Kushina Uzumaki."
      },
      {
        "title": "Sasuke",
        "image": "assets/sasuke.jpeg",
        "description":
            "Sasuke belongs to the Uchiha clan, a notorious ninja family, and one of the most powerful, allied with Konohagakure (木ノ葉隠れの里, English version: 'Hidden Leaf Village'). Most of its members were massacred by Sasuke's older brother, Itachi Uchiha, before the series began, leaving Sasuke one of the few living."
      },
      {
        "title": "Kakashi",
        "image": "assets/kakshi.jpeg",
        "description":
            "Kakashi graduated from the Ninja Academy and became a Genin, when he was merely 5 years old, then at 6 years old, became a Chuunin. He later became a Jounin and a member of the AnBu Assasination squad for Hidden Leaf Village. We see him as he takes up the role as being a sensei for the new Chunnins."
      }
    ];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
          backgroundColor: bgColorFaint,
          title: const Text("Flutter Frosted Glass Effect🚀")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 500,
            width: 500,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return FrostedCardWidget(data: data[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FrostedCardWidget extends StatelessWidget {
  final Map data;
  const FrostedCardWidget({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: SizedBox(
            height: 600,
            width: 400,
            child: Stack(
              children: [
                SizedBox(
                    height: 600,
                    width: 400,
                    child: Image.asset(
                      data['image'],
                      fit: BoxFit.cover,
                    )),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                      child: SizedBox(
                          width: 500.0,
                          height: 280.0,
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(data['title'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 50)),
                              const SizedBox(height: 10),
                              Text(data['description'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(height: 10),
                              const Chip(
                                backgroundColor: Colors.red,
                                label: Text("Buy item",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ))),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
