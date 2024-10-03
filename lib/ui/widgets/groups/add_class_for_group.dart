import 'package:dars_81_home/bloc/room_bloc/room_bloc.dart';
import 'package:dars_81_home/bloc/room_bloc/room_bloc_event.dart';
import 'package:dars_81_home/bloc/room_bloc/room_bloc_state.dart';
import 'package:dars_81_home/data/model/class_model.dart';
import 'package:dars_81_home/data/model/day_model.dart';
import 'package:dars_81_home/data/model/room_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class AddClassForGroup extends StatefulWidget {
  const AddClassForGroup({super.key});

  @override
  State<AddClassForGroup> createState() => _AddClassForGroupState();
}

class _AddClassForGroupState extends State<AddClassForGroup> {
  Room? _room;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  final Map<int, String> daysOfWeek = {
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
    7: "Sunday"
  };
  int selectedDayId = 1;
  Day? _day;
  String? _error;

  @override
  void initState() {
    super.initState();
    _day = Day(id: 1, name: daysOfWeek[1]!);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add new day'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_error != null)
            Center(
              child: Text(
                _error!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Lesson day:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton(
                hint: Text(
                  "${daysOfWeek[selectedDayId]}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                items: daysOfWeek.entries.map((entry) {
                  return DropdownMenuItem<int>(
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDayId = value!;
                    _day = Day(id: value!, name: daysOfWeek[value]!);
                  });
                },
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
                "Lesson start time:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () async {
                  final data = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (data != null) {
                    setState(() {
                      _startTime = data;
                      if (_startTime != null &&
                          _endTime != null &&
                          _startTime == _endTime) {
                        _error = 'The times should not be the same';
                      } else {
                        _error = null;
                      }
                    });
                  }
                },
                child: Text(
                  "${_startTime != null ? "${_startTime!.hour}:${_startTime!.minute}" : "not found!"}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
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
                "Lesson end time:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () async {
                  final data = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (data != null) {
                    setState(() {
                      _endTime = data;
                      if (_startTime != null &&
                          _endTime != null &&
                          _startTime == _endTime) {
                        _error = 'The times should not be the same';
                      } else {
                        _error = null;
                      }
                    });
                  }
                },
                child: Text(
                  "${_endTime != null ? "${_endTime!.hour}:${_endTime!.minute}" : "not found!"}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          _startTime != null && _endTime != null && _startTime != _endTime
              ? BlocBuilder<RoomBloc, RoomBlocState>(
                  bloc: context.read<RoomBloc>()
                    ..add(GetAllAvailableRoomBlocEvent(
                        dayId: selectedDayId,
                        startTime: "${_startTime!.hour.toString().length == 1 ? "0${_startTime!.hour}" : _startTime!.hour}:${_startTime!.minute.toString().length == 1 ? "0${_startTime!.minute}": _startTime!.minute}",
                        endTime: "${_endTime!.hour.toString().length == 1 ? '0${_endTime!.hour}' : _endTime!.hour}:${_endTime!.minute.toString().length == 1 ? "0${_endTime!.minute}" : _endTime!.minute}")),
                  builder: (context, state) {
                    if (state is LoadingRoomBlocState) {
                      return Shimmer.fromColors(
                        baseColor: Colors.green,
                        highlightColor: Colors.yellow,
                        child: const Center(
                          child: Text(
                            "Available rooms finding!",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }

                    if (state is LoadedRoomsRoomBlocState) {
                      return state.rooms.length == 0 ? const Center(child: Text("No room found for this time!",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,),),) : DropdownButton(
                        hint: _room?.name == null ? const Text(
                          "Choose rooms",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ) : Text("${_room!.name}",style: TextStyle(fontWeight: FontWeight.bold,),),
                        items: state.rooms
                            .map(
                              (value) => DropdownMenuItem(
                            child: Text(
                              "${value.name}",
                            ),
                            value: value,
                          ),
                        )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _room = value as Room;
                          });
                        },
                      );
                    }

                    return const SizedBox();
                  },
                )
              : const SizedBox(),
        ],
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
            if (_room != null &&
                _startTime != null &&
                _endTime != null &&
                _day != null) {
              Navigator.of(context).pop(
                ClassModel(
                  id: 0,
                  groupId: 0,
                  roomId: _room!.id,
                  dayId: selectedDayId,
                  startTime: "${_startTime!.hour.toString().length == 1 ? "0${_startTime!.hour}" : _startTime!.hour}:${_startTime!.minute.toString().length == 1 ? "0${_startTime!.minute}": _startTime!.minute}",
                  endTime: "${_endTime!.hour.toString().length == 1 ? '0${_endTime!.hour}' : _endTime!.hour}:${_endTime!.minute.toString().length == 1 ? "0${_endTime!.minute}" : _endTime!.minute}",
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                  day: _day!,
                  room: _room!,
                ),
              );
            } else {
              setState(() {
                _error = 'The daily lesson schedule was not correctly made';
              });
            }
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}
