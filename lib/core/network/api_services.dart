import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_exceptions.dart';
import 'package:hungry_app/core/network/dio_client.dart';

import 'api_error.dart';

class ApiService{
  final DioClient _dioClient =DioClient();


  //get
Future<dynamic> get(String endPoint,{dynamic param}) async{
  try{
    final response = await _dioClient.dio.get(endPoint,queryParameters: param);
    return response.data;
  }on DioException catch(error){
    return ApiExceptions.handleError(error);
  }
}

  Future<dynamic> post(String endPoint,dynamic body) async {
    try {
      print("📤 Sending POST => $endPoint");
      print("📦 Body => $body");

      final response = await _dioClient.dio.post(endPoint, data: body);

      print("✅ Response status: ${response.statusCode}");
      print("✅ Response data: ${response.data}");

      return response.data;
    } on DioException catch (error) {
      return ApiExceptions.handleError(error);
    } catch (e) {
      print("❌ Unknown error: $e");
      return ApiError(message: "Unexpected error: $e");
    }
  }


//put
  Future<dynamic> put(String endPoint,dynamic body) async{
    try{
      final response = await _dioClient.dio.put(endPoint,data: body);
      return response.data;
    }on DioException catch(e){
      return ApiExceptions.handleError(e);
    }
  }

  //delete
  Future<dynamic> delete(String endPoint, dynamic body, {dynamic params}) async{
    try{
      final response = await _dioClient.dio.delete(endPoint,data: body,queryParameters: params);
      return response.data;
    }on DioException catch(e){
      return ApiExceptions.handleError(e);
    }
  }






}