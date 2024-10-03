import 'package:dars_81_home/data/model/login_request_model.dart';
import 'package:dars_81_home/data/model/registration_model.dart';
import 'package:dars_81_home/data/model/social_login_request.dart';
import 'package:dars_81_home/data/model/user_model.dart';
import 'package:dars_81_home/services/authentication_services.dart';
import 'package:dars_81_home/utils/internet_analist.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationRepositories{
  final AuthenticationServices _services;

  AuthenticationRepositories({required AuthenticationServices servic}) : _services = servic;

  Future<bool> userLoged() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("token") != null;
  }

  Future<UserModel> getMyuser() async{
    return await _services.getMyUser();
  }

  Future<String> signInUser(LoginRequestModel model) async{
    if(await internetConnect()){
      return await _services.signInOrSignUp(query: "signin",model: model);
    }
    return 'Not Connect Internet';
  }

  Future<String> signUpUser(RegistrationModel model) async{
    if(await internetConnect()){
      return await _services.signInOrSignUp(query: 'signup',registerModel: model);
    }else{
      return "Not Connected Internet";
    }
  }

  Future<String> resetPassword(String email) async{
    return await _services.resetPasswords(email);
  }

  Future<void> logOut() async{
    await _services.logout();
  }

  Future<String?> socialLogin(SocialLoginRequest request) async{
    return await _services.socialLogin(request);
  }
}