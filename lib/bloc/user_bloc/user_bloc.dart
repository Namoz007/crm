import 'package:bloc/bloc.dart';
import 'package:dars_81_home/bloc/user_bloc/user_bloc_event.dart';
import 'package:dars_81_home/bloc/user_bloc/user_bloc_state.dart';
import 'package:dars_81_home/data/model/user_model.dart';
import 'package:dars_81_home/data/repositories/user_repositories.dart';
import 'package:dars_81_home/utils/app_utils.dart';

class UserBloc extends Bloc<UserBlocEvent,UserBlocState>{
  final UserRepositories _repositories;
  UserModel? model;

  UserBloc({required UserRepositories repo}) : _repositories = repo,super(InitialUserBlocState()){
    on<GetMyUserBlocEvent>(_getMyUser);
    on<UpdateMyUserBlocEvent>(_updateProfile);
    on<RefreshMyUserUserBlocEvent>(_refreshMyUser);
    on<LogOutUserBlocEvent>(_logOutUser);
    on<ComedUserBlocEvent>(_comedUser);
  }

  void _comedUser(ComedUserBlocEvent event,emit){
    model = event.userModel;
    // emit(LoadedUserBlocState(model!));
  }

  void _logOutUser(LogOutUserBlocEvent event,emit) {
    model = null;
  }

  void _refreshMyUser(RefreshMyUserUserBlocEvent event,emit) async{
    emit(LoadingUserBlocState());
    model = await _repositories.getMyUser();
    AppUtils.userModel = model;
    emit(LoadedUserBlocState(model!));
  }

  void _updateProfile(UpdateMyUserBlocEvent event,emit) async{
    emit(LoadingUserBlocState());
    if(event.imgFile != null && event.email == null){
      emit(ErrorUserBlocState("Email value not find!"));
    }else{
      final imgUrl = await _repositories.updateProfile(event.name, event.email, event.phoneNumber, event.imgFile);
      if(imgUrl != null){
        model!.photo = imgUrl;
      }
      model!.email = event.email;
      model!.name = event.name;
      model!.phone = event.phoneNumber;
      AppUtils.userModel = model;
      emit(LoadedUserBlocState(model!));
    }
  }

  void _getMyUser(GetMyUserBlocEvent event,emit) async{
    emit(LoadingUserBlocState());
    if(model == null){
      model = await _repositories.getMyUser();
      AppUtils.userModel = model;
    }
    emit(LoadedUserBlocState(model!));
  }
}