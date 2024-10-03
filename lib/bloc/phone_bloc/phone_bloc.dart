import 'package:bloc/bloc.dart';
import 'package:dars_81_home/bloc/phone_bloc/phone_event.dart';
import 'package:dars_81_home/bloc/phone_bloc/phone_state.dart';
import 'package:dars_81_home/data/repositories/phone_number_repositories.dart';

class PhoneBloc extends Bloc<PhoneEvent,PhoneState>{
  final PhoneNumberRepositories _repositories;
  PhoneBloc({required PhoneNumberRepositories repo}) : _repositories = repo,super(InitialPhoneState()){
    on<SendSMSPhoneEvent>(_sendSMSToPhoneNumber);
    on<CheckVerificationCodePhoneEvent>(_checkVerificationCode);
  }

  void _checkVerificationCode(CheckVerificationCodePhoneEvent event,emit){
    emit(TrueVerificattionCodePhoneState());
  }

  void _sendSMSToPhoneNumber(SendSMSPhoneEvent event,emit){
    emit(SendingSMSPhoneState());
    _repositories.sendSMSToPhoneNumber(event.phoneNumber);
    emit(SendedSMSPhoneState());
  }
}