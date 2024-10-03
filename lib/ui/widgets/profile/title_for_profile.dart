import 'package:flutter/material.dart';

class TitleForProfile extends StatefulWidget {
  const TitleForProfile({super.key});

  @override
  State<TitleForProfile> createState() => _TitleForProfileState();
}

class _TitleForProfileState extends State<TitleForProfile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("My Profile",style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold,),),

        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey,width: 0.2,),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(Icons.settings),
        )
      ],
    );
  }
}
