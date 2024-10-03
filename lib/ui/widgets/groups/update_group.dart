
import 'package:dars_81_home/bloc/admin_bloc/admin_bloc.dart';
import 'package:dars_81_home/bloc/admin_bloc/admin_bloc_event.dart';
import 'package:dars_81_home/bloc/admin_bloc/admin_bloc_state.dart';
import 'package:dars_81_home/bloc/group_bloc/group_bloc.dart';
import 'package:dars_81_home/bloc/group_bloc/group_bloc_event.dart';
import 'package:dars_81_home/bloc/subject_bloc/subject_bloc.dart';
import 'package:dars_81_home/bloc/subject_bloc/subject_bloc_state.dart';
import 'package:dars_81_home/data/model/class_model.dart';
import 'package:dars_81_home/data/model/group.dart';
import 'package:dars_81_home/data/model/subject_model.dart';
import 'package:dars_81_home/data/model/teacher.dart';
import 'package:dars_81_home/data/model/user_model.dart';
import 'package:dars_81_home/ui/widgets/groups/add_class_for_group.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class UpdateGroup extends StatefulWidget {
  bool isUpdate;
  Group? group;
  UpdateGroup({super.key, required this.isUpdate, this.group});

  @override
  State<UpdateGroup> createState() => _UpdateGroupState();
}

class _UpdateGroupState extends State<UpdateGroup> {
  final _fromKey = GlobalKey<FormState>();
  final _groupNewName = TextEditingController();
  Teacher? _mainTeacher;
  Teacher? _assistantTeacher;
  Student _selectStudent = Student(id: 0, name: "Choose Students");
  SubjectModel? _subjectModel;
  List<Student> _students = [];
  List<int> studentsId = [];
  List<ClassModel> _classes = [];
  String? error;

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      _mainTeacher = widget.group!.mainTeacher;
      _assistantTeacher = widget.group!.assistantTeacher;
      _groupNewName.text = widget.group!.name;
      _students = widget.group!.students;
      studentsId.addAll(widget.group!.students.map((_element) => _element.id));
      _subjectModel = widget.group!.subject;
      _classes = widget.group!.classes;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${widget.isUpdate ? "Update Group" : "New group"}"),
      content: BlocBuilder<AdminBloc, AdminBlocState>(
        builder: (context, state) {
          if (state is LoadedAllTeachersStudentsAdminBlocState) {
            if (!widget.isUpdate &&
                state.teachers.isNotEmpty &&
                _mainTeacher == null) {
              _mainTeacher = state.teachers.first;
            }

            if (!widget.isUpdate &&
                state.teachers.length > 1 &&
                _assistantTeacher == null) {
              _assistantTeacher = state.teachers
                  .firstWhere((teacher) => teacher.id != _mainTeacher?.id);
            }

            List<Teacher> availableTeachers = state.teachers
                .where((teacher) =>
                    teacher.id != _mainTeacher?.id &&
                    teacher.id != _assistantTeacher?.id)
                .toList();

            return state.teachers.length < 2 || state.students.isEmpty
                ? const Center(
                    widthFactor: 100,
                    child: Text(
                      "You cannot create a group",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  )
                : Form(
                    key: _fromKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please input group name";
                            }
                            return null;
                          },
                          controller: _groupNewName,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'Group name',
                          ),
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<Teacher>(
                          value: _mainTeacher,
                          decoration: const InputDecoration(
                            labelText: 'Main Teacher',
                          ),
                          items: [
                            DropdownMenuItem(
                              value: _mainTeacher,
                              child: Text(
                                _mainTeacher != null
                                    ? '${_mainTeacher!.name}'
                                    : 'Choose main teacher',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            ...availableTeachers.map(
                              (teacher) => DropdownMenuItem<Teacher>(
                                value: teacher,
                                child: Text(
                                  teacher.name,
                                  style: TextStyle(
                                    color: teacher.id ==
                                            widget.group?.mainTeacher.id
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _mainTeacher = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<Teacher>(
                          value: _assistantTeacher,
                          decoration: const InputDecoration(
                            labelText: 'Assistant Teacher',
                          ),
                          items: [
                            DropdownMenuItem(
                              value: _assistantTeacher,
                              child: Text(
                                _assistantTeacher != null
                                    ? '${_assistantTeacher!.name}'
                                    : 'Choose assistant teacher',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            ...availableTeachers.map(
                              (teacher) => DropdownMenuItem<Teacher>(
                                value: teacher,
                                child: Text(
                                  teacher.name,
                                  style: TextStyle(
                                    color: teacher.id ==
                                            widget.group?.assistantTeacher.id
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _assistantTeacher = value;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<Student>(
                          value: _selectStudent,
                          decoration: const InputDecoration(
                            labelText: 'Students',
                          ),
                          items: [
                            DropdownMenuItem(
                              value: _selectStudent,
                              child: const Text(
                                'Choose students',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            ...state.students.map(
                              (student) => DropdownMenuItem<Student>(
                                value: student,
                                child: Text(
                                  student.name,
                                  style: TextStyle(
                                    color: studentsId.contains(student.id)
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              if (studentsId.contains(value!.id)) {
                                studentsId.remove(value.id);
                                _students.removeWhere(
                                    (element) => element.id == value.id);
                              } else {
                                studentsId.add(value.id);
                                _students.add(value);
                              }
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BlocBuilder<SubjectBloc, SubjectBlocState>(
                          builder: (context, state) {
                            if (state is LoadedAllSubjectsSubjectBlocState) {
                              if(_subjectModel == null && state.subjects.length != 0){
                                _subjectModel = state.subjects[0];
                              }
                              return DropdownButtonFormField<SubjectModel>(
                                // value: _subjectModel,
                                decoration: const InputDecoration(
                                  labelText: 'Subjects',
                                ),
                                items: [
                                  ...state.subjects.map(
                                    (subject) => DropdownMenuItem<SubjectModel>(
                                      value: subject,
                                      child: Text(
                                        subject.name,
                                        style: TextStyle(
                                          color: subject.id == _subjectModel!.id
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _subjectModel = value;
                                  });
                                },
                              );
                            }

                            return Shimmer.fromColors(
                              child: Container(
                                width: double.infinity,
                                height: 20,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                              ),
                              baseColor: Colors.grey,
                              highlightColor: Colors.white,
                            );
                          },
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Classes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,),),
                            const SizedBox(width: 10,),
                            InkWell(
                              onTap: () async{
                                final data = await showDialog(context: context, builder: (context) => const AddClassForGroup(),barrierDismissible: false);
                                if(data != null){
                                  data as ClassModel;
                                  if(widget.isUpdate){
                                    data.groupId = widget.group!.id;
                                  }
                                  _classes.add(data);
                                  print(data.startTime);
                                  print(data.endTime);
                                  setState(() {
                                  });
                                }
                              },
                              child: const Icon(Icons.add,),
                            )
                          ],
                        ),
                        const SizedBox(height: 10,),
                        if(widget.isUpdate)
                          for(int i = 0;i < _classes.length;i++)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Day: ${_classes[i].day.name}",style: const TextStyle(fontWeight: FontWeight.bold,),),
                                Text("Room: ${_classes[i].room.name}",style: const TextStyle(fontWeight: FontWeight.bold,),),
                                InkWell(
                                  onTap: (){
                                    _classes.removeWhere((value) => value.id == widget.group!.classes[i].id);
                                    setState(() {
                                    });
                                  },
                                  child: const Icon(Icons.delete,color: Colors.red,),
                                ),
                              ],
                            ),
                      ],
                    ),
                  );
          }
          return const CircularProgressIndicator();
        },
      ),
      actions: [
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        FilledButton(
          onPressed: () {
            if (_fromKey.currentState!.validate()) {
              if (widget.isUpdate) {
                widget.group!.students = _students;
                widget.group!.name = _groupNewName.text;
                widget.group!.assistantTeacher = _assistantTeacher!;
                widget.group!.mainTeacher = _mainTeacher!;
                widget.group!.updatedAt = DateTime.now();
                widget.group!.mainTeacherId = _mainTeacher!.id;
                widget.group!.assistantTeacherId = _assistantTeacher!.id;
                widget.group!.subject = _subjectModel!;
                widget.group!.classes = _classes;
                context.read<GroupBloc>().add(UpdateGroupBlocEvent(widget.group!));
              } else {
                context.read<GroupBloc>().add(
                      CreateNewGroupBlocEvent(
                        Group(
                          id: 0,
                          name: _groupNewName.text,
                          mainTeacherId: _mainTeacher!.id,
                          assistantTeacherId: _assistantTeacher!.id,
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                          mainTeacher: _mainTeacher!,
                          assistantTeacher: _assistantTeacher!,
                          students: _students,
                          subject: _subjectModel!,
                          classes: _classes,
                        ),
                      ),
                    );
              }
              Navigator.pop(context);
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
