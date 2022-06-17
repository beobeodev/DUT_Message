import 'package:flutter/material.dart';
import 'package:flutter_frontend/modules/onboard/controllers/onboard.controller.dart';
import 'package:flutter_frontend/widgets/rounded_icon_button.widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class RowArrowButton extends GetView<OnboardController> {
  const RowArrowButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          if (controller.currentIndex.value != 0)
            RoundedIconButton(
              icon: FontAwesomeIcons.arrowLeft,
              onPressed: controller.onBackPage,
            ),
          const Spacer(),
          RoundedIconButton(
            icon: FontAwesomeIcons.arrowRight,
            onPressed: controller.currentIndex.value != 2
                ? controller.onNextPage
                : controller.onSkip,
          ),
        ],
      ),
    );
  }
}
