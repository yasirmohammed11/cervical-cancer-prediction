import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uterine_cancer_flutter_app/constants.dart';

class AuthService extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  String? _token; // يمكن استخدام هذا لتخزين رمز JWT إذا كان الـ API يدعمه
  int? _userId;
  String? _username;
  String? _errorMessage;

  bool get isAuthenticated => _userId != null;
  int? get userId => _userId;
  String? get username => _username;
  String? get errorMessage => _errorMessage;

  AuthService() {
    _loadUser();
  }

  Future<void> _loadUser() async {
    _userId = int.tryParse(await _storage.read(key: 'user_id') ?? '');
    _username = await _storage.read(key: 'username');
    notifyListeners();
  }

  Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$kBaseUrl/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      final data = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 200 && data['success']) {
        _userId = data['user_id'];
        _username = data['username'];
        await _storage.write(key: 'user_id', value: _userId.toString());
        await _storage.write(key: 'username', value: _username);
        _errorMessage = null;
        notifyListeners();
        return true;
      } else {
        _errorMessage = data['message'] ?? 'فشل تسجيل الدخول. تحقق من بياناتك.';
        return false;
      }
    } catch (e) {
      _errorMessage = 'حدث خطأ في الاتصال بالخادم: $e';
      return false;
    }
  }

  Future<bool> register(String fullName, String email, String username, int age, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$kBaseUrl/api/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'full_name': fullName,
          'email': email,
          'username': username,
          'age': age,
          'password': password,
        }),
      );

      final data = json.decode(utf8.decode(response.bodyBytes));

      if (response.statusCode == 201 && data['success']) {
        _errorMessage = null;
        return true;
      } else {
        _errorMessage = data['message'] ?? 'فشل التسجيل. حاول مرة أخرى.';
        return false;
      }
    } catch (e) {
      _errorMessage = 'حدث خطأ في الاتصال بالخادم: $e';
      return false;
    }
  }

  Future<void> logout() async {
    _userId = null;
    _username = null;
    await _storage.delete(key: 'user_id');
    await _storage.delete(key: 'username');
    notifyListeners();
  }
}
