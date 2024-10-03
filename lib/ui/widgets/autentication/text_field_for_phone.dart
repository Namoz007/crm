import 'package:dars_81_home/bloc/phone_bloc/phone_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../bloc/phone_bloc/phone_bloc.dart';
import '../../../bloc/phone_bloc/phone_state.dart';

class TextFieldForPhone extends StatefulWidget {
  PhoneNumber number;
  TextEditingController phoneController;
  TextEditingController countryCode;
  TextFieldForPhone({super.key,required this.number,required this.phoneController,required this.countryCode,});

  @override
  State<TextFieldForPhone> createState() => _TextFieldForPhoneState();
}

class _TextFieldForPhoneState extends State<TextFieldForPhone> {

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InternationalPhoneNumberInput(
          validator: (value){
            if(value == null || value.trim().isEmpty){
              return "Please,return enter phone number";
            }

            return null;
          },
          onInputChanged: (PhoneNumber number) {
            widget.countryCode.text = number.dialCode.toString();
          },
          selectorConfig: SelectorConfig(
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
            useBottomSheetSafeArea: true,
          ),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.disabled,
          selectorTextStyle: TextStyle(color: Colors.black),
          initialValue: widget.number,
          textFieldController: widget.phoneController,
          formatInput: true,
          keyboardType:
          TextInputType.numberWithOptions(signed: true, decimal: true),
          inputBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20)
          ),
        ),

        const SizedBox(height: 40,),
      ],
    );
  }
}
