import 'package:flutter/material.dart';
class CustomUserTxtfield extends StatelessWidget {
  const CustomUserTxtfield({super.key, required this.controller, required this.label, this.textInputType});
final TextEditingController controller;
final String label;
final TextInputType? textInputType;
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        keyboardType: textInputType,
        cursorColor: Colors.white,
        cursorHeight: 20,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: EdgeInsetsGeometry.symmetric(horizontal: 20),
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15),

          ),
        ));
  }
}
