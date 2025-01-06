import 'package:bookhive/services/auth_services.dart';
import 'package:bookhive/utils/toast_util.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class SignupController extends GetxController {
  final AuthService _authService = AuthService();

  // TextEditingControllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var addressController = TextEditingController();
  var phoneController = TextEditingController();
  var dobController = TextEditingController();
  var passwordController = TextEditingController();

  var isLoading = false.obs;

  Future<void> registerUser() async {
    isLoading.value = true;
    try {
      UserModel newUser = UserModel(
        id: '', // Firestore will generate the ID
        name: nameController.text,
        email: emailController.text,
        address: addressController.text,
        phone: phoneController.text,
        dob: dobController.text,
      );

      await _authService.registerUser(newUser, passwordController.text);

      ToastUtil.showToast(
        message: "User Regitered Successfully",
      ); // Navigate to login or another page
    } catch (e) {
      ToastUtil.showToast(
        message: "Error. Something went wrong",
      );
    } finally {
      isLoading.value = false;
    }
  }
}
