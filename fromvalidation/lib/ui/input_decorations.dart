import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    required Icon prefixIcon,
  }) {
    return InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        ),
      ),
      hintText: '$hintText',
      labelText: '$labelText',
      labelStyle: TextStyle(color: Colors.grey),
      prefixIcon: prefixIcon,
    );
  }
}
