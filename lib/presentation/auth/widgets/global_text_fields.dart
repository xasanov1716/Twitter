import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twitter/utils/colors/app_colors.dart';

class GlobalTextField extends StatefulWidget {
  GlobalTextField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,required this.prefixIcon,
    required this.textAlign,
    this.isPassword = false,
    this.obscureText = false,
    this.maxLine = 1,
    required this.onChanged,
  }) : super(key: key);

  final String hintText;
   bool isPassword;
  final IconData prefixIcon;
 final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final bool obscureText;
  final ValueChanged onChanged;
  final int maxLine;

  @override
  State<GlobalTextField> createState() => _GlobalTextFieldState();
}

class _GlobalTextFieldState extends State<GlobalTextField> {


  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Color(0xFF4F8962),
      maxLines: widget.maxLine,
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
          fontFamily: "DMSans"),
      textAlign: widget.textAlign,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      obscureText: widget.keyboardType == TextInputType.visiblePassword
          ? !widget.isPassword
          : false,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.prefixIcon,
          color: Colors.grey,
        ),
        suffixIcon: widget.keyboardType == TextInputType.visiblePassword
            ? IconButton(
          splashRadius: 1,
          icon: Icon(
            widget.isPassword
                ? Icons.visibility
                : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            setState(() {
              widget.isPassword = !widget.isPassword;
            });
          },
        )
            : null,
        filled: true,
        fillColor: AppColors.c_0C1A30,
        hintText: widget.hintText,
        hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
            fontFamily: "DMSans"),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
