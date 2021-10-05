import 'package:flutter/material.dart';
import 'package:flutter_frontend/config/constants/font_family.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({this.label, this.isObsecure, this.width, this.height, this.gap, this.textEditingController, this.borderRadius, this.hintText, this.borderColor, this.suffixIconWidget});

  final String label;
  final bool isObsecure;
  final double width;
  final double height;
  final double gap;
  final TextEditingController textEditingController;
  final double borderRadius;
  final String hintText;
  final Color borderColor;
  final Widget suffixIconWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) Text(
          label,
          style: TextStyle(
            fontFamily: FontFamily.fontPoppins,
          ),
        ),
        if (label != null) SizedBox(
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
            obscureText: isObsecure == null ? false : true,
            decoration: InputDecoration(
              hintText: hintText,
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 6.0),
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
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 0.5,
                ),
              ),
              hintStyle: TextStyle(
                fontFamily: FontFamily.fontPoppins,
                color: Color(0xFFd1c4df),
                fontSize: 14,
              ),
              fillColor: Colors.white,
              filled: true,
              contentPadding: EdgeInsets.only(left: 14),
              helperText: "",
              suffixIcon: suffixIconWidget,
            ),
          ),
        ),
      ],
    );
  }
}
