import 'package:dars_81_home/bloc/authentication/authentIcation_event.dart';
import 'package:dars_81_home/bloc/authentication/authentication_bloc.dart';
import 'package:dars_81_home/bloc/authentication/authentication_state.dart';
import 'package:dars_81_home/ui/screens/authentication/sign_in_screen.dart';
import 'package:dars_81_home/ui/widgets/autentication/registration_phone_inputs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegistrationFields extends StatefulWidget {
  TextEditingController name;
  TextEditingController phoneNumber;
  TextEditingController password;
  TextEditingController confirmPassword;
  PhoneNumber initialNumber;
  TextEditingController countryCode;

  RegistrationFields({
    super.key,
    required this.name,
    required this.phoneNumber,
    required this.password,
    required this.confirmPassword,
    required this.initialNumber,
    required this.countryCode,
  });

  @override
  State<RegistrationFields> createState() => _RegistrationFieldsState();
}

class _RegistrationFieldsState extends State<RegistrationFields> {
  bool _isShow = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // BlocBuilder uchun bloc va state turini aniq belgilang
        BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is ErrorAuthenticationState) {
              return Center(
                child: Text(
                  "${state.message}",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            return Container();
          },
        ),
        const Text(
          "Name",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 7),
        TextFormField(
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Please, return enter name";
            }
            return null;
          },
          controller: widget.name,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            hintText: "Name",
          ),
        ),
        const SizedBox(height: 10),
        RegistrationPhoneInputs(
          phoneNumberController: widget.phoneNumber,
          initialNumber: widget.initialNumber,
          countryCode: widget.countryCode,
        ),
        const Text(
          "Password",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 7),
        TextFormField(
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Please, return enter password";
            }
            if (value.trim().length < 6) {
              return "Min password length 6";
            }
            if (widget.password.text != widget.confirmPassword.text) {
              return "Passwords do not match";
            }
            return null;
          },
          obscureText: _isShow,
          controller: widget.password,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            hintText: "Password",
            suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  _isShow = !_isShow;
                });
              },
              child: _isShow
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          "Confirm Password",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        TextFormField(
          obscureText: _isShow,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return "Please, return enter password";
            }
            if (value.trim().length < 6) {
              return "Min password length 6";
            }
            if (widget.password.text != widget.confirmPassword.text) {
              return "Passwords do not match";
            }
            return null;
          },
          controller: widget.confirmPassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            hintText: "Confirm Password",
          ),
        ),
        const SizedBox(height: 10),
        InkWell(
          onTap: () {
            context.read<AuthenticationBloc>().add(ClearErrorMessageAuthenticationEvent());
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          },
          child: const Center(
              child: Text(
            "Login",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          )),
        )
      ],
    );
  }
}
