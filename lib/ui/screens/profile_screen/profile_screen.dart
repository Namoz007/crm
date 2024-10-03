import 'package:dars_81_home/bloc/user_bloc/user_bloc.dart';
import 'package:dars_81_home/bloc/user_bloc/user_bloc_state.dart';
import 'package:dars_81_home/ui/widgets/dashboard/appbar_title.dart';
import 'package:dars_81_home/ui/widgets/profile/my_datas.dart';
import 'package:dars_81_home/ui/widgets/profile/title_for_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../bloc/user_bloc/user_bloc_event.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F9FD),
        title: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          child: AppbarTitle(
            screenTitle: 'profile_screen',
          ),
        ),
        toolbarHeight: 100,
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          context.read<UserBloc>().add(RefreshMyUserUserBlocEvent());
        },
        child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<UserBloc, UserBlocState>(
            builder: (context, state) {

              if(state is LoadingUserBlocState){
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.white,
                  child: Container(
                    width: double.infinity,
                    height: 750,
                    color: Colors.black,
                  ),
                );
              }

              if(state is LoadedUserBlocState){
                return Column(
                  children: [
                    TitleForProfile(),
                    const SizedBox(height: 20,),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black,width: 0.2),
                      ),
                      child: MyDatas(model: state.model,),
                    )
                  ],
                );
              }

              if(state is ErrorUserBlocState){
                return Center(child: Text("${state.message}"),);
              }

              return Container();
            },
          ),
        ),
      ),),
    );
  }
}
