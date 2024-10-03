import 'package:dars_81_home/bloc/authentication/authentIcation_event.dart';
import 'package:dars_81_home/bloc/authentication/authentication_bloc.dart';
import 'package:dars_81_home/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInWithApp extends StatefulWidget {
  const SignInWithApp({super.key});

  @override
  State<SignInWithApp> createState() => _SignInWithAppState();
}

class _SignInWithAppState extends State<SignInWithApp> {
  List<String> _signInOptions = [
    "facebook.png",
    "google.jpg"
  ];


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for(int i = 0;i < _signInOptions.length;i++)
          InkWell(
            onTap: (){
              if(i == 0){
                context.read<AuthenticationBloc>().add(SocialLoginAuthenticationEvent(type: SocialLoginTypes.facebook,));
              }else if(i == 1){
                context.read<AuthenticationBloc>().add(SocialLoginAuthenticationEvent(type: SocialLoginTypes.google));
              }
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage("assets/imgs/${_signInOptions[i]}"),fit: BoxFit.cover)
              ),
            ),
          ),
      ],
    );
  }
}
