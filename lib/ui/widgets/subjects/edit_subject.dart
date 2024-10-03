import 'package:dars_81_home/bloc/subject_bloc/subject_bloc.dart';
import 'package:dars_81_home/bloc/subject_bloc/subject_bloc_event.dart';
import 'package:dars_81_home/data/model/subject_model.dart';
import 'package:dars_81_home/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditSubject extends StatefulWidget {
  bool isUpdate;
  SubjectModel? subjectModel;
  EditSubject({
    super.key,
    required this.isUpdate,
    this.subjectModel,
  });

  @override
  State<EditSubject> createState() => _EditSubjectState();
}

class _EditSubjectState extends State<EditSubject> {
  final _formKey = GlobalKey<FormState>();
  final _subjectNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${widget.isUpdate ? "Update Subject" : "New Subject"}"),
      content: Form(
        key: _formKey,
        child: TextFormField(
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Please,return input subject name";
            }

            return null;
          },
          controller: _subjectNameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: widget.isUpdate
                ? "${widget.subjectModel!.name}"
                : "Subject name",
          ),
        ),
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
            if(_formKey.currentState!.validate()){
              if(widget.isUpdate){
                widget.subjectModel!.name = _subjectNameController.text;
                context.read<SubjectBloc>().add(UpdateSubjectSubjectBlocEvent(subject: widget.subjectModel!));
              }else{
                context.read<SubjectBloc>().add(CreateNewSubjectBlocEvent(name: _subjectNameController.text));
              }
              Navigator.pop(context);
            }
          },
          child: Text(widget.isUpdate ? "Save" : "Create"),
        ),
      ],
    );
  }
}
