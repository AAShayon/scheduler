import 'package:flutter/material.dart';

class HomeScreenViewModel with ChangeNotifier {
  final DateTime joinDate = DateTime(2024, 1, 1);
  final DateTime endDate = DateTime(2030, 1, 31);

  Duration get elapsedDuration => DateTime.now().difference(joinDate);

  Duration get totalDuration => endDate.difference(joinDate);

  double get progress {
    final totalDays = totalDuration.inDays;
    final elapsedDays = elapsedDuration.inDays;
    return elapsedDays / totalDays;
  }

  String get elapsedTimeString {
    final duration = elapsedDuration;
    final years = duration.inDays ~/ 365;
    final months = duration.inDays ~/ 30;
    final days = duration.inDays % 30;
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





}

