import 'package:bloc/bloc.dart';
import 'package:dars_81_home/bloc/authentication/authentIcation_event.dart';
import 'package:dars_81_home/bloc/authentication/authentication_state.dart';
import 'package:dars_81_home/data/model/social_login_request.dart';
import 'package:dars_81_home/data/repositories/authentication_repositories.dart';
import 'package:dars_81_home/utils/app_utils.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum SocialLoginTypes { google, facebook }

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState>{
  final AuthenticationRepositories _repositories;
  AuthenticationBloc({required AuthenticationRepositories repo}) : _repositories = repo,super(InitialAuthenticationState()){
    on<StartAuthenticationEvent>(_startAuthentication);
    on<SignUpAuthenticationEvent>(_signUpAuthentication);
    on<LogInAuthenticationEvent>(_signInAuthentication);
    on<LogOutAuthenticationEvent>(_logOutUser);
    on<ClearErrorMessageAuthenticationEvent>(_clearErrorMessage);
    on<SocialLoginAuthenticationEvent>(_socialLogin);
  }

  void _socialLogin(SocialLoginAuthenticationEvent event,emit) async{
    emit(LoadingAuthenticationState());
    try {
      SocialLoginRequest? request;
      switch (event.type) {
        case SocialLoginTypes.google:
          const List<String> scopes = <String>['email'];
          final googleSignIn = GoogleSignIn(scopes: scopes);
          final googleUser = await googleSignIn.signIn();
          if (googleUser != null) {
            request = SocialLoginRequest(name: googleUser.displayName ?? '', email: googleUser.email,);

          }
          break;
        case SocialLoginTypes.facebook:
          final result = await FacebookAuth.instance.login();
          if (result.status == LoginStatus.success) {
            print('keldi');
            final userData = await FacebookAuth.i.getUserData(
              fields: "name,email",
            );
            print('tayyor');
            request = SocialLoginRequest(
              name: userData['name'] ?? '',
              email: userData['email'],
            );
          }
          break;
        default:
          return;
      }

      if (request != null) {
        final response = await _repositories.socialLogin(request);
        if(response == null){
          emit(AuthenticatedAuthenticationState());
        }else{
          emit(UnAuthenticatedAuthenticationState());
        }
      } else {
        emit(ErrorAuthenticationState("Something went wrong!"));
      }
    } catch (e) {
      emit(UnAuthenticatedAuthenticationState());
    }
  }

  void _clearErrorMessage(ClearErrorMessageAuthenticationEvent event,emit){
    emit(ErrorAuthenticationState(''));
  }

  // void _forgotPassword(ForgotPasswordAuthenticationEvent event,emit){
  //   _repositories.resetPassword(event.email);
  //   emit(LoadedAuthenticationState());
  // }

  void _signInAuthentication(LogInAuthenticationEvent event,emit) async{
    emit(LoadingAuthenticationState());
    final response = await _repositories.signInUser(event.requestModel);
    if(response == ''){
      final a = await _repositories.getMyuser();
      emit(ComedUserAuthenticationState(a));
    }else{
      emit(ErrorAuthenticationState(response));
    }
  }

  void _signUpAuthentication(SignUpAuthenticationEvent event,emit) async{
    emit(LoadingAuthenticationState());
    final response = await _repositories.signUpUser(event.model);
    if(response == ''){
      emit(ComedUserAuthenticationState(await _repositories.getMyuser()));
    }else{
      emit(ErrorAuthenticationState(response));
    }
  }

  void _startAuthentication(StartAuthenticationEvent event,emit) async{
    emit(LoadingAuthenticationState());
    final response = await _repositories.userLoged();
    if(response){
      emit(ComedUserAuthenticationState(await _repositories.getMyuser()));
    }else{
      emit(UnAuthenticatedAuthenticationState());
    }
  }

  void _logOutUser(LogOutAuthenticationEvent event,emit) {
    emit(LoadingAuthenticationState());
    _repositories.logOut();
    emit(UnAuthenticatedAuthenticationState());
  }
}