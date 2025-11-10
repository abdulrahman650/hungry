import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../core/constant/app_colors.dart';
class CustomTextfeild extends StatefulWidget {
const CustomTextfeild({
  super.key, required this.hint,
  required this.isPassword,
  required this.controller,});

   final String hint;
   final bool isPassword;
final TextEditingController controller;

  @override
  State<CustomTextfeild> createState() => _CustomTextfeildState();
}

class _CustomTextfeildState extends State<CustomTextfeild> {

late bool _obscureText;

@override
void initState() {
  _obscureText = widget.isPassword;

  super.initState();
}

void _togelePassword(){
  setState(() {
    _obscureText = !_obscureText;
  });
}

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      controller: widget.controller,
      cursorHeight: 20,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),),
        hintText: widget.hint,
        hintStyle: TextStyle(
          color:AppColors.primary,
        ),
        suffixIcon:
        widget.isPassword ? GestureDetector(
            onTap: _togelePassword,
            child: Icon(CupertinoIcons.eye,color: Colors.white,)): null,
        fillColor: Colors.white,
        filled: true,

      ),
      validator: (v){
        if(v==null || v.isEmpty){
          return'please fill${widget.hint}';
        }
        return null;
      },
      obscureText: _obscureText,
    );
  }
}
