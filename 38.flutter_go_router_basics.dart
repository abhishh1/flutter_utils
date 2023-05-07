import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ig_posts/season_2/63.transperant_design_pattern.dart';
import 'package:ig_posts/utils/colors.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeView();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details_1',
          builder: (BuildContext context, GoRouterState state) {
            return const Detail1View();
          },
        ),
        GoRoute(
          path: 'details_2',
          builder: (BuildContext context, GoRouterState state) {
            return const Detail2View();
          },
        ),
      ],
    ),
  ],
);

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Flutter Go Router"),
      floatingActionButton: ActionChip(
          onPressed: () {
            context.go("/details_1");
          },
          backgroundColor: KConstantColors.bgColorFaint,
          label: Text("Go tot detail 1",
              style: KConstantTextstyles.light(fontSize: 12))),
      backgroundColor: KConstantColors.bgColor,
      body: Center(
          child:
              Text("Home View", style: KConstantTextstyles.bold(fontSize: 30))),
    );
  }
}

class Detail1View extends StatelessWidget {
  const Detail1View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Flutter Go Router"),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ActionChip(
              onPressed: () {
                context.go("/details_2");
              },
              backgroundColor: KConstantColors.redColor,
              label: Text("Go tot detail 2",
                  style: KConstantTextstyles.light(fontSize: 12))),
          SizedBox(height: 10),
          ActionChip(
              onPressed: () {
                context.go("/");
              },
              backgroundColor: KConstantColors.redColor,
              label: Text("Go to home",
                  style: KConstantTextstyles.light(fontSize: 12))),
        ],
      ),
      backgroundColor: KConstantColors.bgColor,
      body: Center(
          child: Text("Detail 1 View",
              style: KConstantTextstyles.bold(fontSize: 30))),
    );
  }
}

class Detail2View extends StatelessWidget {
  const Detail2View({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Flutter Go Router"),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ActionChip(
              onPressed: () {
                context.go("/details_1");
              },
              backgroundColor: KConstantColors.redColor,
              label: Text("Go tot detail 1",
                  style: KConstantTextstyles.light(fontSize: 12))),
          SizedBox(height: 10),
          ActionChip(
              onPressed: () {
                context.go("/");
              },
              backgroundColor: KConstantColors.redColor,
              label: Text("Go to home",
                  style: KConstantTextstyles.light(fontSize: 12))),
        ],
      ),
      backgroundColor: KConstantColors.blueColor,
      body: Center(
          child: Text("Detail 2 View",
              style: KConstantTextstyles.bold(fontSize: 30))),
    );
  }
}
