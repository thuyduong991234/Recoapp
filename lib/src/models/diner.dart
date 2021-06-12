import 'package:recoapp/src/models/checkin.dart';
import 'package:recoapp/src/models/simple_review.dart';
import 'package:recoapp/src/models/tag.dart';

class Diner {
  int id;
  String username;
  String fullname;
  String avatar;
  String address;
  String email;
  String phone;
  int reservationCount;
  int reviewCount;
  List<SimpleReview> favoriteReviews;
  List<CheckIn> favoriteRestaurants;
  int gender;
  DateTime dob;
  List<Tag> tags;
  String activeAreaIds;

  Diner(
      {this.id,
      this.username,
      this.fullname,
      this.avatar,
      this.address,
      this.email,
      this.phone,
      this.reservationCount,
      this.reviewCount,
      this.favoriteReviews,
      this.favoriteRestaurants,
      this.gender,
      this.dob,
      this.tags,
      this.activeAreaIds});

  factory Diner.fromJsonMap(Map<String, dynamic> json) {
    List<Tag> tags = [];
    List<SimpleReview> favoriteReviews = [];
    List<CheckIn> favoriteRestaurants = [];

    if (json["favoriteTags"] != null) {
      //get correct list for each section by sectionType
      json["favoriteTags"].forEach((item) {
        tags.add(Tag.fromJson(item));
      });
    }

    if (json["favoriteReview"] != null) {
      //get correct list for each section by sectionType
      json["favoriteReview"].forEach((item) {
        favoriteReviews.add(SimpleReview.fromJson(item));
      });
    }

    if (json["favoriteRestaurant"] != null) {
      //get correct list for each section by sectionType
      json["favoriteRestaurant"].forEach((item) {
        favoriteRestaurants.add(CheckIn.fromJson(item));
      });
    }

    return Diner(
        id: json["id"],
        username: json["username"],
        fullname: json["fullName"] ?? "Chưa cập nhật",
        reviewCount: json["reviewCount"].toInt(),
        address: json["address"] != null ? json["address"]["detail"] : "Chưa cập nhật",
        email: json["email"] ?? "Chưa cập nhật",
        phone: json["phone"] ?? "Chưa cập nhật",
        reservationCount: json["reservationCount"].toInt(),
        avatar: json["avatar"] ??
            "https://material-kit-react.devias.io/static/images/avatars/avatar_6.png",
        gender: json["gender"] != null ? json["gender"].toInt() : 1,
        dob: json["dob"] != null ? DateTime.parse(json["dob"]) : DateTime.now(),
        activeAreaIds: json["activeAreaIds"] ?? null,
        tags: tags,
        favoriteReviews: favoriteReviews,
        favoriteRestaurants: favoriteRestaurants);
  }
}
