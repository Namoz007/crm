import 'dart:io';

import 'package:dars_81_home/data/model/user_model.dart';
import 'package:dars_81_home/services/dio_file.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  final _dio = DioFile.getInstance().dio;

  Future<UserModel> getMyUser() async {
    dynamic response = '';
    try {
      response = await _dio.get(
        "/user",
      );
    } on DioException catch (e) {
      print("dio xatosi $e");
    } catch (e) {
      print('Bu oddi xato $e');
    }
    return UserModel.fromJson(response.data['data']);
  }

  Future<String?> updateProfile(
    String name,
    String email,
    String phoneNumber,
    File? file,
  ) async {
    try {
      dynamic response = '';
      if (file != null) {
        FormData formData = FormData.fromMap({
          "photo": await MultipartFile.fromFile(
            file.path,
            filename: 'new.jpg',
          ),
          "name": name,
          "email": email,
          "phone": phoneNumber,
        });
        response = await _dio.post("/profile/update",data: formData);
      } else {
        response = await _dio.post(
          "/profile/update",
          data: FormData.fromMap(
            {
              "name": name,
              "email": email,
              "phone": phoneNumber,
            },
          ),
        );
      }
      return response.data['data']['photo'];
    } on DioException catch (e) {
      print("dio xato ${e.response?.data}");
    } catch (e) {
      print("oddiy xato ${e}");
    }
  }
}
