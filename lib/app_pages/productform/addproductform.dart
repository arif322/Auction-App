import 'package:auction_system_app/color/colors.dart';
import 'package:auction_system_app/components/decoration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({Key? key}) : super(key: key);

  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final _user = FirebaseAuth.instance.currentUser;
  final _keyform = GlobalKey<FormState>();
  var AB;

  final itemTitleController = TextEditingController();
  final itemDetailsController = TextEditingController();
  final itemPriceController = TextEditingController();
  final itemQuantityController = TextEditingController();
  final imageURL = "https://picsum.photos/200";

  Future addPro() async {
    final db = await FirebaseFirestore.instance.collection("Items").add({
      "title": itemTitleController.text,
      "price": itemPriceController.text,
      "quantity": itemQuantityController.text,
      "description": itemDetailsController.text,
      "imageURL": imageURL,
      "userEmail": _user!.email,
    });
    print("data added");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Padding(
          padding:
              const EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 10),
          child: Form(
            key: _keyform,
            child: ListView(
              children: [
                Container(
                  child: const InkWell(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          NetworkImage("https://picsum.photos/200"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextflieldPage(
                    controller: itemTitleController,
                    colors: primaryColor,
                    textType: true,
                    onTap: (value) {
                      AB = value;
                    },
                    textinput: true,
                    cOlors: textColor,
                    text: "please enter item Title",
                    hint: "Enter Items Description "),
                const SizedBox(
                  height: 10,
                ),
                TextflieldPage(
                  controller: itemPriceController,
                  textType: false,
                  textinput: true,
                  colors: primaryColor,
                  text: "please enter ite,m price",
                  hint: "Please enter minimum price",
                ),
                const SizedBox(
                  height: 10,
                ),
                TextflieldPage(
                  controller: itemQuantityController,
                  colors: primaryColor,
                  textType: false,
                  textinput: false,
                  text: "please enter Quantity of Product",
                  hint: "Enter Quantity",
                ),
                const SizedBox(
                  height: 10,
                ),
                TextflieldPage(
                  controller: itemDetailsController,
                  colors: primaryColor,
                  textType: false,
                  textinput: true,
                  text: "Enter Description",
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: primaryColor,
                      side: const BorderSide(width: 3, color: Colors.red),
                      elevation: 5,
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      )),
                  onPressed: () {
                    final valided = _keyform.currentState!.validate();
                    if (valided == true) {
                      print("Input Something");
                    } else {
                      addPro().then((value) => {
                            itemTitleController.clear(),
                            itemPriceController.clear(),
                            itemQuantityController.clear(),
                            itemDetailsController.clear()
                          });
                    }
                    _keyform.currentState!.save();
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
