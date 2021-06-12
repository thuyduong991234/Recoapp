import 'package:recoapp/src/models/user.dart';

class SimpleReview {
  int id;
  User user;
  String title;
  int like;
  List<String> photos;

  SimpleReview({this.id, this.user, this.title, this.like, String photos}) {
    convertPhoto(photos);
  }

  factory SimpleReview.fromJson(Map<String, dynamic> json) => SimpleReview(
      id: json["id"],
      user: User.fromJson(json["user"]),
      title: json["title"],
      like: json["countUserLike"],
      photos: json["listPhoto"]);

  void convertPhoto(String photo) {
    if (photo != null) {
      String s = (photo.replaceAll("[", "")).replaceAll("]", "");
      this.photos = s.trim().split(",");
    }
    else
    {
      this.photos = null;
    }
  }
}
