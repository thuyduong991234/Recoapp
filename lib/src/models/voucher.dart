class Voucher {
  int id;
  String title;
  String value;
  List<String> carousel;
  String code;
  DateTime fromTime;
  DateTime toTime;
  String content;
  double starRestaurant;
  String nameRestaurant;
  String logoRestaurant;
  int idRestaurant;
  int likeRestaurant;
  int reservationCount;
  String address;
  String suitable;
  String cuisine;

  Voucher(
      {this.id,
      this.title,
      this.value,
      this.content,
      this.code,
      this.fromTime,
      this.toTime,
      String photos,
      this.starRestaurant,
      this.nameRestaurant,
      this.logoRestaurant,
      this.idRestaurant,
      this.likeRestaurant,
      this.reservationCount,
      this.address,
      this.suitable}) {
    convertCarousel(photos);
  }

  factory Voucher.fromJsonMap(Map<String, dynamic> json) {
    return Voucher(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      code: json["code"],
      value: json["value"],
      fromTime: DateTime.parse(json["fromTime"]),
      toTime: DateTime.parse(json["toTime"]),
      starRestaurant: json["restaurant"]["starAverage"],
      nameRestaurant: json["restaurant"]["name"],
      logoRestaurant: json["restaurant"]["logo"],
      idRestaurant: json["restaurant"]["id"],
      likeRestaurant: json["restaurant"]["userLikeCount"],
      reservationCount: json["restaurant"]["reservationCount"],
      address: json["restaurant"]["address"]["detail"],
      suitable: json["restaurant"]["suitable"],
      photos: json["restaurant"]["carousel"] ??
          "https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mjl8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80",
    );
  }

  void convertCarousel(String photo) {
    String s = (photo.replaceAll("[", "")).replaceAll("]", "");
    this.carousel = s.trim().split("&");
    this.carousel.remove("");
    print("photos" + this.carousel.toString());
  }
}
