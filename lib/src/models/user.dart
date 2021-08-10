class User {
  int id;
  String fullname;
  String avatar;
  int _point;
  int _level;

  int get point => _point;
  int get level => _level;

  set point(int point) {
    this._point = point;
  }

  set level(int level) {
    this._level = level;
  }

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
