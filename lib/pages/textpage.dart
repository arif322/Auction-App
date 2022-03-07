import 'package:flutter/material.dart';

class TextPage extends StatelessWidget {
  final TextEditingController controller;
  final bool textType;
  final bool obscure;
  final Widget? pre;
  final Widget? suff;
  final String? hint;

  const TextPage(
      {Key? key,
      required this.controller,
      required this.textType,
      required this.obscure,
      required this.pre,
      required this.suff,
      required this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextField(
        controller: controller,
        keyboardType: textType ? TextInputType.text : TextInputType.number,
        obscureText: obscure,
        decoration: InputDecoration(
            hintText: hint,
            prefixIcon: pre,
            suffixIcon: suff,
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.5, color: Colors.white10),
              borderRadius: BorderRadius.circular(18),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 0.5, color: Colors.white10),
              borderRadius: BorderRadius.circular(18),
            )),
      ),
    );
  }
}
