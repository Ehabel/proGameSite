// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// class TokenStorage {
//   final _storage = FlutterSecureStorage();
//
//   Future<void> storeToken(String token) async {
//     await _storage.write(key: 'token', value: token);
//   }
//
//   Future<String?> getToken() async {
//     return await _storage.read(key: 'token');
//   }
//
//   Future<void> deleteToken() async {
//     await _storage.delete(key: 'token');
//   }
// }

import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final _storage = FlutterSecureStorage();

  Future<void> storeTokenAndEmail(String token, String email) async {
    Map<String, dynamic> data = {
      'token': token,
      'email': email,
    };
    String jsonData = json.encode(data);
    await _storage.write(key: 'userData', value: jsonData);
  }

  Future<Map<String, dynamic>?> getTokenAndEmail() async {
    String? jsonData = await _storage.read(key: 'userData');
    if (jsonData != null) {
      Map<String, dynamic> data = json.decode(jsonData);
      return data;
    }
    return null;
  }

  Future<String?> extractToken() async {
    Map<String, dynamic>? data = await getTokenAndEmail();
    if (data != null) {
      return data['token'];
    }
    return null;
  }

  Future<String?> extractEmail() async {
    Map<String, dynamic>? data = await getTokenAndEmail();
    if (data != null) {
      return data['email'];
    }
    return null;
  }

  Future<void> deleteTokenAndEmail() async {
    await _storage.delete(key: 'userData');
  }
}