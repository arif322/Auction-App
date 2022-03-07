import 'package:auction_system_app/pages/Gesturepage.dart';
import 'package:auction_system_app/pages/textpage.dart';
import 'package:auction_system_app/sign/homepage.dart';
import 'package:auction_system_app/sign/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white30.withOpacity(0.5),
            child: Column(
              children: [
                Container(
                  child: Center(
                    child: Lottie.asset("Images/login.json",
                        width: 200, height: 280),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  "Welcome to Auction App",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.black54),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                const Text(
                  "Please Login Your Auction",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      TextPage(
                        controller: emailController,
                        textType: true,
                        obscure: false,
                        suff: const Icon(Icons.email),
                        pre: const Icon(Icons.person),
                        hint: "Email",
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      TextPage(
                        controller: passwordController,
                        textType: false,
                        obscure: true,
                        pre: const Icon(Icons.lock),
                        suff: const Icon(Icons.remove_red_eye),
                        hint: "Password",
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.cyan.withOpacity(0.5),
                      blurRadius: 15,
                      offset: const Offset(0, 3),
                    ),
                  ]),
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        print(userCredential.user);
                        if (userCredential.user?.email != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HomePage()));
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.cyan.withOpacity(0.5),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GesturePage(
                      images: const AssetImage("Images/facebook.jpg"),
                      onTap: () {},
                    ),
                    GesturePage(
                      images: const AssetImage("Images/google.jpg"),
                      onTap: () {},
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account ?",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupPage()));
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
