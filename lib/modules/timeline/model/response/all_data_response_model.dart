import 'dart:convert';
/// data : [{"date":"1720670400","name":"তরুণ কিশোর ছেলে, আমরা আজিকে ভাবিয়া না পাই তুমি হেথা কেন এলে?","category":"অনুচ্ছেদ","location":"ঢাকা, বাংলাদেশ"},{"date":"1720677600","name":"হয়ত তাহারি অলকে বাঁধিতে মাঠের কুসুম ফুল, কতদূর পথ ঘুরিয়া মরিছ কত পথ করি ভুল।","category":"বাক্য","location":"ঢাকা, বাংলাদেশ"},{"date":"1720641600","name":"তোমার গোকুল আজো শেখে নাই ভালবাসা বলে কারে, ভালবেসে তাই বুকে বেঁধে লয় আদরিয়া যারে তারে।","category":"শব্দ","location":"ঢাকা, বাংলাদেশ"},{"date":"1720756800","name":"হয়ত তাহাও জানে না সে মেয়ে জানে না কুসুম-হার, এত যে আদরে গাঁথিছে সে তাহা গলায় দোলাবে কার?","category":"অনুচ্ছেদ","location":"চট্টগ্রাম, বাংলাদেশ"},{"date":"1720764000","name":"আজো কানে গোঁজ শিরীষ কুসুম কিংশুক-মঞ্জরী, অলকে বাঁধিয়া পাটল ফুলেতে ভরে লও উত্তরী!","category":"বাক্য","location":"চট্টগ্রাম, বাংলাদেশ"},{"date":"1720728000","name":"আজিও নিজেরে বিকাইতে পার ফুলের মালার দামে, রূপকথা শুনি তোমাদের দেশে রূপকথা-দেয়া নামে।","category":"শব্দ","location":"চট্টগ্রাম, বাংলাদেশ"},{"date":"1720843200","name":"কারে ভালবাস, কারে যে বাস না তোমরা শেখনি তাহা, আমাদের মত কামনার ফাঁদে চেননি উহু ও আহা!কে এলে তবে ভাই, সোনার গোকুল আঁধার করিয়া এই মথুরার ঠাই","category":"অনুচ্ছেদ","location":"ঢাকা, বাংলাদেশ"},{"date":"1720850400","name":"হায়রে করুণ হায়, এখনি যে সবে জাগিয়া উঠিবে প্রভাতের কিনারায়।","category":"বাক্য","location":"ঢাকা, বাংলাদেশ"},{"date":"1720814400","name":"কে এলে তবে ভাই, সোনার গোকুল আঁধার করিয়া এই মথুরার ঠাই","category":"শব্দ","location":"ঢাকা, বাংলাদেশ"}]

AllDataResponseModel allDataResponseModelFromJson(String str) => AllDataResponseModel.fromJson(json.decode(str));
String allDataResponseModelToJson(AllDataResponseModel data) => json.encode(data.toJson());
class AllDataResponseModel {
  AllDataResponseModel({
      List<Data>? data,}){
    _data = data;
}

  AllDataResponseModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? _data;
AllDataResponseModel copyWith({  List<Data>? data,
}) => AllDataResponseModel(  data: data ?? _data,
);
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// date : "1720670400"
/// name : "তরুণ কিশোর ছেলে, আমরা আজিকে ভাবিয়া না পাই তুমি হেথা কেন এলে?"
/// category : "অনুচ্ছেদ"
/// location : "ঢাকা, বাংলাদেশ"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? date, 
      String? name, 
      String? category, 
      String? location,}){
    _date = date;
    _name = name;
    _category = category;
    _location = location;
}

  Data.fromJson(dynamic json) {
    _date = json['date'];
    _name = json['name'];
    _category = json['category'];
    _location = json['location'];
  }
  String? _date;
  String? _name;
  String? _category;
  String? _location;
Data copyWith({  String? date,
  String? name,
  String? category,
  String? location,
}) => Data(  date: date ?? _date,
  name: name ?? _name,
  category: category ?? _category,
  location: location ?? _location,
);
  String? get date => _date;
  String? get name => _name;
  String? get category => _category;
  String? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['name'] = _name;
    map['category'] = _category;
    map['location'] = _location;
    return map;
  }

}