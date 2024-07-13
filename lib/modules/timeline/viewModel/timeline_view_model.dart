import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/model/service/local/shared_preferences.dart';
import 'package:scheduler/model/service/remote/api_response.dart';
import 'package:scheduler/modules/timeline/model/response/all_data_response_model.dart';
import 'package:scheduler/modules/timeline/model/service/timeline_data_service.dart';

class TimelineViewModel extends ChangeNotifier {
  final TimelineService _timelineService = TimelineServiceRemoteDataSource();
  final SharedPreService _storageService = SharedPreService();

  List<Map<String, String>> _timelineEntries = [];
  bool _isLoading = false;
  AllDataResponseModel? _allDataResponseModel;
  List<Data> _allData = [];

  DateTime _selectedDate = DateTime.now();

  void setDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  String _todayDateInBangla = '';
  List<DateTime> _dateRange = [];
  List<String> _banglaDays = [];

  String get todayDateInBangla => _todayDateInBangla;
  List<DateTime> get dateRange => _dateRange;
  List<String> get banglaDays => _banglaDays;
  List<Map<String, String>> get timelineEntries => _timelineEntries;
  DateTime get selectedDate => _selectedDate;

  bool get isLoading => _isLoading;
  AllDataResponseModel? get allDataResponseModel => _allDataResponseModel;
  List<Data> get allData => _allData.where((data) => _isSameDate('${data.date}')).toList();

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

  void generateDateRange() {
    final now = DateTime.now();
    final startDate = now.subtract(Duration(days: 6));
    _dateRange = List<DateTime>.generate(13, (index) => startDate.add(Duration(days: index)));
    notifyListeners();
  }

  void generateBanglaDays() {
    const banglaDays = ['রবি', 'সোম', 'মঙ্গল', 'বুধ', 'বৃহ:', 'শুক্র', 'শনি'];
    _banglaDays = _dateRange.map((date) {
      final dayIndex = date.weekday % 7;
      return banglaDays[dayIndex];
    }).toList();
    notifyListeners();
  }

  String getDayName(DateTime date) {
    return DateFormat.EEEE().format(date);
  }

  String getDayNumber(DateTime date) {
    return convertToBanglaDigits(DateFormat.d().format(date));
  }
  Map<String, String> greeting(String? timestamp, BuildContext context) {
    if (timestamp == null) {
      return {'period': 'Unknown time', 'formattedTime': 'Unknown time'};
    }

    final dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);
    final timeOfDay = TimeOfDay.fromDateTime(dateTime);
    final hour = timeOfDay.hour;

    String period;
    if (hour < 6) {
      period = 'রাত';
    } else if (hour < 12) {
      period = 'সকাল';
    } else if (hour < 16) {
      period = 'দুপুর';
    } else if (hour < 18) {
      period = 'বিকেল';
    } else if (hour < 20) {
      period = 'সন্ধ্যা';
    } else {
      period = 'রাত';
    }

    final formattedTime = convertToBanglaDigits(timeOfDay.format(context).replaceAll(RegExp(r'[apAP][mM]'), ''));
    return {'period': period, 'formattedTime': formattedTime};
  }

  bool _isSameDate(String timestamp) {
    int parsedTimestamp = int.tryParse(timestamp) ?? 0;
    DateTime date = DateTime.fromMillisecondsSinceEpoch(parsedTimestamp * 1000).toLocal();
    return date.year == _selectedDate.year && date.month == _selectedDate.month && date.day == _selectedDate.day;
  }

  Future<bool> getAllData(BuildContext context) async {
    bool isGet = false;
    _isLoading = true;
    _allDataResponseModel = null;
    _allData = [];
    notifyListeners();
    try {
     ApiResponse apiResponse=await _timelineService.getAllData();
     if(apiResponse.responseValue != null){
       if(apiResponse.responseValue!.statusCode == 200){
         _allDataResponseModel=AllDataResponseModel.fromJson(apiResponse.responseValue!.data);
         _allData=_allDataResponseModel!.data!;
         isGet=true;
         _isLoading=false;
         notifyListeners();
       }else{
         isGet=false;
         _isLoading=false;
         notifyListeners();
       }
     }else{
       isGet=false;
       _isLoading=false;
       notifyListeners();
     }
    } catch (e) {
      isGet=false;
      _isLoading=false;
      notifyListeners();
    }
    return isGet;
  }
  Future<void> addNewEntry(Map<String, String> entry) async {
    _timelineEntries.add(entry);
    await _storageService.write(key: 'timelineEntries', value: jsonEncode(timelineEntries));
    notifyListeners();
  }

  Future<void> loadTimelineData() async {
    final storedData = await _storageService.read(key: 'timelineEntries') as String?;
    if (storedData != null) {
      _timelineEntries = List<Map<String, String>>.from(jsonDecode(storedData));
    }
    notifyListeners();
  }
}
