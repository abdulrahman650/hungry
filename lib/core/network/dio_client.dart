// import 'package:dio/dio.dart';
// import 'package:hungry_app/core/utils/pref_helper.dart';
// class DioClient{
//   final Dio _dio =Dio(
//     BaseOptions(
//       baseUrl: "https://sonic-zdi0.onrender.com/api/",
//       headers: {"Content-Type":"application/json"},
//
//     ),
//   );
//
//
//   DioClient(){
//     // _dio.interceptors.add(LogInterceptor(
//     //   requestBody: true,
//     //   responseBody: true,
//     // ));
//
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           final token =await PrefHelper.getToken();
//           print("API Request to: ${options.path}");
//           print("Token for request: ${token ?? "null"}");
//
//           if(token != null && token.isNotEmpty && token != "guest"){
//             options.headers["Authorization"]= "Bearer $token";
//           }
//           return handler.next(options);
//         }
//       ),
//     );
//   }
//   Dio get dio => _dio;
//
// }
import 'package:dio/dio.dart';
import 'package:hungry_app/core/utils/pref_helper.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://sonic-zdi0.onrender.com/api/",
      headers: {"Content-Type": "application/json"},
    ),
  );

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await PrefHelper.getToken();

          print("API Request to: ${options.path}");
          print("Token for request: ${token ?? 'null'}");

          // ❌ لو Guest → لا تبعت Authorization
          if (token == null || token.isEmpty || token == "guest") {
            options.headers.remove("Authorization");
          }
          // ✅ لو عندك توكين فعلي → ضيفه
          else {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
