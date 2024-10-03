import 'package:dars_81_home/bloc/authentication/authentIcation_event.dart';
import 'package:dars_81_home/bloc/authentication/authentication_bloc.dart';
import 'package:dars_81_home/bloc/authentication/authentication_state.dart';
import 'package:dars_81_home/ui/screens/dashboards/dashboard.dart';
import 'package:dars_81_home/ui/widgets/autentication/sign_in_with_app.dart';
import 'package:dars_81_home/ui/widgets/autentication/text_field_for_phone.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../data/model/login_request_model.dart';

class SignInFields extends StatefulWidget {
  const SignInFields({super.key});

  @override
  State<SignInFields> createState() => _SignInFieldsState();
}

class _SignInFieldsState extends State<SignInFields> {
  final _formKey = GlobalKey<FormState>();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final TextEditingController _countryCode = TextEditingController();
  String initialCountry = 'UZ ';
  final PhoneNumber _number = PhoneNumber(isoCode: 'UZ');
  bool _isShow = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is ErrorAuthenticationState) {
                return Center(
                  child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        state.message,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                );
              }
              return Container();
            },
          ),
          TextFieldForPhone(
            number: _number,
            phoneController: _phone,
            countryCode: _countryCode,
          ),
          const Text(
            "Password",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Please return email addres";
              }

              if (value.trim().length < 6) return "Min password length 6";

              return null;
            },
            controller: _password,
            obscureText: _isShow,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              hintText: '********',
              suffixIcon: InkWell(
                onTap: () {
                  setState(() {
                    _isShow = !_isShow;
                  });
                },
                child: _isShow
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.remove_red_eye),
              ),
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const SignInWithApp(),
          const SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                context.read<AuthenticationBloc>().add(LogInAuthenticationEvent(
                    requestModel: LoginRequestModel(
                        phoneNumber:
                            "${_countryCode.text}${_phone.text.replaceAll(' ', '')}",
                        password: _password.text)));
              }
            },
            child: Container(
              width: double.infinity,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF3F8CFF),
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is ComedUserAuthenticationState) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Dashboard(),
                      ),
                      (route) => false,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoadingAuthenticationState) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    );
                  }
                  return const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Sign In",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        CupertinoIcons.arrow_right,
                        color: Colors.white,
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
