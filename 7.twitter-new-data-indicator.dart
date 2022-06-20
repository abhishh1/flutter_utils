class NewDataIndicatorNotifier extends ChangeNotifier {
  bool _receivedNewData = false;
  bool get receivedNewData => _receivedNewData;

  List<String> baseData = [
    "Lorem Ipsum ",
    "is simply dummy",
    "text of the printing",
    "and typesetting industry",
    "when an unknown printer",
    "type specimen book"
  ];

  List<String> tempDataList = [];
  void fillTempList({required String data}) {
    tempDataList.add(data);
    notifyListeners();
  }

  void fillBaseList() {
    baseData.addAll(tempDataList);
    tempDataList.clear();
    notifyListeners();
  }

  setReceivedNewData() {
    _receivedNewData = true;
    notifyListeners();
  }
}

class TwitterPullToRefreshView extends StatelessWidget {
  const TwitterPullToRefreshView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    NewDataIndicatorNotifier newDataIndicatorNotifier(
            {required bool renderUI}) =>
        Provider.of<NewDataIndicatorNotifier>(context, listen: renderUI);

    List<String> data = newDataIndicatorNotifier(renderUI: true).baseData;

    bool hasNewData =
        newDataIndicatorNotifier(renderUI: true).tempDataList.isNotEmpty;

    void scrollToTop() {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }

    Widget newDataNotificationBlock() {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: AnimatedOpacity(
          curve: Curves.easeInCubic,
          duration: const Duration(milliseconds: 500),
          opacity: hasNewData ? 1 : 0,
          child: Align(
            alignment: Alignment.topCenter,
            child: CustomRoundedIconButton(
                height: 5,
                iconData: Icons.arrow_drop_down_circle,
                width: 35,
                radius: 50,
                backgroundColor: KConstantColors.blueColor,
                onTap: () {
                  scrollToTop();
                  newDataIndicatorNotifier(renderUI: false).fillBaseList();
                },
                label: "New posts"),
          ),
        ),
      );
    }

    return Sizer(builder: (context, origentation, _) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomRoundedButton(
                    width: 40,
                    backgroundColor: KConstantColors.blueColor,
                    onTap: () {
                      DateTime timeStamp = DateTime.now();
                      newDataIndicatorNotifier(renderUI: false)
                          .fillTempList(data: "New data : $timeStamp");
                    },
                    label: "Add more data"),
              ],
            ),
            appBar: AppBar(
                backgroundColor: KConstantColors.blueColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(FontAwesomeIcons.twitter),
                    hSizedBox2,
                    Text("Twitter New Data Indicator",
                        style: KCustomTextStyle.kBold(context, 16))
                  ],
                )),
            backgroundColor: KConstantColors.bgColor,
            body: Stack(
              children: [
                ListView.builder(
                  reverse: true,
                  controller: scrollController,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: KConstantColors.bgColorFaint,
                      elevation: 0.4,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                            tileColor: KConstantColors.bgColorFaint,
                            title: Text(data[index],
                                style: KCustomTextStyle.kMedium(context, 10))),
                      ),
                    );
                  },
                ),
                Positioned(child: newDataNotificationBlock())
              ],
            )),
      );
    });
  }
}
