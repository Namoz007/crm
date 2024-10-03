class UserModel {
  int id;
  String name;
  String? email;
  String phone;
  int roleId;
  String roleName;
  String photo;

  UserModel({
    required this.id,
    required this.name,
    this.email,
    required this.phone,
    required this.roleId,
    required this.roleName,
    required this.photo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'] ?? '',
      roleId: json['role_id'],
      roleName: json['role']['name'],
      photo: json['photo'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role_id': roleId,
      'role_name': roleName,
      'photo': photo,
    };
  }
}
