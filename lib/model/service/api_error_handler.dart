import 'dart:developer';

import 'package:dio/dio.dart';

class ApiErrorHandler{
  static dynamic getErrorMessage(error){
    dynamic errorDescription='';
    if(error is Exception){
      log('Error Is Exception');
      try{
       if(error is DioException){
         log('Error is DioException');
         log('Check error is :${error.type}');
         switch(error.type){

           case DioExceptionType.connectionTimeout:
                errorDescription='connectionTimeout';
                break;
           case DioExceptionType.sendTimeout:
             errorDescription='sendTimeout';
             break;
           case DioExceptionType.receiveTimeout:
             errorDescription='receiveTimeout';
             break;
           case DioExceptionType.badCertificate:
             errorDescription='badCertificate';
             break;
           case DioExceptionType.badResponse:
             errorDescription='badResponse';
             break;
           case DioExceptionType.cancel:
             errorDescription='cancel';
             break;
           case DioExceptionType.connectionError:
             errorDescription='';
             break;
           case DioExceptionType.unknown:
             errorDescription='';
             break;
         }
       }else{
         errorDescription='Unexpected error Come';
       }
      }on FormatException catch(e){
        errorDescription='$e is FormatException';
      }
    }
    else{
      errorDescription='Not a Subtype of error';
    }
    return errorDescription;
  }

}