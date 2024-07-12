import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scheduler/model/service/local/shared_preferences.dart';

class HomeScreenViewModel with ChangeNotifier {
  final SharedPreService _storageService = SharedPreService();
  String? name;
  DateTime? startDate;
  DateTime? endDate;
  String? profileImage;

  String? banglaStartDate;
  String? banglaEndDate;

  Duration get elapsedDuration => DateTime.now().difference(startDate ?? DateTime.now());

  Duration get totalDuration => (endDate ?? DateTime.now()).difference(startDate ?? DateTime.now());

  double get progress {
    final totalDays = totalDuration.inDays;
    final elapsedDays = elapsedDuration.inDays;
    return totalDays > 0 ? elapsedDays / totalDays : 0.0;
  }

  String get elapsedTimeString {
    final duration = elapsedDuration;
    final years = duration.inDays ~/ 365;
    final months = (duration.inDays % 365) ~/ 30;
    final days = (duration.inDays % 365) % 30;
    final yearString = years > 0 ? '${convertToBanglaDigits(years.toString())} বছর ' : '';
    return '$yearString ${convertToBanglaDigits(months.toString())} মাস ${convertToBanglaDigits(days.toString())} দিন';
  }

  Map<String, int> get remainingTime {
    final remainingDuration = totalDuration - elapsedDuration;
    final years = remainingDuration.inDays ~/ 365;
    final months = (remainingDuration.inDays % 365) ~/ 30;
    final days = (remainingDuration.inDays % 365) % 30;
    return {'years': years, 'months': months, 'days': days};
  }

  String convertToBanglaDigits(String input) {
    const banglaDigits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
    return input.replaceAllMapped(RegExp(r'\d'), (match) {
      return banglaDigits[int.parse(match.group(0)!)];
    });
  }

  String convertDateToBangla(DateTime date) {
    const months = ['জানুয়ারি', 'ফেব্রুয়ারি', 'মার্চ', 'এপ্রিল', 'মে', 'জুন', 'জুলাই', 'আগস্ট', 'সেপ্টেম্বর', 'অক্টোবর', 'নভেম্বর', 'ডিসেম্বর'];
    final day = convertToBanglaDigits(date.day.toString());
    final month = months[date.month - 1];
    final year = convertToBanglaDigits(date.year.toString());
    return '$day $month $year';
  }

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
    final startDateString = await _storageService.read(key: 'startDate') as String?;
    final endDateString = await _storageService.read(key: 'endDate') as String?;
    profileImage = await _storageService.read(key: 'profileImage') as String?;

    if (startDateString != null) {
      startDate = DateTime.parse(startDateString);
      banglaStartDate = convertDateToBangla(startDate!);
    }
    if (endDateString != null) {
      endDate = DateTime.parse(endDateString);
      banglaEndDate = convertDateToBangla(endDate!);
    }
  }
}

