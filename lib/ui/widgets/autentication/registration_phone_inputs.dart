import 'package:dars_81_home/bloc/phone_bloc/phone_bloc.dart';
import 'package:dars_81_home/bloc/phone_bloc/phone_event.dart';
import 'package:dars_81_home/bloc/phone_bloc/phone_state.dart';
import 'package:dars_81_home/ui/widgets/autentication/email_and_password_fields.dart';
import 'package:dars_81_home/ui/widgets/autentication/text_field_for_phone.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class RegistrationPhoneInputs extends StatefulWidget {
  TextEditingController phoneNumberController;
  PhoneNumber initialNumber;
  TextEditingController countryCode;

  RegistrationPhoneInputs({
    super.key,
    required this.phoneNumberController,
    required this.initialNumber,
    required this.countryCode,
  });

  @override
  State<RegistrationPhoneInputs> createState() =>
      _RegistrationPhoneInputsState();
}

class _RegistrationPhoneInputsState extends State<RegistrationPhoneInputs> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Mobil Number",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          TextFieldForPhone(
            number: widget.initialNumber,
            phoneController: widget.phoneNumberController,
            countryCode: widget.countryCode,
          ),
        ],
      ),
    );
  }
}
