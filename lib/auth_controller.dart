import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'auth_service.dart';
import 'package:flutter/material.dart';


class AuthController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  var isLoggedIn = false.obs;
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var errorMessage = ''.obs;

  var passwordVisible = false.obs;
  var keepLoggedIn = false.obs;

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    authService.init().then((_) {
      if (!authService.isTokenExpired()) {
        isLoggedIn.value = true;
      }
    });
  }

  Future<void> login() async {
    try {
      isLoading.value = true;
      final response = await authService.login(usernameController.text.trim(), passwordController.text.trim());
      if(response.containsKey('token')) {
        usernameController.clear();
        passwordController.clear();
        isLoggedIn.value = true;
        isLoading.value = false;
        Get.offNamed('/home'); // Navigate to HomeScreen on successful login
      } else {
        isLoading.value = false;
        Fluttertoast.showToast(
            msg: "Invalid Credentials",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        errorMessage.value = 'Login failed';
      }
    } catch (e) {
      isLoading.value = false;
      Fluttertoast.showToast(
          msg: "Invalid Credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      errorMessage.value = 'Login failed';
    }
  }

  void setVisibility(bool vs){
    passwordVisible.value = vs;
  }
  bool get visibilypw => passwordVisible.value;

  void setKeeplogin(bool keeplogin){
    keepLoggedIn.value = keeplogin;
  }
  bool get keeplogin => keepLoggedIn.value;

  Future<void> logout() async {
    await authService.logout();
    isLoggedIn.value = false;
    Get.offNamed('/login'); // Navigate back to LoginScreen
  }

  void checkTokenAndRefresh() async {
    if (authService.isTokenExpired()) {
      try {
        await authService.refreshAuthToken();
      } catch (e) {
        logout();
      }
    }
  }
}
