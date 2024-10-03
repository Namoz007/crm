import 'package:dars_81_home/data/model/user_model.dart';
import 'package:flutter/material.dart';

class ShowUserForAdmin extends StatefulWidget {
  UserModel user;
  ShowUserForAdmin({super.key,required this.user,});

  @override
  State<ShowUserForAdmin> createState() => _ShowUserForAdminState();
}

class _ShowUserForAdminState extends State<ShowUserForAdmin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 22,horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black,width: 1,),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Container(
                 height: 50,
                 width: 50,
                 decoration: BoxDecoration(
                   shape: BoxShape.circle,
                     image: DecorationImage(image: NetworkImage(true ? "https://klike.net/uploads/posts/2023-01/1674365337_3-31.jpg" : "http://millima.flutterwithakmaljon.uz/api/storage/avatars/${widget.user.photo}",))
                   // image: DecorationImage(image: NetworkImage(widget.user.photo == '' ? "https://klike.net/uploads/posts/2023-01/1674365337_3-31.jpg" : "http://millima.flutterwithakmaljon.uz/api/storage/avatars/${widget.user.photo}",))
                 ),
               ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('${widget.user.name}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,),),
                  
                  Text("${widget.user.email == null ? "not found" : widget.user.email}",style: const TextStyle(color: Colors.grey,),)
                ],
              ),

              InkWell(
                child: Icon(Icons.more_vert),
              )
            ],
          ),
          const SizedBox(height: 10,),
          const Divider(),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Position:",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 16),),
              Text("${widget.user.roleName}",style: TextStyle(fontSize: 16,color: Colors.grey,fontWeight: FontWeight.bold,),),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Phone:",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 16),),
              Text("${widget.user.phone}",style: TextStyle(fontSize: 16,color: Colors.grey,fontWeight: FontWeight.bold,),),
            ],
          )

        ],
      ),
    );
  }
}
