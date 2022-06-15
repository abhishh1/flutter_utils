import 'package:awesome_widgets/awesome_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginNotifier extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();

  String attachedProvider = "";

  attachEmailProvider({required String provider}) {
    emailController.text = emailController.text + provider;
    attachedProvider = provider;
    notifyListeners();
  }

  clearTextFieldState() {
    emailController.clear();
    attachedProvider = "";
    notifyListeners();
  }
}

class DemoLoginView extends StatelessWidget {
  const DemoLoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginNotifier loginNotifier({required bool renderUI}) =>
        Provider.of<LoginNotifier>(context, listen: renderUI);

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            AwesomeTextfield.filled(
                textEditingController:
                    loginNotifier(renderUI: false).emailController,
                fillColor: Colors.grey),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ActionChipButton(
                    backgroundColor:
                        loginNotifier(renderUI: true).attachedProvider ==
                                "@yahoo.com"
                            ? Colors.blue
                            : Colors.greenAccent,
                    onTap: () {
                      loginNotifier(renderUI: false)
                          .attachEmailProvider(provider: "@yahoo.com");
                    },
                    label: "@yahoo.com"),
                ActionChipButton(
                    backgroundColor:
                        loginNotifier(renderUI: true).attachedProvider ==
                                "@hotmail.com"
                            ? Colors.blue
                            : Colors.greenAccent,
                    onTap: () {
                      loginNotifier(renderUI: false)
                          .attachEmailProvider(provider: "@hotmail.com");
                    },
                    label: "@hotmail.com"),
              ],
            ),
            if (loginNotifier(renderUI: true).attachedProvider != "")
              Align(
                alignment: Alignment.centerRight,
                child: ActionChip(
                    onPressed: () {
                      loginNotifier(renderUI: false).clearTextFieldState();
                    },
                    label: const Text("clear")),
              ),
          ],
        ),
      ),
    );
  }
}
