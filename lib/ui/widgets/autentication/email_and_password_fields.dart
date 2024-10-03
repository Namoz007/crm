import 'package:flutter/material.dart';

class EmailAndPasswordFields extends StatefulWidget {
  TextEditingController name;
  TextEditingController password;
  EmailAndPasswordFields({super.key,required this.name,required this.password,});

  @override
  State<EmailAndPasswordFields> createState() => _EmailAndPasswordFieldsState();
}

class _EmailAndPasswordFieldsState extends State<EmailAndPasswordFields> {
  bool _isShow = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty)
              return "Please return name";


            return null;
          },
          controller: widget.name,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            hintText: 'Your name',
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Password",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.grey,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        TextFormField(
          validator: (value) {
            if (value == null || value.trim().isEmpty)
              return "Please return email addres";

            if (value.trim().length < 6) return "Min password length 6";

            return null;
          },
          controller: widget.password,
          obscureText: _isShow,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            hintText: '********',
            suffixIcon: InkWell(
              onTap: (){
                setState(() {
                  _isShow = !_isShow;
                });
              },
              child: _isShow ? const Icon(Icons.visibility_off) : const Icon(Icons.remove_red_eye),
            ),
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
