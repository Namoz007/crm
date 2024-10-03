import 'dart:io';
import 'package:dars_81_home/bloc/user_bloc/user_bloc.dart';
import 'package:dars_81_home/bloc/user_bloc/user_bloc_event.dart';
import 'package:dars_81_home/bloc/user_bloc/user_bloc_state.dart';
import 'package:dars_81_home/data/model/user_model.dart';
import 'package:dars_81_home/ui/widgets/autentication/text_field_for_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class MyDatas extends StatefulWidget {
  UserModel model;
  MyDatas({super.key, required this.model});

  @override
  State<MyDatas> createState() => _MyDatasState();
}

class _MyDatasState extends State<MyDatas> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _name = TextEditingController();
  final _countryCode = TextEditingController();
  PhoneNumber _number = PhoneNumber(isoCode: "UZ",dialCode: '+998');

  File? _image;
  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedImage = await _picker.pickImage(source: source,maxWidth: 200,imageQuality: 50,);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
      }
    } catch (e) {
      print("Xato: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _phoneNumber.text = widget.model.phone.substring(4,widget.model.phone.length- 1);
    _email.text = widget.model.email.toString();
    _name.text = widget.model.name;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BlocBuilder<UserBloc,UserBlocState>(builder: (context,state){
            if(state is ErrorUserBlocState){
              return Center(child: Text("${state.message}",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),);
            }
            return Container();
          },),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 72,
                    width: 72,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.model.photo == ""
                            ? "https://klike.net/uploads/posts/2023-01/1674365337_3-31.jpg"
                            : "http://millima.flutterwithakmaljon.uz/storage/avatars/${widget.model.photo}"),
                        fit: BoxFit.cover,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  InkWell(
                    onTap: () => _pickImage(ImageSource.gallery),
                    child: Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: const Color(0xFFF4F9FD),
                        border: Border.all(
                          color: _image == null ? Colors.red : Colors.green,
                          width: 2,
                        ),
                      ),
                      child: const Icon(Icons.edit_calendar_outlined),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "${widget.model.name}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const Divider(),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Contact Info",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "email",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _email,
                validator: (value) {
                  if (value != null && value.isNotEmpty && !value.contains("@") && value != "null") {
                    return "Not find @ element from your email";
                  }

                  if(value == null || value == 'null'){
                    return 'Please,enter your email';
                  }

                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "E-mail",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "phone",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldForPhone(number: _number, phoneController: _phoneNumber,countryCode: _countryCode,),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "name",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please,return input name";
                  }

                  return null;
                },
                controller: _name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: "Name",
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        context.read<UserBloc>().add(UpdateMyUserBlocEvent(imgFile: _image == null ? null : _image, name: _name.text == widget.model.name ? _name.text : _name.text,email: _email.text == widget.model.email.toString() ? _email.text : _email.text,phoneNumber: _phoneNumber.text == widget.model.phone ? widget.model.phone : "${_number.dialCode}${_phoneNumber.text.replaceAll(' ', '')}"));
                      }
                    },
                    child: BlocBuilder<UserBloc,UserBlocState>(builder: (context,state){
                      if(state is LoadingUserBlocState){
                        return const Center(child: CircularProgressIndicator(color: Colors.red,),);
                      }
                      return const Text("Save");
                    },),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
