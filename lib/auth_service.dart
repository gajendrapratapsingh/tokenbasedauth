import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthService extends GetxService {
  final storage = GetStorage();
  final token = ''.obs;
  final refreshToken = ''.obs;

  Future<void> init() async {
    token.value = storage.read('token') ?? '';
    refreshToken.value = storage.read('refreshToken') ?? '';
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
        'expiresInMins': 30, // optional, defaults to 60
      }),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      debugPrint("login data $data");
      token.value = data['token'];
      debugPrint("token data ${data['token']}");
      refreshToken.value = data['refreshToken'];
      storage.write('token', token.value);
      storage.write('refreshToken', refreshToken.value);
      return data;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> logout() async {
    token.value = '';
    refreshToken.value = '';
    storage.remove('token');
    storage.remove('refreshToken');
  }

  Future<void> refreshAuthToken() async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/refresh'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'refreshToken': refreshToken.value}),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      token.value = data['token'];
      storage.write('token', token.value);
    } else {
      throw Exception('Failed to refresh token');
    }
  }

  bool isTokenExpired() {
    if(token.value.isEmpty) {
      return true;
    }
    return JwtDecoder.isExpired(token.value);
  }
}
