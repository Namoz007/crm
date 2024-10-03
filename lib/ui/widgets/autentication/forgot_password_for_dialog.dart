import 'package:dars_81_home/bloc/authentication/authentIcation_event.dart';
import 'package:dars_81_home/bloc/authentication/authentication_bloc.dart';
import 'package:dars_81_home/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordForDialog extends StatefulWidget {
  const ForgotPasswordForDialog({super.key});

  @override
  State<ForgotPasswordForDialog> createState() => _ForgotPasswordForDialogState();
}

class _ForgotPasswordForDialogState extends State<ForgotPasswordForDialog> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Forgot password"),
      content: Form(
        key: _formKey,
        child: TextFormField(
          validator: (value){
            if(value == null || value.trim().isEmpty)
              return "Please,return enter email adress";

            if(!value.contains("@"))
              return "No element(@) in email";

            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: "Enter email",
          ),
        ),
      ),
      actions: [
        FilledButton(onPressed: (){Navigator.pop(context);}, child: const Text("Cancel")),
        FilledButton(onPressed: (){
          if(_formKey.currentState!.validate()){
            context.read<AuthenticationBloc>().add(ForgotPasswordAuthenticationEvent(_email.text));
            Navigator.pop(context);
          }
        }, child: const Text("Reset password"))
      ],
    );
  }
}

