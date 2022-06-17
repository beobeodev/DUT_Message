import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/core/constants/font_family.dart';
import 'package:flutter_frontend/core/theme/palette.dart';
import 'package:flutter_frontend/data/models/user.model.dart';
import 'package:flutter_frontend/data/repositories/firebase_repository.dart';
import 'package:flutter_frontend/data/repositories/user_repository.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:flutter_frontend/modules/root/controllers/root.controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final AuthController authController;
  final RootController rootController;
  final UserRepository userRepository;
  final FirebaseRepository firebaseRepository;

  ProfileController({
    required this.authController,
    required this.rootController,
    required this.userRepository,
    required this.firebaseRepository,
  });

  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController phoneEditingController = TextEditingController();

  late Rx<UserModel> currentUser;
  final RxBool isUpdate = false.obs;
  final RxBool isLoading = false.obs;

  final GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    currentUser = authController.currentUser!.obs;

    nameEditingController.text = currentUser.value.name;
    emailEditingController.text = currentUser.value.email ?? '';
    phoneEditingController.text = currentUser.value.phone ?? '';
  }

  String? validateName(String? value) {
    if (value == '') {
      return 'Tên không được để trống';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == '') {
      return 'Email không dược để trống';
    } else if (!value!.isEmail) {
      return 'Không đúng định dạng email';
    }
    return null;
  }

  void onChangeTextfieldName(String value) {
    currentUser.value.name = value;
    isUpdate.value = true;
  }

  void onChangeTextfieldEmail(String value) {
    currentUser.value.email = value;
    isUpdate.value = true;
  }

  Future<void> onTapAvatar() async {
    final FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      isLoading.value = true;
      final File file = File(result.files.single.path!);
      final String url =
          await firebaseRepository.uploadToFireStorage(FileType.image, file);
      isLoading.value = false;
      isUpdate.value = true;
      currentUser.update((val) {
        val!.avatar = url;
      });
    }
  }

  Future<void> onTapUpdate() async {
    if (!profileFormKey.currentState!.validate()) {
      return;
    } else {
      Timer? timer;

      isLoading.value = true;

      await userRepository.updateProfile(currentUser.value);
      isLoading.value = false;
      if (true) {
        await showDialog(
          context: Get.context!,
          builder: (BuildContext builderContext) {
            timer = Timer(const Duration(milliseconds: 600), () {
              Get.back();
            });

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              content: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                direction: Axis.vertical,
                children: [
                  Icon(
                    Icons.check,
                    color: Colors.green,
                    size: ScreenUtil().setSp(72),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Thành công!',
                    style: TextStyle(
                      fontFamily: FontFamily.fontNunito,
                      color: Palette.zodiacBlue,
                      fontWeight: FontWeight.w700,
                      fontSize: ScreenUtil().setSp(25),
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            );
          },
        ).then((val) {
          if (timer!.isActive) {
            timer!.cancel();
          }
        });
        isUpdate.value = false;
        await authController.setCurrentUser(currentUser.value);
      }
    }
  }
}
