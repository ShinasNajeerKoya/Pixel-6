class User {
  String username;
  String password;
  String email;
  String phoneNumber;
  String? image; // base64 encoded image string

  User({
    required this.username,
    required this.password,
    required this.email,
    required this.phoneNumber,
    this.image,
  });

  // Convert a User object into a Map object
  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'email': email,
        'phoneNumber': phoneNumber,
        'image': image,
      };

  // Create a User object from a Map object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      password: json['password'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      image: json['image'],
    );
  }
}
