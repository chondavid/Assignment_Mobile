import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:full_stack_app_ecom/app/data/providers/api_provider.dart';
import 'package:full_stack_app_ecom/app/routes/app_pages.dart';
import 'package:full_stack_app_ecom/app/services/storage_service.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final emailController = TextEditingController(text: "nith@gmail.com");
  final passwordController = TextEditingController(text: "123123");

  final _provider = Get.find<APIProvider>();

  void login({required String email, required String password}) async {
    try {
      final response = await _provider.login(email: email, password: password);
      if (response.statusCode == 200) {
        final token = response.data['token'];
        StorageService.write(key: 'token', value: token);
        Map<String, dynamic> user = response.data['user'];
        StorageService.write(key: 'user', value: jsonEncode(user));
        // go to dashboard or home view
        Get.offNamed(Routes.MAIN);
      } else {
        Get.defaultDialog(
          title: "Error",
          content: Text("Failed to login"),
        );
      }
    } catch (e) {
      Get.defaultDialog(title: "Error", content: Text(e.toString()));
    }
  }
}
