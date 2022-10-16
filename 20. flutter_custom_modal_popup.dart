import 'package:flutter/material.dart';
import 'package:ig_posts/features/0.abhishvek_header.dart';
import 'package:ig_posts/features/1.flutter_frost_glass.view.dart';
import 'package:ig_posts/features/5.flutter_swiggy_button.dart';

class CustomMenuModalPopupWidget extends StatefulWidget {
  const CustomMenuModalPopupWidget({super.key});

  @override
  State<CustomMenuModalPopupWidget> createState() =>
      _CustomMenuModalPopupWidgetState();
}

class _CustomMenuModalPopupWidgetState
    extends State<CustomMenuModalPopupWidget> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  showPopup({required bool isLogin}) {
    showLoginForm() {
      return Container(
        height: 500,
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(colors: [bgColor.withOpacity(0.8), bgColor]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Text("Login to continue", style: boldText(fSize: 30)),
              Text("This will ensure user data is saved to us",
                  style: regulerText),
              const SizedBox(height: 40),
              SizedBox(
                width: 400,
                height: 50,
                child: TextField(
                    controller: emailController,
                    style: regulerText,
                    decoration: InputDecoration(
                        hintText: "Email address", hintStyle: regulerText)),
              ),
              SizedBox(
                width: 400,
                height: 50,
                child: TextField(
                    controller: passwordController,
                    style: regulerText,
                    decoration: InputDecoration(
                        hintText: "Password", hintStyle: regulerText)),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                        onPressed: () {},
                        child: Text("Forget password?", style: regulerText)),
                  ),
                ],
              ),
              const SizedBox(height: 100),
              GestureDetector(
                onTap: () {
                  showPopup(isLogin: false);
                },
                child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                        child: Text("Login", style: boldText(fSize: 12)))),
              ),
            ],
          ),
        ),
      );
    }

    showWelcomeBox() {
      return Container(
        height: 450,
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(colors: [bgColor, bgColor.withOpacity(0.8)]),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close, color: Colors.white)),
                ],
              ),
              Text("Welcome!", style: boldText(fSize: 40)),
              const SizedBox(height: 30),
              Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                  textAlign: TextAlign.center,
                  style: regulerText),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showPopup(isLogin: true);
                },
                child: Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                        child: Text("Login 🚀", style: boldText(fSize: 12)))),
              ),
            ],
          ),
        ),
      );
    }

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            contentPadding: EdgeInsets.zero,
            content: isLogin ? showLoginForm() : showWelcomeBox(),
          );
        });
  }

  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 1), () {
      showPopup(isLogin: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ActionChip(
                  onPressed: () {
                    showPopup(isLogin: true);
                  },
                  label: Text("Show Login Popup", style: regulerText)),
              ActionChip(
                  onPressed: () {
                    showPopup(isLogin: false);
                  },
                  label: Text("Show Welcome box Popup", style: regulerText)),
              const SizedBox(height: 100),
              const AbhishvekHeaderWidget()
            ],
          ),
        ));
  }
}
