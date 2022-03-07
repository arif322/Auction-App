import 'package:auction_system_app/pages/textpage.dart';
import 'package:auction_system_app/sign/homepage.dart';
import 'package:auction_system_app/sign/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white70.withOpacity(0.3),
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: Column(
                    children: [
                      const Text(
                        "Create your account",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextPage(
                              controller: emailController,
                              textType: true,
                              obscure: false,
                              pre: const Icon(Icons.person),
                              suff: const Icon(Icons.email),
                              hint: "Email",
                            ),
                            TextPage(
                                controller: passwordController,
                                textType: false,
                                obscure: true,
                                pre: const Icon(Icons.lock),
                                suff: const Icon(Icons.remove_red_eye),
                                hint: "Confirm Password")
                          ]
                              .map((e) => Padding(
                                  child: e,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 15)))
                              .toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: Colors.cyan.withOpacity(0.5),
                            blurRadius: 15,
                            offset: const Offset(0, 3),
                          )
                        ]),
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
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
                            "Create Account",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Do you have an Account ?",
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignInPage()));
                                },
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
