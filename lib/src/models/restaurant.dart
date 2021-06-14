import 'package:recoapp/src/models/tag.dart';

class Restaurant {
  int id;
  String name;
  List<String> carousel;
  String logo;
  String introduction;
  int minPrice;
  int maxPrice;
  String openTime;
  int star1;
  int star2;
  int star3;
  int star4;
  int star5;
  double starAverage;
  double starFood;
  double starService;
  double starAmbiance;
  double starNoise;
  double reviewPoint;
  String cuisine;
  String suitable;
  String space;
  String parking;
  String payment;
  List<String> menu;
  int idAddress;
  String detailAddress;
  double longtitude;
  double latitude;
  String linkUrl;
  List<Tag> tags;
  int userLikeCount;
  int reservationCount;
  int reviewCount;
  int commentCount;
  double distance;

  Restaurant(
      {this.id,
      this.name,
      String carousel,
      this.logo,
      this.introduction,
      this.minPrice,
      this.maxPrice,
      this.openTime,
      this.star1,
      this.star2,
      this.star3,
      this.star4,
      this.star5,
      this.starAverage,
      this.starFood,
      this.starService,
      this.starAmbiance,
      this.starNoise,
      this.reviewPoint,
      this.cuisine,
      this.suitable,
      this.space,
      this.parking,
      this.payment,
      String menu,
      this.idAddress,
      this.detailAddress,
      this.longtitude,
      this.latitude,
      this.linkUrl,
      this.tags,
      this.userLikeCount,
      this.reservationCount,
      this.reviewCount,
      this.commentCount,
      this.distance}) {
    convertCarousel(carousel);
    convertMenu(menu);
  }

  factory Restaurant.fromJsonMap(Map<String, dynamic> json) {
    List<Tag> tags = [];

    if (json["tags"] != null) {
      //get correct list for each section by sectionType
      json["tags"].forEach((item) {
        tags.add(Tag.fromJson(item));
      });
    }

    return Restaurant(
      id: json["id"],
      name: json["name"],
      tags: tags,
      carousel: json["carousel"],
      logo: json["logo"],
      introduction: json["introduction"],
      minPrice: json["minPrice"].toInt(),
      maxPrice: json["maxPrice"].toInt(),
      openTime: json["openTime"],
      star1: json["star1"],
      star2: json["star2"],
      star3: json["star3"],
      star4: json["star4"],
      star5: json["star5"],
      starAverage: json["starAverage"],
      starFood: json["starFood"],
      starService: json["starService"],
      starAmbiance: json["starAmbiance"],
      starNoise: json["starNoise"],
      reviewPoint: json["reviewPoint"],
      cuisine: json["cuisine"],
      suitable: json["suitable"],
      space: json["space"],
      parking: json["parking"],
      payment: json["payment"],
      menu: json["menu"],
      idAddress: json["address"]["id"],
      detailAddress: json["address"]["detail"],
      longtitude: json["address"]["longtitude"],
      latitude: json["address"]["latitude"],
      linkUrl: json["address"]["linkUrl"],
      userLikeCount: json["userLikeCount"] != null ? json["userLikeCount"] : 0,
      reservationCount:
          json["reservationCount"] != null ? json["reservationCount"] : 0,
      reviewCount: json["reviewCount"] != null ? json["reviewCount"] : 0,
      commentCount: json["commentCount"] != null ? json["commentCount"] : 0,
      distance:  json["distance"] ?? 0,
    );
  }

  void convertCarousel(String photo) {
    String s = (photo.replaceAll("[", "")).replaceAll("]", "");
    this.carousel = s.trim().split("&");
    this.carousel.remove("");
    print("photos" + this.carousel.toString());
  }

  void convertMenu(String photo) {
    String s = (photo.replaceAll("[", "")).replaceAll("]", "");
    this.menu = s.trim().split(";");
    this.menu.remove("");
    //print("photos" + this.menu.toString());
  }
}
