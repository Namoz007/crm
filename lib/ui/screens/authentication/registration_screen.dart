import 'package:dars_81_home/bloc/authentication/authentIcation_event.dart';
import 'package:dars_81_home/bloc/authentication/authentication_bloc.dart';
import 'package:dars_81_home/bloc/authentication/authentication_state.dart';
import 'package:dars_81_home/data/model/registration_model.dart';
import 'package:dars_81_home/ui/screens/dashboards/dashboard.dart';
import 'package:dars_81_home/ui/widgets/app_logo.dart';
import 'package:dars_81_home/ui/widgets/autentication/registration_fields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final TextEditingController _phoneControllerr = TextEditingController();
  final _countryCode = TextEditingController();
  PhoneNumber _number = PhoneNumber(isoCode: 'UZ');
  bool _checkBox = false;

  // Selected value for DropdownButton
  String selectedValue = 'Teacher';

  List<String> _options = ["Teacher", "Admin"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 54,
              ),
              const AppLogo(),
              const SizedBox(
                height: 37,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(
                  vertical: 26,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        "STEP 1/4",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        "Valid your phone",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    RegistrationFields(
                      name: _name,
                      phoneNumber: _phoneControllerr,
                      password: _password,
                      confirmPassword: _confirmPassword,
                      initialNumber: _number,
                      countryCode: _countryCode,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: _checkBox,
                              onChanged: (value) {
                                setState(() {
                                  _checkBox = value!;
                                });
                              },
                            ),
                            const Text("I'm not student!"),
                          ],
                        ),
                        _checkBox
                            ? DropdownButton<String>(
                                value: selectedValue,
                                items: _options.map((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                },
                              )
                            : const SizedBox(),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if(state is ComedUserAuthenticationState){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Dashboard()),(route) => false, );
                    }
              },
                  builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        int roleId = 0;
                        if(!_checkBox){
                          roleId = 1;
                        }else{
                          if(selectedValue == 'Teacher'){
                            roleId = 2;
                          }else{
                            roleId = 3;
                          }
                        }
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthenticationBloc>().add(SignUpAuthenticationEvent(model: RegistrationModel(name: _name.text, phoneNumber: "${_countryCode.text}${_phoneControllerr.text.replaceAll(' ', '')}", password: _password.text,roleId: roleId,),),);
                        }
                      },
                      child: Container(
                        height: 48,
                        width: 145,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blueAccent,
                        ),
                        alignment: Alignment.center,
                        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(builder: (context, state) {
                              if(state is LoadingAuthenticationState){
                                return const Center(child: CircularProgressIndicator(color: Colors.red,),);
                              }
                          return const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Next Step",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
                        }),
                      ),
                    )
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
