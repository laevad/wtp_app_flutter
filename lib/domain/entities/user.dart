class User {
  String? name;
  String? email;
  String? avatar;
  String? avatarUrl;
  String? currentPass;
  String? newPass;
  String? conPass;
  String? imageMsg;
  int? statusCode;
  User({
    this.name,
    this.email,
    this.avatar,
    this.avatarUrl,
    this.currentPass,
    this.newPass,
    this.conPass,
    this.imageMsg,
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
        imageMsg: user['errors']['image'],
        conPass: user['errors']['password_confirmation'],
        statusCode: statusCode);
  }
}
