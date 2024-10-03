import 'package:dars_81_home/bloc/user_bloc/user_bloc.dart';
import 'package:dars_81_home/bloc/user_bloc/user_bloc_event.dart';
import 'package:dars_81_home/bloc/user_bloc/user_bloc_state.dart';
import 'package:dars_81_home/bloc/working_hour_bloc/working_bloc.dart';
import 'package:dars_81_home/bloc/working_hour_bloc/working_bloc_event.dart';
import 'package:dars_81_home/main.dart';
import 'package:dars_81_home/ui/widgets/dashboard/appbar_title.dart';
import 'package:dars_81_home/ui/widgets/dashboard/custom_drawer.dart';
import 'package:dars_81_home/ui/widgets/dashboard/show_workloads.dart';
import 'package:dars_81_home/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetMyUserBlocEvent());
    context.read<WorkingBloc>().add(GetMyWorkingBlocEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F9FD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F9FD),
        toolbarHeight: 100,
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
            screenTitle: 'dashboard',
          ),
        ),
      ),
      drawer: const CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: () async{
          context.read<UserBloc>().add(RefreshMyUserUserBlocEvent());
        },
        child: SingleChildScrollView(
          child: BlocBuilder<UserBloc, UserBlocState>(
            builder: (context, state) {
              if (state is LoadingUserBlocState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.red,
                  ),
                );
              }

              if (state is LoadedUserBlocState) {
                AppUtils.userModel = state.model;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome back, ${state.model.roleName} ${state.model.name}!",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Dashboard",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE6EDF5),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.calendar_today_outlined),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Nov 16,2020 - Dec 16,2020",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          // margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.2,
                              )),
                          child: ShowWorkloads(),
                        )
                      ],
                    ),
                  ),
                );
              }

              return Container();
            },
          ),
        ),
      ),
    );
  }
}
