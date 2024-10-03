sealed class PhoneEvent{}

final class SendSMSPhoneEvent extends PhoneEvent{
  String phoneNumber;

  SendSMSPhoneEvent(this.phoneNumber);
}

final class CheckVerificationCodePhoneEvent extends PhoneEvent{
  String code;

  CheckVerificationCodePhoneEvent(this.code);
}