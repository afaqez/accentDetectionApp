class UserModel {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  UserModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
    };
  }
}
