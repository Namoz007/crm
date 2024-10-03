class Teacher {
  int id;
  String name;
  String? email;
  String phone;
  String? photo;
  DateTime createdAt;
  DateTime updatedAt;
  int roleId;

  Teacher({
    required this.id,
    required this.name,
    this.email,
    required this.phone,
    this.photo,
    required this.createdAt,
    required this.updatedAt,
    required this.roleId,
  });

  // toMap method
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photo': photo,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'role_id': roleId,
    };
  }

  // fromJson factory
  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      photo: json['photo'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      roleId: json['role_id'],
    );
  }
}
