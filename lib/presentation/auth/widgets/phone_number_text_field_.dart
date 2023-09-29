import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:twitter/utils/colors/app_colors.dart';

class PhoneTextField extends StatefulWidget {
  PhoneTextField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.textInputAction,required this.prefixIcon,
    required this.textAlign,
    this.isPassword = false,
    required this.focusNode,
    this.obscureText = false,
    required this.maskFormaters,
    this.maxLine = 1,
    required this.onChanged,
  }) : super(key: key);

  final String hintText;
  final MaskTextInputFormatter maskFormaters;
   bool isPassword;
  final IconData prefixIcon;
  final FocusNode focusNode;
final  TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final bool obscureText;
  final ValueChanged onChanged;
  final int maxLine;

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {

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
      onChanged: widget.onChanged,
      inputFormatters: [widget.maskFormaters],
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      obscureText: widget.keyboardType == TextInputType.visiblePassword
          ? !widget.isPassword
          : false,
      decoration: InputDecoration(
        prefixIcon: Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: 80,
            child: Row(
              children: [
                Icon(widget.prefixIcon, color: Colors.grey,),
                SizedBox(width: 8,),
                const Text("+998",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                    fontFamily: "DMSans"),),
              ],
            ),
          ),
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
