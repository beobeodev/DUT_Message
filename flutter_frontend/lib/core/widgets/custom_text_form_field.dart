import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.label = '',
    this.isObsecure = false,
    required this.width,
    this.height,
    this.gap = 10,
    this.textEditingController,
    this.borderRadius = 6,
    this.hintText = '',
    this.borderColor = Palette.blue100,
    this.suffixIconWidget,
    this.prefixIconWidget,
    this.fillColor = Colors.white,
    this.errorText,
    this.validateFunc,
  });

  final String label;
  final bool isObsecure;
  final double width;
  final double? height;
  //This gap between label and text field
  final double gap;
  final TextEditingController? textEditingController;
  final double borderRadius;
  final String hintText;
  final Color borderColor;
  final Widget? suffixIconWidget;
  final Widget? prefixIconWidget;
  final Color fillColor;
  final String? errorText;
  final String? Function(String? value)? validateFunc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (label == '')
          Text(
            label,
            style: const TextStyle(
              fontFamily: FontFamily.fontPoppins,
            ),
          ),
        if (label == '')
          SizedBox(
            height: gap,
          ),
        SizedBox(
          width: width,
          height: height,
          child: TextFormField(
            controller: textEditingController,
            textInputAction: TextInputAction.done,
            onChanged: (val) {},
            onTap: () {},
            validator: validateFunc,
            obscureText: isObsecure,
            decoration: InputDecoration(
              hintText: hintText,
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(
                  color: borderColor,
                  width: 0.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: borderColor,
                  width: 0.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: borderColor,
                  width: 0.5,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 0.5,
                ),
              ),
              hintStyle: const TextStyle(
                fontFamily: FontFamily.fontPoppins,
                color: Color(0xFFd1c4df),
                fontSize: 14,
              ),
              fillColor: fillColor,
              filled: true,
              contentPadding: const EdgeInsets.only(left: 14),
              helperText: '',
              errorText: (errorText == '') ? null : errorText,
              suffixIcon: suffixIconWidget,
              prefixIcon: prefixIconWidget,
            ),
          ),
        ),
      ],
    );
  }
}
