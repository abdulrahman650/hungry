import 'dart:ffi';
import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/core/network/api_exceptions.dart';
import 'package:hungry_app/core/network/api_services.dart';
import 'package:hungry_app/core/utils/pref_helper.dart';
import 'package:hungry_app/features/auth/data/user_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();
  bool isGuest = false;
  UserModel? _currentUser;

  //login
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiService.post("login", {
        "email": email,
        "password": password,
      });

      if (response is ApiError) throw response;

      if (response is Map<String, dynamic>) {
        print("🟢 Full response: $response");

        final code = response["code"];
        final coder = code is int ? code : int.tryParse(code.toString());
        final msg = response["message"];
        final data = response["data"];

        if (coder == 200 || coder == 201) {
          final user = UserModel.fromJson(data);
          print("🟢 Parsed user: ${user.email}");

          if (user.token != null) {
            await PrefHelper.saveToken(user.token!);
          }
          isGuest = false;
          _currentUser = user;
          return user;
        } else {
          throw ApiError(message: msg ?? "Login failed");
        }
      } else {
        throw ApiError(message: "Unexpected response type from server");
      }
    } on DioError catch (e) {
      print("❌ DioError: ${e.message}");
      throw ApiError(message: "${e.message}");
    } catch (e) {
      print("❌ General error: $e");
      throw ApiError(message: e.toString());
    }
  }

  //sign out
  Future<UserModel?> signup(String name, String email, String password) async {
    try {
      final response = await apiService.post("register", {
        "name": name,
        "email": email,
        "password": password,
      });
      if (response is ApiError) throw response;

      if (response is Map<String, dynamic>) {
        print("🟢 Full response: $response");

        final code = response["code"];
        final msg = response["message"];
        final coder = code is int ? code : int.tryParse(code.toString());
        final data = response["data"];

        if (coder == 200 || coder == 201) {
          final user = UserModel.fromJson(data);
          print("🟢 Parsed user: ${user.email}");

          if (user.token != null) {
            await PrefHelper.saveToken(user.token!);
          }
          isGuest = false;
          _currentUser = user;
          return user;
        } else {
          throw ApiError(message: msg ?? "Sign Up failed");
        }
      }
    } on DioError catch (e) {
      print("❌ DioError: ${e.message}");
      throw ApiError(message: "${e.message}");
    } catch (e) {
      print("❌ General error: $e");
      throw ApiError(message: e.toString());
    }
    return null;
  }

  //Get Profile data
  Future<UserModel?> getProfileData({bool forceRefresh = false}) async {
    if (!forceRefresh && _currentUser != null) return _currentUser;
    try {
      final token = await PrefHelper.getToken();
      if (token == null || token == "guest") {
        return null;
      }
      final response = await apiService.get("profile");
      if (response is! Map<String, dynamic>) {
        throw ApiError(message: "Invalid response from server");
      }

      final data = response["data"];
      if (data == null) {
        throw ApiError(message: "No data found in response");
      }

      final user = UserModel.fromJson(data);
      _currentUser = user;
      return user;
    } on DioError catch (e) {
      print("❌ DioError: ${e.message}");
      throw ApiExceptions.handleError(e);
    } catch (e) {
      print("❌ General error: $e");
      throw ApiError(message: e.toString());
    }
  }

  //Get Profile data
  // Future<UserModel?> getProfileData() async {
  //   try {
  //     final token = await PrefHelper.getToken();
  //     if (token == null || token == "guest") {
  //       return null;
  //     }
  //     final response = await apiService.get("profile");
  //     final user = UserModel.fromJson(response["data"]);
  //     _currentUser = user;
  //     return user;
  //   } on DioError catch (e) {
  //     print("❌ DioError: ${e.message}");
  //     throw ApiExceptions.handleError(e);
  //   } catch (e) {
  //     print("❌ General error: $e");
  //     throw ApiError(message: e.toString());
  //   }
  // }

  // update profile data
  Future<UserModel?> updateProfileData({
    required String name,
    required String email,
    required String address,
    String? visa,
    String? imagePath,
  }) async {
    try {
      final formData = FormData.fromMap({
        "name": name,
        "email": email,
        "address": address,
        if (visa != null && visa.isNotEmpty) "Visa": visa,
        if (imagePath != null && imagePath.isNotEmpty)
          "image": await MultipartFile.fromFile(
            imagePath,
            filename: "profile.jpg",
          ),
      });
      final response = await apiService.post("update-profile", formData);

      if (response is ApiError) throw response;

      if (response is Map<String, dynamic>) {
        print("🟢 Full response: $response");

        final code = response["code"];
        final msg = response["message"];
        final coder = code is int ? code : int.tryParse(code.toString());
        final data = response["data"];

        if (coder != 200 && coder != 201) {
          throw ApiError(message: msg ?? "Unknow error");
        }
        final updateUser = UserModel.fromJson(data);
        _currentUser = updateUser;
        return updateUser;
      } else {
        throw ApiError(message: "Invalid Error from here");
      }
    } on DioError catch (e) {
      print("❌ DioError: ${e.message}");
      throw ApiError(message: "${e.message}");
    } catch (e) {
      print("❌ General error: $e");
      throw ApiError(message: e.toString());
    }
    return null;
  }

  //Logout
  Future<void> logout() async {
    try {
      //  تأكد من وجود token قبل الطلب
      final token = await PrefHelper.getToken();
      if (token == null) {
        print("⚠️ No token found, proceeding as guest");
        _currentUser = null;
        isGuest = true;
        return;
      }
      final response = await apiService.post("logout", {});

      if (response is ApiError) {
        print("❌ Logout Error: ${response.message}");
        _currentUser = null;
        isGuest = true;
        await PrefHelper.clearToken();
        return;
      }
      if (response is! Map<String, dynamic>) {
        print("⚠️ Unexpected response format, still logging out");
      }

      await PrefHelper.clearToken();
      _currentUser = null;
      isGuest = true;
      print("✔ Logout success");
    } catch (e) {
      print("❌ Logout Exception: $e");
      _currentUser = null;
      isGuest = true;
      await PrefHelper.clearToken();
    }
  }

  // Future<void> logout() async {
  //   final response = await apiService.post("logout", {});
  //   if (response["data"] != null) {
  //     throw ApiError(message: "take care");
  //   }
  //   await PrefHelper.clearToken();
  //   _currentUser = null;
  //   isGuest = true;
  // }

  // auto login
  Future<UserModel?> autoLogin() async {
    //  لو في بيانات موجودة بالفعل، ارجعها
    if (_currentUser != null) return _currentUser;

    final token = await PrefHelper.getToken();
    if (token == null || token == "guest") {
      isGuest = true;
      _currentUser = null;
      return null;
    }
    isGuest = false;
    try {
      final user = await getProfileData();
      _currentUser = user;
      return user;
    } catch (_) {
      await PrefHelper.clearToken();
      isGuest = true;
      _currentUser = null;
      return null;
    }
  }

  // Future<UserModel?> autoLogin() async {
  //   final token = await PrefHelper.getToken();
  //
  //   if (token == null || token == "guest") {
  //     isGuest = true;
  //     _currentUser = null;
  //     return null;
  //   }
  //   isGuest = false;
  //   try {
  //     final user = await getProfileData();
  //     _currentUser = user;
  //     return user;
  //   } catch (_) {
  //     await PrefHelper.clearToken();
  //     isGuest = true;
  //     _currentUser = null;
  //     return null;
  //   }
  // }

  // continue as guest
  Future<void> continueAsGuest() async {
    isGuest = true;
    _currentUser = null;
    await PrefHelper.saveToken("guest");
  }

  UserModel? get currentUser => _currentUser;

  bool get isLoggedIn => !isGuest && _currentUser != null;
}
