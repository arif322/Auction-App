import 'package:auction_system_app/color/colors.dart';
import 'package:flutter/material.dart';

class TextflieldPage extends StatelessWidget {
  final TextEditingController controller;
  final Color? colors;
  final Color? cOlors;
  final bool textType;
  final bool textinput;
  final Function(String)? onTap;
  final String? text;

  final String? hint;

  const TextflieldPage({
    Key? key,
    required this.controller,
    this.cOlors,
    this.colors,
    required this.textType,
    required this.textinput,
    this.onTap,
    this.text,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 5,
      minLines: 2,
      cursorColor: colors,
      style: TextStyle(color: cOlors),
      controller: controller,
      keyboardType: textType ? TextInputType.text : TextInputType.number,
      textInputAction: textinput ? TextInputAction.next : TextInputAction.done,
      onChanged: onTap,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return text;
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 18,
          color: cOlors,
        ),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: primaryColor,
              width: 0.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            )),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
    );
  }
}
