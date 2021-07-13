class Noti {
  int id;
  int idObject;
  String title;
  String image;
  String content;
  String time;
  bool status;
  int type;

  Noti(
      {this.id,
      this.idObject,
      this.title,
      this.content,
      this.image,
      this.time,
      this.type});

  factory Noti.fromJsonMap(Map<String, dynamic> json) {
    return Noti(
        id: json["id"],
        idObject: json["refId"],
        title: json["title"],
        content: json["content"],
        image: json["image"],
        time: json["time"],
        type: json["type"]);
  }

  void setStatus(bool isRead) {
    this.status = isRead;
  }
}
