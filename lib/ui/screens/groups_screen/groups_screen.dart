import 'package:dars_81_home/bloc/admin_bloc/admin_bloc.dart';
import 'package:dars_81_home/bloc/admin_bloc/admin_bloc_event.dart';
import 'package:dars_81_home/bloc/group_bloc/grou_bloc_state.dart';
import 'package:dars_81_home/bloc/group_bloc/group_bloc.dart';
import 'package:dars_81_home/bloc/group_bloc/group_bloc_event.dart';
import 'package:dars_81_home/bloc/subject_bloc/subject_bloc.dart';
import 'package:dars_81_home/bloc/subject_bloc/subject_bloc_event.dart';
import 'package:dars_81_home/ui/screens/groups_screen/show_group.dart';
import 'package:dars_81_home/ui/widgets/groups/show_group.dart';
import 'package:dars_81_home/ui/widgets/groups/update_group.dart';
import 'package:dars_81_home/ui/widgets/dashboard/custom_drawer.dart';
import 'package:dars_81_home/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GroupBloc>().add(GetAllGroupsGroupBlocEvent());
    if(AppUtils.userModel!.roleId == 3){
      context.read<AdminBloc>().add(GetAllMyTeachersStudentsAdminBlocEvent());
      context.read<SubjectBloc>().add(GetAllSubjectBlocEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groups'),
        centerTitle: true,
        actions: [
          AppUtils.userModel!.roleId == 3
              ? InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) => UpdateGroup(isUpdate: false),
                        barrierDismissible: false);
                  },
                  child: const Icon(Icons.add),
                )
              : const SizedBox(),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: RefreshIndicator(
        onRefresh: () async {
          context
              .read<GroupBloc>()
              .add(GetAllGroupFromServicesGroupBlocEvent());
        },
        child: BlocBuilder<GroupBloc, GroupBlocState>(
          builder: (context, state) {
            if (state is LoadingGroupBlocState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Shimmer(
                    direction: ShimmerDirection.ltr,
                    gradient: LinearGradient(
                      colors: [
                        Colors.grey.shade300,
                        Colors.grey.shade300,
                        Colors.white,
                        Colors.grey.shade300,
                        Colors.grey.shade400,
                      ],
                    ),
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.red,),
                    ),
                  );
                },
              );
            }

            if (state is LoadedGroupsGroupBlocState) {
              return state.groups.length == 0
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Your groups not found!"),
                          const SizedBox(height: 10,),
                          InkWell(
                            onTap: (){
                              context.read<GroupBloc>().add(GetAllGroupFromServicesGroupBlocEvent());
                            },
                            child: const Icon(Icons.refresh),
                          )
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.groups.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowGroupScreen(
                                        group: state.groups[index])));
                          },
                          child: ShowGroup(
                            group: state.groups[index],
                          ),
                        );
                      },
                    );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
