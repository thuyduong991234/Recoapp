class User {
  int id;
  String fullname;
  String avatar;

  User({
    this.id,
    this.fullname,
    this.avatar
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      fullname: json["fullName"],
      avatar: json["avatar"] ?? "https://material-kit-react.devias.io/static/images/avatars/avatar_6.png");
}
