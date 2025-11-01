import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/enums.dart';
import '../../../domain/use_cases/auth/change_password_usecase.dart';
import '../../component/app_snack_bar.dart';

class ChangePasswordController extends GetxController {
  ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordController(this.changePasswordUseCase);

  StatusRequest statusRequest = StatusRequest.initial;
  final newPassword = TextEditingController();
  final oldPassword = TextEditingController();
  final formKey=GlobalKey<FormState>();

  Future<void> changePassword() async {
    statusRequest = StatusRequest.loading;
    update();
    final result = await changePasswordUseCase(
        oldPassword: oldPassword.text.trim(),
        newPassword: newPassword.text.trim());
    statusRequest=StatusRequest.initial;
    result.fold((l) => showToastMessage(label: '',text: l), (r) {
      showToastMessage(label: '',text: r.message??"");
    });
    Future.delayed(const Duration(milliseconds: 1500),() =>Get.back());
    update();
  }

  @override
  void dispose() {
    super.dispose();
    newPassword.dispose();
    oldPassword.dispose();
  }
}
