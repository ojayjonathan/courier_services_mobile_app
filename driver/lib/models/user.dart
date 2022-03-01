import 'dart:convert';

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
        profileImage: json["avatar"],
        userName: json["username"]);
  }
  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "phone_number": phoneNumber,
      "avatar": profileImage,
      "username": userName
    };
  }

  @override
  String toString() {
    return jsonEncode(this.toJson(),);
  }
}

class Driver {
  User user;
  String dlNumber;
  String gender;

  Driver({required this.user, required this.dlNumber, required this.gender});

  factory Driver.fromJson(Map<String, dynamic> json) {
    User user = User.fromJson(json['user']);
    return Driver(
      user: user,
      dlNumber: json['dl_number'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"user": user.toJson(), "gender": gender, "dl_number": dlNumber};
  }

  @override
  String toString() {
    return jsonEncode(this.toJson());
  }
}
