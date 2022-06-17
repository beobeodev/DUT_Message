import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/core/theme/text_styles.dart';

class RoundedTextFormField extends StatelessWidget {
  final TextEditingController? textController;

  final bool isObscure;
  final bool readOnly;

  final String? hintText;
  final String? errorText;

  final double borderRadius;

  final Color borderColor;
  final Color fillColor;

  final Widget? suffixIcon;
  final Widget? prefixIcon;

  final TextInputType? keyboardType;

  final String? Function(String?)? validator;
  final void Function()? onTap;
  final void Function(String)? onChanged;

  const RoundedTextFormField({
    Key? key,
    this.textController,
    this.isObscure = false,
    this.readOnly = false,
    this.hintText,
    this.errorText,
    this.borderRadius = 6,
    this.borderColor = Palette.blue200,
    this.fillColor = Colors.white,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardType,
    this.validator,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // focusNode: focusNode,
      controller: textController,
      textInputAction: TextInputAction.done,
      onChanged: onChanged,
      onTap: onTap,
      validator: validator,
      obscureText: isObscure,
      readOnly: readOnly,
      keyboardType: keyboardType,
      style: const TextStyle(
        fontFamily: FontFamily.fontNunito,
        color: Palette.zodiacBlue,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: FontFamily.fontNunito,
          color: Palette.gray300,
          fontSize: 14,
        ),
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

        // errorStyle: ,
        fillColor: fillColor,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        errorText: errorText == '' || errorText == null ? null : errorText,
        errorStyle: TextStyles.mediumRegularText.copyWith(color: Colors.red),
      ),
    );
  }
}
