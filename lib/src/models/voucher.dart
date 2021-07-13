class Voucher {
  int id;
  String title;
  String image;
  String code;
  DateTime fromTime;
  DateTime toTime;
  double starRestaurant;
  String nameRestaurant;
  String logoRestaurant;
  int idRestaurant;
  int likeRestaurant;
  int reservationCount;
  int count;
  double longtitude;
  double latitude;
  String address;
  String suitable;

  Voucher(
      {this.id,
      this.title,
      this.code,
      this.fromTime,
      this.toTime,
      this.image,
      this.starRestaurant,
      this.nameRestaurant,
      this.logoRestaurant,
      this.idRestaurant,
      this.likeRestaurant,
      this.reservationCount,
      this.address,
      this.suitable,
      this.count,
      this.latitude,
      this.longtitude});

  factory Voucher.fromJsonMap(Map<String, dynamic> json) {
    return Voucher(
      id: json["id"],
      count: json["count"] ?? 0,
      title: json["title"],
      code: json["code"] ?? null,
      fromTime: json["fromTime"] != null ? DateTime.parse(json["fromTime"]) : null,
      toTime: json["toTime"] != null ? DateTime.parse(json["toTime"]) : null,
      starRestaurant: json["restaurant"] != null ? json["restaurant"]["starAverage"] ?? 0 : 0,
      nameRestaurant: json["restaurant"] != null ? json["restaurant"]["name"] ?? null : null,
      logoRestaurant: json["restaurant"] != null ? json["restaurant"]["logo"] ?? null : null,
      idRestaurant: json["restaurant"] != null ? json["restaurant"]["id"] ?? null : null,
      likeRestaurant: json["restaurant"] != null ? json["restaurant"]["userLikeCount"] ?? 0 : 0,
      reservationCount: json["restaurant"] != null ? json["restaurant"]["reservationCount"] ?? 0 : 0,
      address: json["restaurant"] != null ? json["restaurant"]["address"]["detail"] ?? null : null,
      longtitude: json["restaurant"] != null ? json["restaurant"]["address"]["longtitude"] ?? 0 : 0,
      latitude: json["restaurant"] != null ? json["restaurant"]["address"]["latitude"] ?? 0 : 0,
      suitable: json["restaurant"] != null ? json["restaurant"]["suitable"] ?? null : null,
      image: json["image"] ??
          "https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8Mjl8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80",
    );
  }
}
