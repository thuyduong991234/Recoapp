import 'package:recoapp/src/models/user.dart';

class Comment {
  int id;
  User user;
  String content;
  List<String> photos;
  double overallStar;
  int foodStar;
  int serviceStar;
  int aimbianceStar;
  int noiseStar;
  int idRestaurant;
  String nameRestaurant;
  DateTime createdAt;
  String detailAddress;
  String logo;

  Comment(
      {this.id,
      this.user,
      this.content,
      String photos,
      this.overallStar,
      this.foodStar,
      this.serviceStar,
      this.aimbianceStar,
      this.noiseStar,
      this.idRestaurant,
      this.nameRestaurant,
      this.createdAt,
      this.logo,
      this.detailAddress}) {
    convertPhoto(photos);
  }

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
      id: json["id"],
      user: User.fromJson(json["user"]),
      content: json["content"],
      createdAt: DateTime.parse(json["createdAt"]),
      overallStar:
          json["overallStar"] != null ? json["overallStar"].toDouble() : null,
      foodStar: json["foodStar"] != null ? json["foodStar"].toInt() : null,
      serviceStar:
          json["serviceStar"] != null ? json["serviceStar"].toInt() : null,
      aimbianceStar:
          json["aimbianceStar"] != null ? json["aimbianceStar"].toInt() : null,
      noiseStar: json["noiseStar"] != null ? json["noiseStar"].toInt() : null,
      photos: json["listPhoto"] ?? null,
      nameRestaurant: json["restaurant"]["name"],
      idRestaurant: json["restaurant"]["id"],
      logo: json["restaurant"]["logo"],
      detailAddress: json["restaurant"]["address"]["detail"]);

  void convertPhoto(String photo) {
    if (photo == null)
      this.photos = null;
    else {
      String s = (photo.replaceAll("[", "")).replaceAll("]", "");
      this.photos = s.trim().split(",");
      this.photos.removeWhere((element) => element.isEmpty);
    }
  }
}
