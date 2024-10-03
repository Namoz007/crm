import 'package:dars_81_home/bloc/admin_bloc/admin_bloc.dart';
import 'package:dars_81_home/bloc/admin_bloc/admin_bloc_event.dart';
import 'package:dars_81_home/data/model/user_model.dart';
import 'package:dars_81_home/main.dart';
import 'package:dars_81_home/ui/widgets/admin_screen/show_user_for_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowAllStudents extends StatefulWidget {
  List<UserModel> users;
  ShowAllStudents({super.key, required this.users});

  @override
  State<ShowAllStudents> createState() => _ShowAllStudentsState();
}

class _ShowAllStudentsState extends State<ShowAllStudents> {
  
  @override
  void initState() {
    super.initState();
    context.read<AdminBloc>().add(GetAllStudentAdminBlocEvent());
  }
  
  @override
  Widget build(BuildContext context) {
    return widget.users.length == 0 ? const Center(child: Text("Students not found!"),) : ListView.builder(
      itemCount: widget.users.length,
      itemBuilder: (context, index) {
        return ShowUserForAdmin(user: widget.users[index]);
      },
    );
  }
}
