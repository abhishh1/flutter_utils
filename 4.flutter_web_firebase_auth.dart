import 'package:awesome_widgets/awesome_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_utils/utils/colors.dart';


/*

1. Create a firebase app with web mode. Copy the credentials.

2. ADD THIS SCRIPT ABOVE flutter_service_worker script in index.html file
    <script src="https://www.gstatic.com/firebasejs/7.20.0/firebase-app.js"></script>
    <!-- Firebase Auth SDK -->
    <script src="https://www.gstatic.com/firebasejs/7.20.0/firebase-auth.js"></script>
    <script>
      // Your web app's Firebase configuration
      var firebaseConfig = {
      apiKey: "",
      authDomain: "",
      projectId: "",
      storageBucket: "",
      messagingSenderId: "",
      appId: ""
      }
      firebase.initializeApp(firebaseConfig)
  </script>
*/

class FirebaseWebAuthentication extends StatelessWidget {
  const FirebaseWebAuthentication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    showRes({required String title}) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              actions: [
                AwesomeButton.roundedIconButton(
                    height: 30,
                    width: 50,
                    backgroundColor: KConstantColors.blueColor,
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: "Okay")
              ],
              backgroundColor: KConstantColors.bgColorFaint,
              title: Text(
                title,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins-B"),
              ),
            );
          });
    }

    Future login() async {
      try {
        if (emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty) {
          final credential = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passwordController.text);
          showRes(title: "${credential.user!.email} logged in!");
        } else {
          showRes(title: "Enter credentials");
          // showError(title: "Enter credentials");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          showRes(title: "User not found!");
        } else if (e.code == 'wrong-password') {
          showRes(title: "Wrong password");
        }
      } catch (e) {
        showRes(title: e.toString());
      }
    }

    Future signup() async {
      try {
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        showRes(title: "${credential.user!.email} created new account!");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showRes(title: "Use different password, Its weak one");
        } else if (e.code == 'email-already-in-use') {
          showRes(title: "The account already exists for that email");
        }
      } catch (e) {
        showRes(title: e.toString());
      }
    }

    return Scaffold(
        backgroundColor: KConstantColors.bgColor,
        body: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Flutter Firebase\n Web Authentication",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins-B"),
            ),
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                  decoration:
                      const BoxDecoration(color: Colors.deepOrangeAccent),
                  height: 250,
                  child: Image.asset("assets/images/onboard.png")),
            ),
            const SizedBox(height: 20),
            AwesomeTextfield.filled(
                height: 60,
                fillColor: KConstantColors.bgColorFaint,
                titleTextstyle:
                    const TextStyle(fontSize: 12, fontFamily: "Poppins-M"),
                hintText: "Enter email address",
                textEditingController: emailController),
            AwesomeTextfield.filled(
                height: 60,
                titleTextstyle:
                    const TextStyle(fontSize: 12, fontFamily: "Poppins-M"),
                fillColor: KConstantColors.bgColorFaint,
                hintText: "Enter password",
                textEditingController: passwordController),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AwesomeButton.roundedIconButton(
                    titleTextstyle:
                        const TextStyle(fontSize: 12, fontFamily: "Poppins-M"),
                    height: 30,
                    width: 100,
                    backgroundColor: Colors.deepOrangeAccent,
                    onTap: login,
                    title: "Login"),
                const SizedBox(width: 100),
                AwesomeButton.roundedIconButton(
                    titleTextstyle:
                        const TextStyle(fontSize: 12, fontFamily: "Poppins-M"),
                    height: 30,
                    width: 100,
                    backgroundColor: Colors.deepOrangeAccent,
                    onTap: signup,
                    title: "Signup"),
              ],
            )
          ],
        ));
  }
}
