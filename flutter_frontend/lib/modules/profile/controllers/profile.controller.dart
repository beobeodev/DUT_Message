import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_frontend/data/models/user.model.dart';
import 'package:flutter_frontend/data/repositories/firebase_repository.dart';
import 'package:flutter_frontend/data/repositories/user_repository.dart';
import 'package:flutter_frontend/modules/base/controllers/auth.controller.dart';
import 'package:flutter_frontend/modules/root/controllers/root.controller.dart';
import 'package:flutter_frontend/widgets/rounded_alert_dialog.widget.dart';
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
      final File file = File(result.files.single.path!);
      final String url =
          await firebaseRepository.uploadToFireStorage(FileType.image, file);

      isUpdate.value = true;

      currentUser.update((val) {
        val!.avatar = url;
      });
    }
  }

  Future<void> submitUpdateProfile() async {
    if (!profileFormKey.currentState!.validate()) {
      return;
    }

    try {
      await userRepository.updateProfile(currentUser.value);

      await showSuccessDialog();
      isUpdate.value = false;
      await authController.setCurrentUser(currentUser.value);
    } catch (e) {
      log('Error in submitUpdateProfile() from ProfileController: $e');
    }
  }

  Future<void> showSuccessDialog() async {
    final Timer timer = Timer(const Duration(milliseconds: 600), () {
      Get.back();
    });

    await showDialog(
      context: Get.context!,
      builder: (BuildContext builderContext) {
        return const RoundedAlertDialog(
          icon: Icons.check,
          content: 'Cập nhật thành công!',
        );
      },
    ).then((val) {
      if (timer.isActive) {
        timer.cancel();
      }
    });
  }
}
