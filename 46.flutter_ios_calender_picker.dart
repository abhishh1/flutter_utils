import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CalenderNotifier extends ChangeNotifier {
  DateTime? pickedDate = DateTime.now();

  void setPickedDate({required DateTime dateTime}) {
    pickedDate = dateTime;
    notifyListeners();
  }
}

class FlutteCalenderPickerView extends StatelessWidget {
  const FlutteCalenderPickerView({super.key});

  @override
  Widget build(BuildContext context) {
    CalenderNotifier calenderNotifier({required bool renderUI}) =>
        Provider.of<CalenderNotifier>(context, listen: renderUI);

    String renderValue() {
      var format = DateFormat.yMd();
      var dateString =
          format.format(calenderNotifier(renderUI: true).pickedDate!);
      return dateString;
    }

    return Scaffold(
        backgroundColor: KConstantColors.bgColor,
        appBar: CustomAppBar(title: "Flutter Calender Picker"),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Flutter 3 IOS date picker",
                  style: KConstantTextstyles.bold(fontSize: 32)),
              SizedBox(height: 20),
              SizedBox(
                  height: 200,
                  width: 400,
                  child: CupertinoTheme(
                      data: CupertinoThemeData(
                        textTheme: CupertinoTextThemeData(
                            dateTimePickerTextStyle: TextStyle(
                                color: KConstantColors.whiteColor,
                                fontSize: 16)),
                      ),
                      child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (val) {
                          debugPrint(val.toString());
                          calenderNotifier(renderUI: false)
                              .setPickedDate(dateTime: val);
                        },
                      ))),
              SizedBox(height: 50),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(renderValue(),
                      style: KConstantTextstyles.bold(fontSize: 32)),
                ),
                decoration: BoxDecoration(
                    color: KConstantColors.bgColorFaint,
                    borderRadius: BorderRadius.circular(12)),
              )
            ]));
  }
}
