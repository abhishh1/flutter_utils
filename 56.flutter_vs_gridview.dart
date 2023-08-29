import 'package:flutter/material.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:ig_posts/utils/dimensions.dart';
import 'package:ig_posts/utils/font_size.widget.dart';
import 'package:ig_posts/utils/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class LVGNotifier extends ChangeNotifier {
  bool isGrid = false;
  void toggleLVG() {
    isGrid = !isGrid;
    notifyListeners();
  }
}

class MockData {
  final String title;
  final String description;
  final double amount;
  final double percentage;
  final String iconData;

  const MockData(
      {required this.title,
      required this.description,
      required this.amount,
      required this.iconData,
      required this.percentage});
}

List<MockData> data = [
  MockData(
      title: "Stake Casino",
      description: "DICE",
      amount: 1521,
      iconData:
          "https://images-platform.99static.com//th-15yHL9kPbh1JY1LQvkp04Qng=/148x119:1387x1358/fit-in/500x500/99designs-contests-attachments/95/95013/attachment_95013731",
      percentage: 90.53),
  MockData(
      title: "Gamomat",
      description: "PLINKO",
      amount: 1212,
      iconData:
          "https://img.freepik.com/premium-vector/lettering-word-king-with-gold-color-shine_185390-7.jpg",
      percentage: 89.12),
  MockData(
      title: "Avatar UX",
      description: "MINES",
      amount: 1200,
      iconData:
          "https://cdn1.designhill.com/uploads/personal_designs/20514006d358d7cd882ec4abfcd93347-3d62a5c0c4bf52f729503945d05973881606224947654.png?ver=2.12.60",
      percentage: 87.13),
  MockData(
      title: "Combatat",
      description: "KETO",
      amount: 1517,
      iconData:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTDOk55uXrFx4Y0YK3YVkbbUaEoPdNl0vf1A&usqp=CAU",
      percentage: 85.52),
  MockData(
      title: "Push Gaming",
      description: "LIMBO",
      amount: 1251.12,
      iconData:
          "https://img.favpng.com/25/2/3/graffiti-street-art-urban-art-png-favpng-U229raFLw7fa92Ft8xHVQG3eL.jpg",
      percentage: 81.53),
  MockData(
      title: "Oribato",
      description: "KIU",
      amount: 1000.12,
      iconData:
          "https://i.pinimg.com/originals/88/0a/f4/880af4a6e7e6e4fd246b03985abafedd.jpg",
      percentage: 79.23),
];

class KListBlock extends StatelessWidget {
  const KListBlock({super.key});

  @override
  Widget build(BuildContext context) {
    renderBlock(int index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            children: [
              Container(
                  width: 5.w,
                  height: 10.h,
                  child: Center(
                      child: Text(index.toString(),
                          style: KCustomTextStyle.kBold(
                              context, FontSize.kMedium))),
                  decoration: BoxDecoration(
                      color: PRIMARY_COLOR,
                      borderRadius: BorderRadius.circular(12))),
              hSizedBox3,
              Container(
                width: 20.w,
                height: 10.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(data[index].iconData),
                        fit: BoxFit.cover),
                    color: KConstantColors.depthWiteColor,
                    borderRadius: BorderRadius.circular(12)),
              ),
              hSizedBox2,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data[index].title,
                      style:
                          KCustomTextStyle.kBold(context, FontSize.kReguler)),
                  Text(data[index].description,
                      style:
                          KCustomTextStyle.kLight(context, FontSize.kMedium)),
                ],
              ),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("${data[index].percentage}%",
                      style:
                          KCustomTextStyle.kBold(context, FontSize.kReguler)),
                  Text("\$${data[index].amount.toInt()}",
                      style:
                          KCustomTextStyle.kLight(context, FontSize.kMedium)),
                ],
              ),
            ],
          ),
        ),
      );
    }

    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return renderBlock(index);
        },
      ),
    );
  }
}

class KGridBlock extends StatelessWidget {
  const KGridBlock({super.key});

  @override
  Widget build(BuildContext context) {
    renderBlock(int index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: KConstantColors.greyColor),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 12,
                  backgroundColor: PRIMARY_COLOR,
                  child: Center(
                      child: Text(index.toString(),
                          style: KCustomTextStyle.kBold(context, 10)))),
              vSizedBox1,
              Container(
                width: 20.w,
                height: 10.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(data[index].iconData),
                        fit: BoxFit.cover),
                    color: KConstantColors.depthWiteColor,
                    borderRadius: BorderRadius.circular(12)),
              ),
              vSizedBox0,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(data[index].title,
                      style:
                          KCustomTextStyle.kBold(context, FontSize.kReguler)),
                  Text(data[index].description,
                      style:
                          KCustomTextStyle.kLight(context, FontSize.kMedium)),
                ],
              ),
              vSizedBox1,
              Chip(
                  backgroundColor: PRIMARY_COLOR,
                  label: Text(
                      "${data[index].percentage}% : \$${data[index].amount.toInt()}",
                      style:
                          KCustomTextStyle.kBold(context, FontSize.kReguler)))
            ],
          ),
        ),
      );
    }

    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: GridView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: 6,
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.7, crossAxisCount: 2),
            itemBuilder: (context, index) {
              return renderBlock(index);
            }));
  }
}

class SoloListComponent extends StatelessWidget {
  const SoloListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Row(
          children: [
            Container(
                width: 5.w,
                height: 10.h,
                child: Center(
                    child: Text(0.toString(),
                        style:
                            KCustomTextStyle.kBold(context, FontSize.kMedium))),
                decoration: BoxDecoration(
                    color: PRIMARY_COLOR,
                    borderRadius: BorderRadius.circular(12))),
            hSizedBox3,
            Container(
              width: 20.w,
              height: 10.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(data[0].iconData), fit: BoxFit.cover),
                  color: KConstantColors.depthWiteColor,
                  borderRadius: BorderRadius.circular(12)),
            ),
            hSizedBox2,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data[0].title,
                    style: KCustomTextStyle.kBold(context, FontSize.kReguler)),
                Text(data[0].description,
                    style: KCustomTextStyle.kLight(context, FontSize.kMedium)),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("${data[0].percentage}%",
                    style: KCustomTextStyle.kBold(context, FontSize.kReguler)),
                Text("\$${data[0].amount.toInt()}",
                    style: KCustomTextStyle.kLight(context, FontSize.kMedium)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SoloGridComponent extends StatelessWidget {
  const SoloGridComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: KConstantColors.greyColor),
            borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                  radius: 12,
                  backgroundColor: PRIMARY_COLOR,
                  child: Center(
                      child: Text(0.toString(),
                          style: KCustomTextStyle.kBold(context, 10)))),
              vSizedBox1,
              Container(
                width: 20.w,
                height: 10.h,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(data[0].iconData),
                        fit: BoxFit.cover),
                    color: KConstantColors.depthWiteColor,
                    borderRadius: BorderRadius.circular(12)),
              ),
              vSizedBox0,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(data[0].title,
                      style:
                          KCustomTextStyle.kBold(context, FontSize.kReguler)),
                  Text(data[0].description,
                      style:
                          KCustomTextStyle.kLight(context, FontSize.kMedium)),
                ],
              ),
              vSizedBox1,
              Chip(
                  backgroundColor: PRIMARY_COLOR,
                  label: Text(
                      "${data[0].percentage}% : \$${data[0].amount.toInt()}",
                      style:
                          KCustomTextStyle.kBold(context, FontSize.kReguler)))
            ],
          ),
        ),
      ),
    );
  }
}

class MoreButton extends StatelessWidget {
  const MoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    LVGNotifier lVGNotifier({required bool renderUI}) =>
        Provider.of<LVGNotifier>(context, listen: renderUI);

    bool isGrid = lVGNotifier(renderUI: true).isGrid;

    return GestureDetector(
      onTap: () {
        lVGNotifier(renderUI: false).toggleLVG();
      },
      child: Container(
        height: 5.h,
        width: 20.w,
        decoration: BoxDecoration(
            color: PRIMARY_COLOR, borderRadius: BorderRadius.circular(15)),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("View",
                style: KCustomTextStyle.kBold(context, FontSize.kMedium)),
            hSizedBox1,
            if (!isGrid) Icon(Icons.list),
            if (isGrid) Icon(Icons.grid_3x3)
          ],
        )),
      ),
    );
  }
}

const PRIMARY_COLOR = Color.fromRGBO(6, 214, 160, 1);
const SECONDARY_COLOR = Color.fromRGBO(2, 48, 71, 1);

class FlutterListVSGridView extends StatelessWidget {
  const FlutterListVSGridView({super.key});

  @override
  Widget build(BuildContext context) {
    LVGNotifier lVGNotifier({required bool renderUI}) =>
        Provider.of<LVGNotifier>(context, listen: renderUI);

    bool isGrid = lVGNotifier(renderUI: true).isGrid;

    return Scaffold(
      backgroundColor: SECONDARY_COLOR,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              vSizedBox3,
              vSizedBox2,
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Best Performing",
                            style: KCustomTextStyle.kBold(
                                context, FontSize.header)),
                        Text("Top in the business",
                            style: KCustomTextStyle.kLight(
                                context, FontSize.kMedium)),
                      ],
                    ),
                    const Spacer(),
                    MoreButton(),
                    // hSizedBox0
                  ]),
              vSizedBox1,
              if (!isGrid) KListBlock(),
              if (isGrid) KGridBlock(),
              vSizedBox2,
              Center(
                  child: Text("Brough by Yuino",
                      style: KCustomTextStyle.kBold(context, FontSize.kMedium,
                          KConstantColors.greyColor))),
              vSizedBox4
            ],
          ),
        ),
      ),
    );
  }
}
