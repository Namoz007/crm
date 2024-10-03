import 'package:dars_81_home/bloc/authentication/authentIcation_event.dart';
import 'package:dars_81_home/bloc/authentication/authentication_bloc.dart';
import 'package:dars_81_home/bloc/user_bloc/user_bloc.dart';
import 'package:dars_81_home/bloc/user_bloc/user_bloc_state.dart';
import 'package:dars_81_home/main.dart';
import 'package:dars_81_home/ui/screens/dashboards/dashboard.dart';
import 'package:dars_81_home/ui/screens/profile_screen/profile_screen.dart';
import 'package:dars_81_home/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppbarTitle extends StatefulWidget {
  String screenTitle;
  AppbarTitle({
    super.key,
    required this.screenTitle,
  });

  @override
  State<AppbarTitle> createState() => _AppbarTitleState();
}

class _AppbarTitleState extends State<AppbarTitle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            if (widget.screenTitle != "dashboard") {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Dashboard()));
            }
          },
          child: SvgPicture.asset("assets/svgs/logo.svg"),
        ),
        Row(
          children: [
            const Icon(Icons.search),
            const SizedBox(
              width: 25,
            ),
            const Icon(Icons.notifications),
            const SizedBox(
              width: 25,
            ),
            InkWell(
              onTap: () {
                if (widget.screenTitle != "profile_screen") {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()));
                }
              },
              child: BlocBuilder<UserBloc, UserBlocState>(
                builder: (context, state) {

                  if(state is LoadedUserBlocState){
                    return Container(
                      height: 40,
                      width: 40,
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: NetworkImage(AppUtils.userModel?.photo == null || AppUtils.userModel!.photo == ''
                            ? "https://klike.net/uploads/posts/2023-01/1674365337_3-31.jpg"
                            : "http://millima.flutterwithakmaljon.uz/storage/avatars/${state.model.photo}"),fit: BoxFit.cover),
                      ),
                    );
                  }

                  return Container(
                    height: 40,
                    width: 40,
                    decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(AppUtils.userModel?.photo == null || AppUtils.userModel!.photo == ''
                          ? "https://klike.net/uploads/posts/2023-01/1674365337_3-31.jpg"
                          : "http://millima.flutterwithakmaljon.uz/storage/avatars/${AppUtils.userModel!.photo}"),fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
