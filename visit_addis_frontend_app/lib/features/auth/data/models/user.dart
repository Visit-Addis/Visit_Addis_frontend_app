class User {
  final String userName; // Change to userName
  final String email;
  final String password;

  User({
    required this.userName, // Update constructor parameter
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName, // Update the key here
      'email': email,
      'password': password,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['userName'], // Update to match the new key
      email: json['email'],
      password: json['password'],
    );
  }
}
