class CheckIn {
  int id;
  String name;
  String logo;
  String detail;

  CheckIn({this.id, this.name, this.logo, this.detail});

  factory CheckIn.fromJson(Map<String, dynamic> json) => CheckIn(
      id: json["id"],
      name: json["name"],
      logo: json["logo"],
      detail: json["detail"] ?? json["address"]["detail"]);
}
