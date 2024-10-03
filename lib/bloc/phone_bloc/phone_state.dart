sealed class PhoneState{}

final class InitialPhoneState extends PhoneState{}

final class SendingSMSPhoneState extends PhoneState{}

final class SendedSMSPhoneState extends PhoneState{}

final class TrueVerificattionCodePhoneState extends PhoneState{}

final class ErrorPhoneState extends PhoneState{
  String message;

  ErrorPhoneState(this.message);
}