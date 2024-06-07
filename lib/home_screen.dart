import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

class HomeScreen extends GetWidget<AuthController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: controller.logout,
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to Home!'),
      ),
    );
  }
}
