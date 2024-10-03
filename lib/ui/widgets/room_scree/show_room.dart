import 'package:dars_81_home/bloc/room_bloc/room_bloc.dart';
import 'package:dars_81_home/bloc/room_bloc/room_bloc_event.dart';
import 'package:dars_81_home/data/model/room_model.dart';
import 'package:dars_81_home/main.dart';
import 'package:dars_81_home/ui/widgets/room_scree/edit_room.dart';
import 'package:dars_81_home/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowRoom extends StatefulWidget {
  Room room;
  ShowRoom({super.key,required this.room,});

  @override
  State<ShowRoom> createState() => _ShowRoomState();
}

class _ShowRoomState extends State<ShowRoom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${widget.room.name}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22,),),

            AppUtils.userModel!.roleId == 3 ? Row(
              children: [
                InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (context) => EditRoom(room: widget.room,));
                  },
                  child: const Icon(Icons.edit_calendar),
                ),
                const SizedBox(width: 10,),
                InkWell(
                  onTap: (){
                    context.read<RoomBloc>().add(DeleteRoomBlocEvent(widget.room.id));
                  },
                  child: const Icon(Icons.delete,color: Colors.red,),
                ),
              ],
            ) : const SizedBox(),
          ],
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Room Capacity:",style: TextStyle(fontWeight: FontWeight.bold,),),
                Text("Room created At:",style: TextStyle(fontWeight: FontWeight.bold,),),
                Text("Room update At:",style: TextStyle(fontWeight: FontWeight.bold,),),
                Text("Room Description:",style: TextStyle(fontWeight: FontWeight.bold,),),
                Text("Room Start time:",style: TextStyle(fontWeight: FontWeight.bold,),),
                Text("Room End time:",style: TextStyle(fontWeight: FontWeight.bold,),),
                
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.room.capacity}",style: const TextStyle(fontWeight: FontWeight.bold,),),
                Text("${widget.room.createdAt.day}/${widget.room.createdAt.month}/${widget.room.createdAt.year}",style: const TextStyle(fontWeight: FontWeight.bold,),),
                Text("${widget.room.updatedAt.day}/${widget.room.updatedAt.month}/${widget.room.updatedAt.year}",style: const TextStyle(fontWeight: FontWeight.bold,),),
                Container(
                  width: 200,
                    child: Text("${widget.room.description}",style: const TextStyle(fontWeight: FontWeight.bold,),overflow: TextOverflow.ellipsis,),),
                Text("${widget.room.availableHours.isEmpty ? "unknown" : widget.room.availableHours[0].startTime}",style: const TextStyle(fontWeight: FontWeight.bold,),),
                Text("${widget.room.availableHours.isEmpty ? "unknown" : widget.room.availableHours[0].endTime}",style: const TextStyle(fontWeight: FontWeight.bold,),),
                // for(int i = 0;i < widget.room.availableHours.length;i++)
                //   Text("${widget.room.availableHours[i]}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
              ],
            ),
            const SizedBox()
          ],
        )
      ],
    );
  }
}
