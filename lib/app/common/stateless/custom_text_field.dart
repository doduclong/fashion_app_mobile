import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
        this.labelText,
        this.hintText,
        this.initialValue,
        this.controller,
        this.prefixIcon,
        this.suffixIcon,
        this.readOnly,
        this.keyboardType,
        this.minLines,
        this.maxLines,
        this.inputFormatters,
        this.obscureText})
      : super(key: key);

  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? readOnly;
  final TextInputType? keyboardType;
  final int? minLines;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      obscureText: obscureText ?? false,
      keyboardType: keyboardType,
      minLines: minLines,
      maxLines: maxLines,
      readOnly: readOnly ?? false,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Color(0xFFA8A8A8),
        ),

        ///Đặt icon bên trái
        prefixIcon: prefixIcon,

        ///Đặt icon bên phải
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 17, vertical: 22),
        border: const OutlineInputBorder(
          //borderSide: BorderSide(color: Color(0xFFD0D0D0)),
          borderSide: BorderSide(color: Color(0xFFD0D0D0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD0D0D0)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFD0D0D0)),
          borderRadius: BorderRadius.all(Radius.circular(10)),

        ),
      ),
    );
  }
}