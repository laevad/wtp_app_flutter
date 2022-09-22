class User {
  String? name;
  String? email;
  String? avatar;
  String? avatarUrl;
  User({
    this.name,
    this.email,
    this.avatar,
    this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> user) {
    return User(
      name: user['name'],
      email: user['email'],
      avatar: user['avatar'],
      avatarUrl: user['avatar_url'],
    );
  }
}
