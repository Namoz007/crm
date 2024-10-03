import 'package:dars_81_home/bloc/admin_bloc/admin_bloc.dart';
import 'package:dars_81_home/bloc/admin_bloc/admin_bloc_event.dart';
import 'package:dars_81_home/bloc/admin_bloc/admin_bloc_state.dart';
import 'package:dars_81_home/data/model/user_model.dart';
import 'package:dars_81_home/ui/widgets/admin_screen/show_user_for_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowAllAdmins extends StatefulWidget {
  List<UserModel> users;
  ShowAllAdmins({
    super.key,
    required this.users,
  });

  @override
  State<ShowAllAdmins> createState() => _ShowAllAdminsState();
}

class _ShowAllAdminsState extends State<ShowAllAdmins> {
  @override
  void initState() {
    super.initState();
    context.read<AdminBloc>().add(GetAllAdminBlocEvent());
  }

  @override
  Widget build(BuildContext context) {
    return widget.users.length == 0 ? const Center(child: Text("Admins not found!"),) : ListView.builder(
      itemCount: widget.users.length,
      itemBuilder: (context, index) {
        return ShowUserForAdmin(user: widget.users[index]);
      },
    );
  }
}
