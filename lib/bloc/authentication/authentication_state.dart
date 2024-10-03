import 'package:dars_81_home/data/model/user_model.dart';

sealed class AuthenticationState{}

final class InitialAuthenticationState extends AuthenticationState{}

final class LoadingAuthenticationState extends AuthenticationState{}

final class AuthenticatedAuthenticationState extends AuthenticationState{}

final class UnAuthenticatedAuthenticationState extends AuthenticationState{}

final class ComedUserAuthenticationState extends AuthenticationState{
  UserModel userModel;


  ComedUserAuthenticationState(this.userModel);
}

final class ErrorAuthenticationState extends AuthenticationState{
  String message;

  ErrorAuthenticationState(this.message);
}