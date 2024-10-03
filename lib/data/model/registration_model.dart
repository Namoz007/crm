class RegistrationModel {
  String name;
  String phoneNumber;
  String password;
  int roleId;

  RegistrationModel({
    required this.name,
    required this.phoneNumber,
    required this.password,
    this.roleId = 1,
  });

  Map<String,dynamic> toMap(){
    return {
      "name": name,
      "phone": phoneNumber,
      "password": password,
      "password_confirmation": password,
      "role_id": roleId,
    };
  }
}
