import 'dart:io';

import 'package:dars_81_home/data/model/user_model.dart';

sealed class UserBlocEvent{}

final class ComedUserBlocEvent extends UserBlocEvent{
  UserModel userModel;

  ComedUserBlocEvent(this.userModel);
}

final class GetMyUserBlocEvent extends UserBlocEvent{}

final class UpdateMyUserBlocEvent extends UserBlocEvent{
  String email;
  String phoneNumber;
  String name;
  File? imgFile;
  UpdateMyUserBlocEvent({required this.email,required this.phoneNumber,required this.name,this.imgFile,});
}

final class RefreshMyUserUserBlocEvent extends UserBlocEvent{}

final class LogOutUserBlocEvent extends UserBlocEvent{}