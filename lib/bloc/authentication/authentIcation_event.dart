import 'package:dars_81_home/bloc/authentication/authentication_bloc.dart';
import 'package:dars_81_home/data/model/login_request_model.dart';
import 'package:dars_81_home/data/model/registration_model.dart';

sealed class AuthenticationEvent{}

final class StartAuthenticationEvent extends AuthenticationEvent{}

final class LogInAuthenticationEvent extends AuthenticationEvent{
  LoginRequestModel requestModel;

  LogInAuthenticationEvent({required this.requestModel,});
}

final class ClearErrorMessageAuthenticationEvent extends AuthenticationEvent{}

final class SignUpAuthenticationEvent extends AuthenticationEvent{
  RegistrationModel model;

  SignUpAuthenticationEvent({required this.model});
}

final class ForgotPasswordAuthenticationEvent extends AuthenticationEvent{
  String email;

  ForgotPasswordAuthenticationEvent(this.email);
}

final class LogOutAuthenticationEvent extends AuthenticationEvent{}

final class SocialLoginAuthenticationEvent extends AuthenticationEvent{
  SocialLoginTypes type;

  SocialLoginAuthenticationEvent({required this.type,});
}