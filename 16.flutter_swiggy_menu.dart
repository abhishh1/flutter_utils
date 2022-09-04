import 'package:flutter/material.dart';
import 'package:ig_posts/features/1.flutter_frost_glass.view.dart';
import 'package:provider/provider.dart';

class KConstantFonts {
  static const String poppinsRegular = "Poppins";
  static const String poppinsBold = "Poppins-B";
  static const String poppinsM = "Poppins-M";
}

class FoodItem {
  final String foodTitle;
  final IconData foodIcon;
  final String foodCategory;

  const FoodItem({
    required this.foodTitle,
    required this.foodIcon,
    required this.foodCategory,
  });
}

class PopupNotifier extends ChangeNotifier {
  List<FoodItem> allDishes = const [
    FoodItem(
        foodTitle: "Paneer Kadhai",
        foodIcon: Icons.food_bank,
        foodCategory: "paneer"),
    FoodItem(
        foodTitle: "Chicken biryani",
        foodIcon: Icons.food_bank,
        foodCategory: "biryani"),
    FoodItem(
        foodTitle: "Palak Paneer",
        foodIcon: Icons.food_bank,
        foodCategory: "paneer"),
    FoodItem(
        foodTitle: "Poha",
        foodIcon: Icons.food_bank,
        foodCategory: "breakfast"),
    FoodItem(
        foodTitle: "Tomato soup",
        foodIcon: Icons.food_bank,
        foodCategory: "soup"),
    FoodItem(
        foodTitle: "Garlic soup",
        foodIcon: Icons.food_bank,
        foodCategory: "soup"),
    FoodItem(
        foodTitle: "Palak butter",
        foodIcon: Icons.food_bank,
        foodCategory: "paneer"),
    FoodItem(
        foodTitle: "Sambar vada",
        foodIcon: Icons.food_bank,
        foodCategory: "breakfast"),
  ];

  String? selectedDish;

  setSelectedDish({required String value}) {
    selectedDish = value;
    notifyListeners();
  }

  bool isFoodFiltered = false;
  toggleFoodFilter({required bool value}) {
    isFoodFiltered = value;
    notifyListeners();
  }

  List<FoodItem> filterdFood = [];

  void filterFood() {
    filterdFood.clear();

    for (FoodItem foodItem in allDishes) {
      if (!filterdFood.contains(foodItem)) {
        if (selectedDish != null) {
          if (foodItem.foodCategory.contains(selectedDish!)) {
            filterdFood.add(foodItem);
            notifyListeners();
          }
        }
      }
    }
  }
}

TextStyle boldText = const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    fontFamily: KConstantFonts.poppinsBold,
    color: Colors.white);

TextStyle sboldText = const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    fontFamily: KConstantFonts.poppinsBold,
    color: Colors.white);

TextStyle mboldText = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    fontFamily: KConstantFonts.poppinsBold,
    color: Colors.white);

TextStyle regulerText = const TextStyle(
    fontSize: 12, fontFamily: KConstantFonts.poppinsM, color: Colors.white);

class FlutterSwiggyButtonWidget extends StatelessWidget {
  const FlutterSwiggyButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PopupNotifier popupNotifier({required bool renderUI}) =>
        Provider.of<PopupNotifier>(context, listen: renderUI);

    List<FoodItem> items = popupNotifier(renderUI: true).isFoodFiltered
        ? popupNotifier(renderUI: true).filterdFood
        : popupNotifier(renderUI: true).allDishes;

    pButton({required String title, required double price}) {
      return PopupMenuItem<String>(
          onTap: () {
            popupNotifier(renderUI: false).setSelectedDish(value: title);
            popupNotifier(renderUI: false).toggleFoodFilter(value: true);
            popupNotifier(renderUI: false).filterFood();
          },
          value: title,
          child: Row(
            children: [
              Text(title, style: sboldText),
              const SizedBox(width: 50),
              Text(price.toString(), style: regulerText)
            ],
          ));
    }

    final button = PopupMenuButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        color: bgColorFaint,
        child: Chip(
          backgroundColor: Colors.deepOrangeAccent,
          label: Text("See menu", style: sboldText),
        ),
        itemBuilder: (_) => <PopupMenuItem<String>>[
              pButton(title: "paneer", price: 20),
              pButton(title: "biryani", price: 40),
              pButton(title: "soup", price: 40),
              pButton(title: "breakfast", price: 40),
            ],
        onSelected: (_) {});

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (popupNotifier(renderUI: true).isFoodFiltered)
            ActionChip(
                backgroundColor: Colors.red,
                label: Text("Clear", style: sboldText),
                onPressed: () {
                  popupNotifier(renderUI: false).toggleFoodFilter(value: false);
                }),
          button
        ],
      ),
      backgroundColor: bgColor,
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset("assets/swiggy.png")),
              const SizedBox(width: 6),
              Text("Flutter Swiggy Menu", style: mboldText)
            ],
          ),
          backgroundColor: bgColorFaint),
      body: GridView.builder(
        shrinkWrap: true,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          FoodItem item = items[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: bgColorFaint, borderRadius: BorderRadius.circular(25)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(child: Icon(item.foodIcon)),
                  const SizedBox(height: 10),
                  Text(item.foodTitle,
                      textAlign: TextAlign.center, style: boldText),
                  Chip(
                      backgroundColor: bgColor,
                      label: Text(item.foodCategory, style: regulerText))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
