import 'package:auction_system_app/app_pages/addproduct/addproduct.dart';
import 'package:auction_system_app/color/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class Gallerypage extends StatefulWidget {
  const Gallerypage({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<Gallerypage> {
  final _firestoreInstance = FirebaseFirestore.instance;
  List item = [];

  Future fetchItems() async {
    QuerySnapshot qn = await _firestoreInstance.collection("Items").get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        item.add({
          "documentsId": qn.docs[i].id,
          "userEmail": qn.docs[i]["userEmail"],
          "title": qn.docs[i]["title"],
          "price": qn.docs[i]["price"],
          "imageURL": qn.docs[i]["imageURL"],
          "description": qn.docs[i]["description"],
          "quantity": qn.docs[i]["quantity"]
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: item.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          mainAxisExtent: 220,
          // crossAxisSpacing: 2,
          // mainAxisSpacing: 2
        ),
        itemBuilder: (_, index) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Card(
                clipBehavior: Clip.antiAlias,
                color: itemColor,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => AddProductPage(item[index])));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 2,
                        child: Image.network(
                          "${item[index]['imageURL'].toString()}",
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "${item[index]["title"]}",
                          style: TextStyle(
                              color: textColor.withOpacity(1),
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Min Bid :"
                          "${item[index]["price"].toString()}"
                          "Tk",
                          style: const TextStyle(
                              color: textColor,
                              fontSize: 13,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          "Quantity :"
                          "${item[index]["quantity"].toString()}",
                          style: TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 13),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "End Bid :" "10-03-2022",
                          style: TextStyle(
                              color: textColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
