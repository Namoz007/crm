import 'dart:convert';

import 'package:dars_81_home/data/model/login_request_model.dart';
import 'package:dars_81_home/data/model/registration_model.dart';
import 'package:dars_81_home/data/model/social_login_request.dart';
import 'package:dars_81_home/data/model/user_model.dart';
import 'package:dars_81_home/services/dio_file.dart';
import 'package:dars_81_home/utils/app_utils.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationServices {
  final _dio = DioFile.getInstance().dio;

  Future<String> signInOrSignUp({LoginRequestModel? model,RegistrationModel? registerModel,required String query}) async {
    dynamic response = '';
    try {
      if (query == 'signin') {
        response = await _dio.post(
          "/login",
          data: {
            "phone": model!.phoneNumber,
            "password": model!.password,
          },
        );
      } else {
        response = await _dio.post("/register", data: registerModel!.toMap());
      }
      final pref = await SharedPreferences.getInstance();
      pref.setString("token", response.data['data']['token']);
    } on DioException catch (e) {
      if(query == 'signin'){
        return 'User not found';
      }
      return 'User already have';
    } catch (e) {
      return 'Something went wrong!';
    }
    return '';
  }

  Future<UserModel> getMyUser() async {
    dynamic response = '';
    try{
      response = await _dio.get(
        "/user",
      );
    }on DioException catch(e){
      print("dio xatosi $e");
    }catch(e) {
      print('Bu oddi xato $e');
    }
    return UserModel.fromJson(response.data['data']);
  }

  Future<String> resetPasswords(String email) async {
    return '';
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final response = await _dio.post(
        "/logout",
      );
      await prefs.remove('userData');
      prefs.remove("token");
    } on DioException {
      rethrow;
    } catch (e) {
      print("Error:  $e");
      rethrow;
    }
  }

  Future<String?> socialLogin(SocialLoginRequest request) async{
    try {
      final response = await _dio.post(
        '/social-login',
        data: request.toMap(),
      );
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("token", "${response.data['data']['token']}");
    } on DioException catch (e) {
      return "Something went wrong!";
    } catch (e) {
      return "Something went wrong!";
    }
  }
}
