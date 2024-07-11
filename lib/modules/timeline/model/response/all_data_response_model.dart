import 'dart:convert';

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