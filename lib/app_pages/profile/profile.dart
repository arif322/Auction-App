import 'package:auction_system_app/color/colors.dart';
import 'package:auction_system_app/sign/signin.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late bool _signout = false;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(),
            const Text(
              "Hello",
              style: TextStyle(
                  color: textColor, fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(
              height: 6,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "you are signed in using Email.",
              style: TextStyle(
                color: textColor,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            _signout
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  )
                : ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.blueAccent,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signOut();

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SignInPage()));
                      } catch (e) {
                        print("sign out");
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        "Sign out",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}
