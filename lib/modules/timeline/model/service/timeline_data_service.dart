import 'package:dio/dio.dart';
import 'package:scheduler/model/core/api_urls.dart';
import 'package:scheduler/model/service/remote/api_error_handler.dart';
import 'package:scheduler/model/service/remote/api_response.dart';
import 'package:scheduler/model/service/remote/dio_service.dart';


abstract class TimelineService{
  Future<ApiResponse> getAllData();
}

class TimelineServiceRemoteDataSource extends TimelineService{
  static final TimelineServiceRemoteDataSource _singleton=TimelineServiceRemoteDataSource._internal();
  late final DioService? _dioService;

  factory TimelineServiceRemoteDataSource(){
    return _singleton;
  }

  TimelineServiceRemoteDataSource._internal(){
    _dioService=DioService();
  }

  @override
  Future<ApiResponse> getAllData() async{
 try{
   Response? response= await _dioService!.get(ApiUrls().allData);
   return ApiResponse.withSuccess(response!);
 }catch(e){
   return ApiResponse.withError(ApiErrorHandler.getErrorMessage(e));
 }
  }


}