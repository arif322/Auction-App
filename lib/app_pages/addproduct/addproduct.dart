import 'package:auction_system_app/color/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  final _products;

  AddProductPage(this._products);
  // const AddProductPage({Key? key,required this._products}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _user = FirebaseAuth.instance.currentUser;

  final _firestoreInstance = FirebaseFirestore.instance;
  List bids = [];

  final ipriceController = TextEditingController();

  Future addBid() async {
    final bid = await FirebaseFirestore.instance
        .collection("Item")
        .doc(widget._products['documentId'])
        .collection("Bid")
        .add({
      "price ": ipriceController.text,
      "userMail": _user!.email,
      "userPhoto": _user!.photoURL,
      "userName": _user!.displayName
    });

    print("data added");
  }

  fetchBids() async {
    QuerySnapshot qn = await _firestoreInstance
        .collection("Items")
        .doc(widget._products['documentId'])
        .collection("Bid")
        .get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        bids.add({
          "documentId": qn.docs[i].id,
          "userEMail": qn.docs[i]["userEmail"],
          "price": qn.docs[i]["price"],
          "userPhoto": qn.docs[i]["userName"],
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchBids();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(right: 12, left: 12, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 2,
              child: Image.network(
                widget._products['imageURL'],
                fit: BoxFit.fitWidth,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget._products['title'],
              style: const TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              widget._products['description'],
              style: const TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Bid End :" "10-03-2022",
              style: TextStyle(
                  color: textColor, fontSize: 10, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "Min :" "${widget._products['price'].toString()}" 'tk',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15, color: textColor),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
              maxLines: 1,
              minLines: 1,
              style: const TextStyle(
                color: textColor,
              ),
              controller: ipriceController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "please Enter Your Amount";
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                  hintText: "Enter amount",
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: textColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: iconColor,
                        width: 0.0,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            const SizedBox(
              height: 6,
            ),
            Center(
              child: SizedBox(
                width: 250,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    addBid().then((value) =>
                        {print("Bid Add"), ipriceController.clear()});
                  },
                  child: const Text(
                    "Bid",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: buttonColor,
                    elevation: 12,
                  ),
                ),
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 5,
            ),
            Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: bids.length,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          color: itemColor,
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "${bids[index]["userEmail"]}"),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text(
                                  "${bids[index]["price"].toString()}" "tk",
                                  style: const TextStyle(
                                      color: textColor, fontSize: 16),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    })))
          ],
        ),
      )),
    );
  }
}
