import 'package:dars_81_home/bloc/admin_bloc/admin_bloc.dart';
import 'package:dars_81_home/bloc/admin_bloc/admin_bloc_event.dart';
import 'package:dars_81_home/bloc/admin_bloc/admin_bloc_state.dart';
import 'package:dars_81_home/ui/widgets/admin_screen/show_all_admins.dart';
import 'package:dars_81_home/ui/widgets/admin_screen/show_all_students.dart';
import 'package:dars_81_home/ui/widgets/admin_screen/show_all_teachers.dart';
import 'package:dars_81_home/ui/widgets/dashboard/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<AdminBloc>().add(GetAllUserAdminBlocEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: const [
            Tab(text: "Students"),
            Tab(text: "Teachers"),
            Tab(text: "Admins"),
          ],
        ),
      ),
      body: BlocBuilder<AdminBloc, AdminBlocState>(
        builder: (context, state) {

          if(state is LoadingAdminBlocState){
            return const Center(child: CircularProgressIndicator(color: Colors.red,),);
          }

          if(state is LoadedAdminBlocState){
            return TabBarView(
              controller: _tabController,
              children: [
                Center(child: ShowAllStudents(users: state.users,)),
                Center(child: ShowAllTeachers(users: state.users,)),
                Center(child: ShowAllAdmins(users: state.users,)),
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
