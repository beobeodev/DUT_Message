import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';

class RoundedTextFormField extends StatelessWidget {
  final TextEditingController? textController;
  final String? Function(String?)? validator;
  final bool isObscure;
  final String? hintText;
  final String? errorText;
  final double borderRadius;
  final Color borderColor;
  final Widget? suffixIconWidget;
  final Widget? prefixIconWidget;
  final TextInputType? keyboardType;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  const RoundedTextFormField({
    Key? key,
    this.textController,
    this.validator,
    this.isObscure = false,
    this.hintText,
    this.errorText,
    this.borderRadius = 6,
    this.borderColor = Palette.blue200,
    this.suffixIconWidget,
    this.prefixIconWidget,
    this.keyboardType,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      textInputAction: TextInputAction.done,
      onChanged: onChanged,
      onTap: onTap,
      validator: validator,
      obscureText: isObscure,
      keyboardType: keyboardType,
      style: const TextStyle(
        fontFamily: FontFamily.fontNunito,
        color: Palette.zodiacBlue,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: borderColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
        hintStyle: const TextStyle(
          fontFamily: FontFamily.fontNunito,
          color: Palette.gray300,
          fontSize: 14,
        ),
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        suffixIcon: suffixIconWidget,
        prefixIcon: prefixIconWidget,
        errorText: errorText == '' || errorText == null ? null : errorText,
      ),
    );
  }
}
