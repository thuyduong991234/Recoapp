import 'package:recoapp/src/models/tag.dart';
import 'package:recoapp/src/models/user.dart';

class Review {
  int id;
  User user;
  String title;
  String content;
  int point;
  List<Tag> tags;
  DateTime createdAt;
  int like;
  List<String> photos;
  double starRestaurant;
  String nameRestaurant;
  String logoRestaurant;
  int idRestaurant;
  int likeRestaurant;
  int countReservation;
  String address;
  String suitable;
  String cuisine;

  Review(
      {this.id,
      this.user,
      this.title,
      this.content,
      this.point,
      this.createdAt,
      this.like,
      String photos,
      this.starRestaurant,
      this.nameRestaurant,
      this.logoRestaurant,
      this.idRestaurant,
      this.likeRestaurant,
      this.countReservation,
      this.address,
      this.suitable}) {
    convertPhoto(photos);
  }

  void setTags(List<Tag> tags)
  {
    this.tags = tags;
  }

  void setCuisine(String cuisine)
  {
    this.cuisine = cuisine;
  }

  factory Review.fromJson(Map<String, dynamic> json) => Review(
      id: json["id"],
      user: User.fromJson(json["user"]),
      title: json["title"],
      content: json["content"],
      createdAt: DateTime.parse(json["createdAt"]),
      like: json["countUserLike"],
      point: json["point"].toInt(),
      photos: json["listPhoto"] ??
          "https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mjl8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80",
      starRestaurant: json["restaurant"]["starAverage"],
      nameRestaurant: json["restaurant"]["name"],
      logoRestaurant: json["restaurant"]["logo"],
      idRestaurant: json["restaurant"]["id"],
      likeRestaurant: json["restaurant"]["countUserLike"],
      countReservation: json["restaurant"]["countReservation"],
      address: json["restaurant"]["address"]["detail"],
      suitable: json["restaurant"]["suitable"]);

  void convertPhoto(String photo) {
    String s = (photo.replaceAll("[", "")).replaceAll("]", "");
    this.photos = s.trim().split(",");
    print("photos" + this.photos.toString());
  }
}
