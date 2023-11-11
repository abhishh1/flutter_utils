import 'package:awesome_widgets/awesome_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

// [Get the above packages 🚀]

class ItemViewer3D extends StatelessWidget {
  const ItemViewer3D({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: ((context, orientation, deviceType) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SafeArea(
              child: Scaffold(
                backgroundColor: KConstantColors.bgColor,
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 400,
                      child: ModelViewer(
                        src:
                            'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
                        alt: "A 3D model of an astronaut",
                        ar: true,
                        autoRotate: true,
                        cameraControls: true,
                      ),
                    ),
                    Text("Astronaut suit",
                        style: KCustomTextStyle.kBold(context, 32)),
                    Text(
                        "This is one suit made specially for all the space enthusiasts. The special power includes surviving in the giant space!",
                        style: KCustomTextStyle.kMedium(
                            context, 11, KConstantColors.textColor)),
                    Row(
                      children: [
                        Text("\$2000",
                            style: KCustomTextStyle.kBold(context, 30)),
                        const Spacer(),
                        AwesomeButton.iconButton(
                            height: 30,
                            width: 30,
                            onTap: () {},
                            icon: const Icon(FontAwesomeIcons.heart,
                                size: 15, color: KConstantColors.whiteColor)),
                        hSizedBox2,
                        AwesomeButton.iconButton(
                            height: 30,
                            width: 30,
                            onTap: () {},
                            icon: const Icon(FontAwesomeIcons.bookmark,
                                size: 15, color: KConstantColors.whiteColor)),
                        hSizedBox2
                      ],
                    ),
                    vSizedBox2,
                    AwesomeButton.roundedIconButton(
                        titleTextstyle: KCustomTextStyle.kBold(context, 12),
                        onTap: () {},
                        title: "Buy now"),
                    vSizedBox1,
                    Center(
                      child: AwesomeButton.roundedIconButton(
                          backgroundColor: KConstantColors.dimDark,
                          titleTextstyle: KCustomTextStyle.kBold(context, 12),
                          onTap: () {},
                          title: "Add to cart"),
                    )
                  ],
                ),
              ),
            ));
      }),
    );
  }
}
