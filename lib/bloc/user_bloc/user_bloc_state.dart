import 'package:dars_81_home/data/model/user_model.dart';

sealed class UserBlocState{}

final class InitialUserBlocState extends UserBlocState{}

final class LoadingUserBlocState extends UserBlocState{}

final class LoadedUserBlocState extends UserBlocState{
  UserModel model;

  LoadedUserBlocState(this.model);
}

final class ErrorUserBlocState extends UserBlocState{
  String message;

  ErrorUserBlocState(this.message);
}