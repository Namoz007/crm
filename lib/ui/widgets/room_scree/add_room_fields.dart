import 'package:flutter/material.dart';

class AddRoomFields extends StatefulWidget {
  TextEditingController roomName;
  TextEditingController roomDescription;
  TextEditingController roomCapacity;
  AddRoomFields({super.key,required this.roomName,required this.roomDescription,required this.roomCapacity,});

  @override
  State<AddRoomFields> createState() => _AddRoomFieldsState();
}

class _AddRoomFieldsState extends State<AddRoomFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Room name",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,),),
        const SizedBox(height: 10,),
        TextFormField(
          validator: (value){
            if(value == null || value.isEmpty){
              return "Please,return input rooom name";
            }

            return null;
          },
          controller: widget.roomName,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: 'Room name'
          ),
        ),
        const SizedBox(height: 20,),
        const Text("Room Description",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,),),
        const SizedBox(height: 10,),
        TextFormField(
          validator: (value){
            if(value == null || value.isEmpty){
              return "Please,return input room description";
            }

            return null;
          },
          controller: widget.roomDescription,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'Room description'
          ),
        ),
        const SizedBox(height: 20,),
        const Text("Room Capacity",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,),),
        const SizedBox(height: 10,),
        TextFormField(
          validator: (value){
            if(value == null || value.isEmpty){
              return "Please,return input room capacity";
            }

            try{
              int.parse(value);
              return null;
            }catch(e){
              return "Your entered value not number";
            }

          },
          controller: widget.roomCapacity,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: 'Room capacityGoo'
          ),
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}
