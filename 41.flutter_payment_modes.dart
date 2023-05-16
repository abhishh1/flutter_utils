import 'package:flutter/material.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:provider/provider.dart';

class PaymentPlan {
  final int index;
  final String title;
  final String description;
  final double price;
  final List<String> features;
  final Color themeColor;

  const PaymentPlan({
    required this.index,
    required this.title,
    required this.description,
    required this.price,
    required this.features,
    required this.themeColor,
  });
}

class PaymentPlanNotifier extends ChangeNotifier {
  int selectedPaymentPlanIndex = 0;
  bool isVerticalMode = false;

  void setPaymentPlanIndex({required int value}) {
    selectedPaymentPlanIndex = value;
    notifyListeners();
  }

  void toggleVericalMode() {
    isVerticalMode = !isVerticalMode;
    notifyListeners();
  }
}

class FlutterPaymentPlanView extends StatelessWidget {
  const FlutterPaymentPlanView({super.key});

  @override
  Widget build(BuildContext context) {
    PaymentPlanNotifier paymentPlanNotifier({required bool renderUI}) =>
        Provider.of<PaymentPlanNotifier>(context, listen: renderUI);

    List<PaymentPlan> paymentPlans = [
      PaymentPlan(
          themeColor: KConstantColors.redColor,
          index: 0,
          title: "Basic",
          description: "Demo description",
          price: 0,
          features: []),
      PaymentPlan(
          themeColor: KConstantColors.blueColor,
          index: 1,
          title: "Premium",
          description: "Demo description",
          price: 10,
          features: []),
      PaymentPlan(
          themeColor: KConstantColors.greyColor,
          index: 2,
          title: "Enterprise",
          description: "Demo description",
          price: 100,
          features: []),
    ];

    paymentBlock({required PaymentPlan paymentPlan}) {
      bool isSelectedBlock =
          paymentPlanNotifier(renderUI: true).selectedPaymentPlanIndex ==
              paymentPlan.index;

      return GestureDetector(
        onTap: () {
          paymentPlanNotifier(renderUI: false)
              .setPaymentPlanIndex(value: paymentPlan.index);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  Text(paymentPlan.title,
                      style: KConstantTextstyles.bold(fontSize: 12)),
                  Text("${paymentPlan.price.toInt().toString()}\$",
                      style: KConstantTextstyles.bold(fontSize: 30)),
                  Text(paymentPlan.description,
                      style: KConstantTextstyles.light(fontSize: 12)),
                  SizedBox(height: 10),
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: isSelectedBlock ? KConstantColors.bgColorFaint : null,
                border: Border.all(
                    color: isSelectedBlock
                        ? KConstantColors.blueColor
                        : KConstantColors.greyColor),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      );
    }

    bool isVerticalMode = paymentPlanNotifier(renderUI: true).isVerticalMode;

    return Scaffold(
      appBar: CustomAppBar(title: "Flutter Payment Mode"),
      backgroundColor: KConstantColors.bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                paymentPlanNotifier(renderUI: false).toggleVericalMode();
              },
              icon: Icon(
                  isVerticalMode ? Icons.rotate_right : Icons.rotate_left,
                  color: KConstantColors.whiteColor)),
          SizedBox(height: 20),
          SizedBox(
            height: isVerticalMode ? 400 : 200,
            width: 500,
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection:
                    isVerticalMode ? Axis.vertical : Axis.horizontal,
                itemCount: paymentPlans.length,
                itemBuilder: (BuildContext context, int index) {
                  return paymentBlock(paymentPlan: paymentPlans[index]);
                },
              ),
            ),
          ),
          SizedBox(height: 40),
          Container(
            width: 200,
            height: 50,
            child: Center(
                child: Text("Continue",
                    style: KConstantTextstyles.light(fontSize: 12))),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  KConstantColors.blueColor,
                  KConstantColors.purpleColor
                ]),
                borderRadius: BorderRadius.circular(12)),
          )
        ],
      ),
    );
  }
}
