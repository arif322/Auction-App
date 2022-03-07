import 'package:flutter/material.dart';

class GesturePage extends StatelessWidget {
  final ImageProvider images;

  final Function onTap;
  const GesturePage({Key? key, required this.images, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: Colors.black45, offset: Offset(0, 3), blurRadius: 15),
        ],
        image: DecorationImage(
          image: images,
        ),
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: GestureDetector(
        onTap: () {},
      ),
    );
  }
}
