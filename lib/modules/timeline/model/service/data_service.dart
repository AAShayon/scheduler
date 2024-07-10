// import 'package:dio/dio.dart';
// import 'package:scheduler/model/core/api_urls.dart';
// import 'package:scheduler/model/service/api_error_handler.dart';
// import 'package:scheduler/model/service/api_response.dart';
// import 'package:scheduler/model/service/dio_service.dart';
//
// abstract class HomeService{
//   Future<ApiResponse> getAllData();
// }
//
// class HomeServiceRemoteDataSource extends HomeService{
//   static final HomeServiceRemoteDataSource _singleton=HomeServiceRemoteDataSource._internal();
//   late final DioService? _dioService;
//
//   factory HomeServiceRemoteDataSource(){
//     return _singleton;
//   }
//
//   HomeServiceRemoteDataSource._internal(){
//     _dioService=DioService();
//   }
//
//   @override
//   Future<ApiResponse> getAllData() async{
//  try{
//    Response? response= await _dioService!.get(ApiUrls().allData);
//    return ApiResponse.withSuccess(response!);
//  }catch(e){
//    return ApiResponse.withError(ApiErrorHandler.getErrorMessage(e));
//  }
//   }
//
//
// }