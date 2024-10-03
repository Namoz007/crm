import 'package:dars_81_home/services/phone_number_services.dart';

class PhoneNumberRepositories{
  final PhoneNumberServices _services;

  PhoneNumberRepositories({required PhoneNumberServices servic}) : _services = servic;

  Future<void> sendSMSToPhoneNumber(String phoneNumber) async{
    await _services.sendSMSToNumber(phoneNumber);
  }
}