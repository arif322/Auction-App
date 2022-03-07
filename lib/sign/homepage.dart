import 'package:auction_system_app/app_pages/analytics/analytics.dart';
import 'package:auction_system_app/app_pages/deshboard/desboard.dart';
import 'package:auction_system_app/app_pages/gallery/gallerypage.dart';
import 'package:auction_system_app/app_pages/productform/addproductform.dart';
import 'package:auction_system_app/app_pages/profile/profile.dart';
import 'package:auction_system_app/color/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePage> {
  var currentIndex = 0;
  final pages = [
    const Gallerypage(),
    const DesboardPage(),
    const AddProductForm(),
    const AnalyticsPage(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 4,
        title: const Image(image: AssetImage("Images/ebay.png")),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Gallery",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Dashboard",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.add),
              backgroundColor: primaryColor,
              label: "Post"),
          BottomNavigationBarItem(
              icon: Icon(Icons.analytics),
              label: "Analytics",
              backgroundColor: primaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: "Profile",
              backgroundColor: primaryColor)
        ],
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: pages[currentIndex],
    );
  }
}
