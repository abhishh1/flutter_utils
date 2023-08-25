import 'package:flutter/material.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';
import 'package:ig_posts/utils/custom_buttons.dart';
import 'package:ig_posts/utils/custom_textfield.dart';
import 'package:ig_posts/utils/dimensions.dart';
import 'package:ig_posts/utils/font_size.widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../utils/text_styles.dart';

class Poll {
  final String title;
  final String descripton;
  final List<PollOption> options;

  const Poll({
    required this.title,
    required this.descripton,
    required this.options,
  });
}

class PollOption {
  final int index;
  final String title;
  final int votes;

  const PollOption(
      {required this.index, required this.votes, required this.title});
}

class PollBarNotifier extends ChangeNotifier {
  bool isVoted = false;

  Poll? createdPoll;

  void createPoll({required Poll pollData}) {
    createdPoll = pollData;
    notifyListeners();
  }

  int? userSelectedOption;

  void setUserOptionSelection({required int value}) {
    userSelectedOption = value;
    notifyListeners();
  }

  void clearPollData() {
    createdPoll = null;
    userSelectedOption = null;
    notifyListeners();
  }
}

class FlutterPollBarView extends StatelessWidget {
  const FlutterPollBarView({super.key});

  @override
  Widget build(BuildContext context) {
    PollBarNotifier pollBarNotifier({required bool renderUI}) =>
        Provider.of<PollBarNotifier>(context, listen: renderUI);

    Poll? createdPoll = pollBarNotifier(renderUI: true).createdPoll;

    _createPollButton() {
      return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CreatePollView()));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 8.h,
            child: Center(
                child: Text("Create Poll 🚀",
                    style: KConstantTextstyles.bold(fontSize: 20))),
            decoration: BoxDecoration(
                color: KConstantColors.blueColor,
                borderRadius: BorderRadius.circular(25)),
          ),
        ),
      );
    }

    showPollBlock() {
      return createdPoll != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: 100.w,
                      height: 28.h,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            vSizedBox1,
                            Row(
                              children: [
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    pollBarNotifier(renderUI: false)
                                        .clearPollData();
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: KConstantColors.redColor,
                                      radius: 12,
                                      child: Icon(Icons.remove, size: 12)),
                                ),
                                hSizedBox2
                              ],
                            ),
                            Text(createdPoll.title,
                                style: KCustomTextStyle.kBold(
                                    context, FontSize.kReguler)),
                            Text(createdPoll.descripton,
                                style: KCustomTextStyle.kMedium(
                                    context, FontSize.kMedium)),
                            vSizedBox2,
                            MediaQuery.removePadding(
                              context: context,
                              removeBottom: true,
                              removeTop: true,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: createdPoll.options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  PollOption pollOption =
                                      createdPoll.options[index];

                                  bool isSelected =
                                      pollBarNotifier(renderUI: true)
                                              .userSelectedOption ==
                                          pollOption.index;

                                  return GestureDetector(
                                    onTap: () {
                                      pollBarNotifier(renderUI: false)
                                          .setUserOptionSelection(
                                              value: pollOption.index);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 5.h,
                                        child: Center(
                                            child: Text(pollOption.title,
                                                style:
                                                    KConstantTextstyles.light(
                                                        fontSize: 12))),
                                        decoration: BoxDecoration(
                                            color: isSelected
                                                ? KConstantColors.blueColor
                                                : KConstantColors.bgColor,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: KConstantColors.bgColorFaint,
                          borderRadius: BorderRadius.circular(12))),
                ),
                vSizedBox2,
                if (pollBarNotifier(renderUI: true).userSelectedOption != null)
                  CustomRoundedButton(
                      backgroundColor: KConstantColors.bgColorFaint,
                      onTap: () {},
                      label: "Vote")
              ],
            )
          : _createPollButton();
    }

    return Scaffold(
      backgroundColor: KConstantColors.bgColor,
      appBar: CustomAppBar(
          color: KConstantColors.bgColor, title: "Flutter Poll Bar"),
      body: Center(child: showPollBlock()),
    );
  }
}

class CreatePollView extends StatefulWidget {
  const CreatePollView({super.key});

  @override
  State<CreatePollView> createState() => _CreatePollViewState();
}

class _CreatePollViewState extends State<CreatePollView> {
  final TextEditingController pollTitleController = TextEditingController();
  final TextEditingController pollDescriptionController =
      TextEditingController();
  final TextEditingController pollAnswer1Controller = TextEditingController();
  final TextEditingController pollAnswer2Controller = TextEditingController();

  PollBarNotifier pollBarNotifier({required bool renderUI}) =>
      Provider.of<PollBarNotifier>(context, listen: renderUI);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: KConstantColors.bgColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              vSizedBox3,
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios,
                      color: KConstantColors.whiteColor)),
              Text("Create Poll",
                  style: KCustomTextStyle.kBold(context, FontSize.header)),
              vSizedBox1,
              CustomStylishTextField(
                  hintTextColor: KConstantColors.greyColor,
                  hintText: "Title",
                  textEditingController: pollTitleController),
              vSizedBox2,
              CustomStylishTextField(
                  minLines: 3,
                  maxLines: 5,
                  hintTextColor: KConstantColors.greyColor,
                  hintText: "Description",
                  textEditingController: pollDescriptionController),
              vSizedBox2,
              CustomTextField(
                  hintText: "Option 1",
                  onChanged: (val) {},
                  textEditingController: pollAnswer1Controller),
              vSizedBox0,
              CustomTextField(
                  hintText: "Option 2",
                  onChanged: (val) {},
                  textEditingController: pollAnswer2Controller),
              vSizedBox2,
              Center(
                  child: CustomRoundedButton(
                      onTap: () {
                        pollBarNotifier(renderUI: false).createPoll(
                            pollData: Poll(
                                title: pollTitleController.text,
                                descripton: pollDescriptionController.text,
                                options: [
                              PollOption(
                                  index: 0,
                                  votes: 0,
                                  title: pollAnswer1Controller.text),
                              PollOption(
                                  index: 1,
                                  votes: 0,
                                  title: pollAnswer2Controller.text),
                            ]));
                        Navigator.pop(context);
                      },
                      label: "Create"))
            ],
          ),
        ));
  }
}
