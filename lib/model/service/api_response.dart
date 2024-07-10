import 'package:dio/dio.dart';

class ApiResponse{
  final Response? responseValue;
  dynamic errorValue;
  ApiResponse(this.responseValue,this.errorValue);
  ApiResponse.withSuccess(Response response):responseValue=response,errorValue=null;
  ApiResponse.withError(dynamic error):errorValue=error,responseValue=null;

}