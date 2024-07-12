import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scheduler/model/service/local/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier{
  final SharedPreService _storageService = SharedPreService();
  String? name;
  String? startDate;
  String? endDate;
  String? profileImage;

  Future<void> login({
    required String name,
    required String startDate,
    required String endDate,
    required File? profileImage,
  }) async {
    await _storageService.write(key: 'name', value: name);
    await _storageService.write(key: 'startDate', value: startDate);
    await _storageService.write(key: 'endDate', value: endDate);
    if (profileImage != null) {
      await _storageService.write(key: 'profileImage', value: base64Encode(profileImage.readAsBytesSync()));
    }
    await _loadUserData();
    notifyListeners();
  }

  Future<void> logout() async {
    await _storageService.delete(key: 'name');
    await _storageService.delete(key: 'startDate');
    await _storageService.delete(key: 'endDate');
    await _storageService.delete(key: 'profileImage');
    name = null;
    startDate = null;
    endDate = null;
    profileImage = null;
    notifyListeners();
  }
  Future<bool> isLoggedIn() async {
    await _loadUserData();
    return name != null;
  }

  Future<void> _loadUserData() async {
    name = await _storageService.read(key: 'name') as String?;
    startDate = await _storageService.read(key: 'startDate') as String?;
    endDate = await _storageService.read(key: 'endDate') as String?;
    profileImage = await _storageService.read(key: 'profileImage') as String?;
  }

}

