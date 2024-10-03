import 'package:dars_81_home/data/model/group.dart';
import 'package:flutter/material.dart';

class ShowGroupScreen extends StatefulWidget {
  Group group;
  ShowGroupScreen({super.key,required this.group,});

  @override
  State<ShowGroupScreen> createState() => _ShowGroupScreenState();
}

class _ShowGroupScreenState extends State<ShowGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.group.name}"),
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text("Main teacher")
              ],
            ),

            Column(

            )
          ],
        ),
      ),
    );
  }
}
