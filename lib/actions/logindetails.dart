import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pravesh_screen/initialInfo/intro_pages.dart';
import 'package:pravesh_screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String LoginKey = "isLogin";
  bool? isLogin = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    skipLogin();
  }

  void login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(LoginKey, true);
    Get.to(IntroPages());
  }

  void skipLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool(LoginKey);

    if (isLogin = true) {
      Get.to(IntroPages());
    } else {
      Get.to(LoginPage());
    }
  }
}
