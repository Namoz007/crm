import 'package:dars_81_home/bloc/room_bloc/room_bloc.dart';
import 'package:dars_81_home/bloc/room_bloc/room_bloc_event.dart';
import 'package:dars_81_home/data/model/available_hour.dart';
import 'package:dars_81_home/data/model/day_model.dart';
import 'package:dars_81_home/data/model/room_model.dart';
import 'package:dars_81_home/main.dart';
import 'package:dars_81_home/ui/widgets/room_scree/add_room_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddRoom extends StatefulWidget {
  const AddRoom({
    super.key,
  });

  @override
  State<AddRoom> createState() => _AddAndEditRoomState();
}

class _AddAndEditRoomState extends State<AddRoom> {
  final _formKey = GlobalKey<FormState>();
  final _roomName = TextEditingController();
  final _roomDescription = TextEditingController();
  final _roomCapacity = TextEditingController();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String? error;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      alignment: Alignment.topCenter,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_startTime == null || _endTime == null) {
                        setState(() {
                          error = "Please,choose room start and end time";
                        });
                      } else {
                        setState(() {
                          error = null;
                        });
                        context.read<RoomBloc>().add(
                              CreateNewRoomBlocEvent(
                                Room(
                                  id: 0,
                                  name: _roomName.text,
                                  description: _roomDescription.text,
                                  capacity: int.parse(_roomCapacity.text),
                                  createdAt: DateTime.now(),
                                  updatedAt: DateTime.now(),
                                  availableHours: [
                                    AvailableHour(
                                        id: 1,
                                        roomId: 0,
                                        dayId: 1,
                                        startTime:
                                            "${_startTime!.hour}:${_startTime!.minute}",
                                        endTime:
                                            "${_endTime!.hour}:${_endTime!.minute}",
                                        createdAt: DateTime.now(),
                                        updatedAt: DateTime.now(),
                                        day: Day(id: 1, name: _roomName.text))
                                  ],
                                ),
                              ),
                            );
                        Navigator.pop(context);
                      }
                    }
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(child: error == null ? const SizedBox() : Text("${error}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.red),),),
            AddRoomFields(
                roomName: _roomName,
                roomDescription: _roomDescription,
                roomCapacity: _roomCapacity),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  final a = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: 0, minute: 0));
                  if (a != null) {
                    setState(() {
                      _startTime = a;
                    });
                  }
                },
                child: Text(
                  "${_startTime == null ? "Please, choose room start time" : "${_startTime!.hour}:${_startTime!.minute}"}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  final a = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: 0, minute: 0));
                  if (a != null) {
                    setState(() {
                      _endTime = a;
                    });
                  }
                },
                child: Text(
                  "${_endTime == null ? "Please, choose room end time" : "${_endTime!.hour}:${_endTime!.minute}"}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
