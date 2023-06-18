import 'package:flutter/material.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class SelectorNotifier extends ChangeNotifier {
  String? selectedItem;
  void setSelectedItem(String item) {
    selectedItem = item;
    notifyListeners();
  }
}

class ModernDataSelectorView extends StatelessWidget {
  const ModernDataSelectorView({super.key});

  @override
  Widget build(BuildContext context) {
    const kColor = Color.fromRGBO(106, 0, 244, 1);

    SelectorNotifier selectorNotifier({required bool renderUI}) =>
        Provider.of<SelectorNotifier>(context, listen: renderUI);

    List<String> menuItems = ['Swap', 'Liquidity', 'Discover'];

    Center renderHorizontalSelector() {
      createItem({required String itemTitle}) {
        bool isSelected =
            selectorNotifier(renderUI: true).selectedItem == itemTitle;

        return GestureDetector(
          onTap: () {
            selectorNotifier(renderUI: false).setSelectedItem(itemTitle);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0)
                .add(EdgeInsetsDirectional.only(end: 10)),
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                  color: isSelected ? kColor : KConstantColors.bgColorFaint,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(itemTitle,
                      style: KConstantTextstyles.light(fontSize: 12)),
                ),
              ),
            ),
          ),
        );
      }

      return Center(
        child: Container(
          child: SizedBox(
            width: 370,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: menuItems.length,
              itemBuilder: (BuildContext context, int index) {
                return createItem(itemTitle: menuItems[index]);
              },
            ),
          ),
          height: 50,
          decoration: BoxDecoration(
              color: KConstantColors.bgColorFaint,
              borderRadius: BorderRadius.circular(12)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: KConstantColors.bgColor,
      appBar: CustomAppBar(color: kColor, title: "Quick Data Selector"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          renderHorizontalSelector(),
          SizedBox(height: 30),
          Text(selectorNotifier(renderUI: true).selectedItem ?? "",
              style: KConstantTextstyles.bold(fontSize: 30)),
          SizedBox(height: 10),
          Text(
              "Lorem ipsum dolor sit amet. Et impedit molestiae rem voluptatem perspiciatis et quia voluptatum? 33 saepe quas ab quam doloremque non magnam enim et magnam accusantium et dolore ipsam vel neque necessitatibus in dolore temporibus. Qui vitae iure et facere asperiores est perspiciatis eaque. Ut voluptates omnis vel tempora pariatur vel velit suscipit et labore iusto sed nulla porro. A internos vero 33 consequatur pariatur quo laboriosam enim ut consectetur sequi. Et reiciendis quod sed tempore delectus est iste officiis et labore sint ut quia magni eos nesciunt autem et dignissimos autem. Qui assumenda possimus id quidem voluptas et molestiae natus ut maxime corrupti. Ea enim reprehenderit sit obcaecati numquam a nostrum voluptatem qui consectetur cupiditate qui dignissimos architecto non fugit quis. Qui illum quibusdam est illo corrupti quo tenetur nihil.",
              style: KConstantTextstyles.light(fontSize: 14))
        ],
      ),
    );
  }
}
