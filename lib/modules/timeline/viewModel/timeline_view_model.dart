import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimelineViewModel extends ChangeNotifier {
  String _todayDateInBangla = '';
  List<DateTime> _dateRange = [];
  List<String> _banglaDays = [];

  TimelineViewModel() {
    updateDate();
    setTodayDateInBangla();
    _generateDateRange();
    _generateBanglaDays();
  }

  String get todayDateInBangla => _todayDateInBangla;
  List<DateTime> get dateRange => _dateRange;
  List<String> get banglaDays => _banglaDays;

  void updateDate() {
    final now = DateTime.now();
    const banglaMonths = [
      'জানুয়ারি', 'ফেব্রুয়ারি', 'মার্চ', 'এপ্রিল', 'মে', 'জুন',
      'জুলাই', 'আগস্ট', 'সেপ্টেম্বর', 'অক্টোবর', 'নভেম্বর', 'ডিসেম্বর'
    ];
    final day = convertToBanglaDigits(now.day.toString());
    final month = banglaMonths[now.month - 1];
    final year = convertToBanglaDigits(now.year.toString());
    _todayDateInBangla = 'আজ, $day $month, $year';
    notifyListeners();
  }

  void setTodayDateInBangla() {
    final now = DateTime.now();
    const banglaMonths = [
      'জানুয়ারি', 'ফেব্রুয়ারি', 'মার্চ', 'এপ্রিল', 'মে', 'জুন',
      'জুলাই', 'আগস্ট', 'সেপ্টেম্বর', 'অক্টোবর', 'নভেম্বর', 'ডিসেম্বর'
    ];
    final day = convertToBanglaDigits(now.day.toString());
    final month = banglaMonths[now.month - 1];
    _todayDateInBangla = 'আজ, $day $month';
    notifyListeners();
  }

  String convertToBanglaDigits(String input) {
    const banglaDigits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
    return input.replaceAllMapped(RegExp(r'\d'), (match) {
      return banglaDigits[int.parse(match.group(0)!)];
    });
  }

  void _generateDateRange() {
    final now = DateTime.now();
    _dateRange = List<DateTime>.generate(16, (index) => now.subtract(Duration(days: 7 - index)));
  }

  void _generateBanglaDays() {
    const banglaDays = [
      'শনি', 'রবি', 'সোম', 'মঙ্গল', 'বুধ', 'বৃহ:', 'শুক্র',
    ];
    _banglaDays = _dateRange.map((date) {
      final dayIndex = date.weekday % 7;
      return banglaDays[dayIndex];
    }).toList();
  }

  String getDayName(DateTime date) {
    return DateFormat.EEEE().format(date);
  }

  String getDayNumber(DateTime date) {
    return convertToBanglaDigits(DateFormat.d().format(date));
  }
}

