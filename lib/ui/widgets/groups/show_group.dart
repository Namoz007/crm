import 'package:dars_81_home/bloc/admin_bloc/admin_bloc.dart';
import 'package:dars_81_home/bloc/admin_bloc/admin_bloc_event.dart';
import 'package:dars_81_home/bloc/group_bloc/group_bloc.dart';
import 'package:dars_81_home/bloc/group_bloc/group_bloc_event.dart';
import 'package:dars_81_home/data/model/group.dart';
import 'package:dars_81_home/main.dart';
import 'package:dars_81_home/ui/widgets/groups/update_group.dart';
import 'package:dars_81_home/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowGroup extends StatefulWidget {
  Group group;
  ShowGroup({super.key, required this.group});

  @override
  State<ShowGroup> createState() => _ShowGroupState();
}

class _ShowGroupState extends State<ShowGroup> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppUtils.userModel!.roleId == 3 ? InkWell(onTap: (){
                context.read<GroupBloc>().add(DeleteGroupGroupBlocEvent(widget.group.id));
                // context.read<AdminBloc>().add(DeleteGroupAdminBlocEvent(widget.group.id));
              },child: const Icon(Icons.delete,color: Colors.red,),) : const SizedBox(),
              Text(
                "${widget.group.name}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              AppUtils.userModel!.roleId == 3
                  ? InkWell(
                onTap: (){
                  showDialog(context: context, builder: (context) => UpdateGroup(isUpdate: true,group: widget.group,),barrierDismissible: false);
                },
                      child: const Icon(Icons.edit_calendar),
                    )
                  : const SizedBox(),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Main teacher:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widget.group.mainTeacher.name}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Assistant teacher:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widget.group.assistantTeacher.name}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Group created:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widget.group.createdAt.day}/${widget.group.createdAt.month}/${widget.group.createdAt.year}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Students count:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widget.group.students.length}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Group update at:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${widget.group.updatedAt.day}/${widget.group.updatedAt.month}/${widget.group.updatedAt.year}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              
            ],
          ),
          
          const SizedBox(height: 10,),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Group subject:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,),),
              
              Text("${widget.group.subject.name}",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,),)
            ],
          ),
          const SizedBox(height: 10,),
         for(int i = 0; i < widget.group.classes.length; i++)
           Column(
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("${i + 1}.Group Class:",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 14,),),

                   Text("${widget.group.classes[i].room.name}",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,),)
                 ],
               ),
               const SizedBox(height: 10,),

               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,

                 children: [
                   const Text("Lesson day:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,),),

                   Text("${widget.group.classes[i].day.name}",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,),)
                 ],
               ),
               const SizedBox(height: 10,),

               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,

                 children: [
                   const Text("Lesson start time:",style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14,),),

                   Text("${widget.group.classes[i].startTime}",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,),)
                 ],
               ),

               const SizedBox(height: 10,),

               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,

                 children: [
                   const Text("Lesson end time:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,),),

                   Text("${widget.group.classes[i].endTime}",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,),)
                 ],
               ),
             ],
           )
        ],
      ),
    );
  }
}
