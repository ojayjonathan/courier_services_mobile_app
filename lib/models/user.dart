class User {
  //return user object from json
  final String email;
  final String userName;
  final String phoneNumber;
  final String? profileImage;

  User(
      {required this.email,
      required this.userName,
      required this.profileImage,
      required this.phoneNumber});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        email: json["email"],
        phoneNumber: (json["phone_number"] as String).replaceAll("+254", "0"),
        profileImage: json["profile_image"],
        userName: json["username"]);
  }
}
