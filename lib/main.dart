import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app_binding.dart';
import 'home_screen.dart';
import 'login_screen.dart';

void main() async {
  await GetStorage.init(); // Initialize GetStorage
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Token-based Login App',
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),  // Applying the binding class
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
      ],
    );
  }
}
