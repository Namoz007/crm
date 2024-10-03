import 'package:dars_81_home/bloc/room_bloc/room_bloc.dart';
import 'package:dars_81_home/bloc/room_bloc/room_bloc_event.dart';
import 'package:dars_81_home/data/model/room_model.dart';
import 'package:dars_81_home/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditRoom extends StatefulWidget {
  Room room;
  EditRoom({
    super.key,
    required this.room,
  });

  @override
  State<EditRoom> createState() => _EditRoomState();
}

class _EditRoomState extends State<EditRoom> {
  final _formKey = GlobalKey<FormState>();
  final _roomName = TextEditingController();

  @override
  void initState() {
    super.initState();
  _roomName.text = widget.room.name;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Edit room"),
      content: Form(
        key: _formKey,
        child: TextFormField(
          validator: (value){
            if(value == null || value.isEmpty){
              return "Please,return input room name";
            }
            return null;
          },
          // initialValue: widget.room.name,
          controller: _roomName,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: "Room name",
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
                context.read<RoomBloc>().add(UpdateRoomBlocEvent(id: widget.room.id, name: _roomName.text,),);
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),),
      ],
    );
  }
}
