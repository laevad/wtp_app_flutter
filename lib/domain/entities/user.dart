import 'dart:io';

class User {
  String? name;
  String? email;
  String? avatar;
  String? avatarUrl;
  String? currentPass;
  String? newPass;
  String? conPass;
  File? image;
  int? statusCode;
  User({
    this.name,
    this.email,
    this.avatar,
    this.avatarUrl,
    this.currentPass,
    this.newPass,
    this.conPass,
    this.image,
    this.statusCode,
  });

  factory User.fromJson(Map<String, dynamic> user) {
    return User(
      name: user['name'],
      email: user['email'],
      avatar: user['avatar'],
      avatarUrl: user['avatar_url'],
    );
  }

  factory User.fromJsonUpdate(Map<String, dynamic> user, int statusCode) {
    return User(
        name: user['errors']['name'],
        email: user['errors']['email'],
        avatar: user['errors']['avatar'],
        currentPass: user['errors']['current_password'],
        newPass: user['errors']['new_password'],
        statusCode: statusCode);
  }
}
