class UserModel {
  final String email;
  final String name;
  final String password;
  final bool status;
  final bool verify;

  UserModel({
    required this.email,
    required this.name,
    required this.password,
    required this.status,
    required this.verify,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      password: json['password'],
      status: json['status'],
      verify: json['verify'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'password': password,
      'status': status,
      'verify': verify,
    };
  }
}
