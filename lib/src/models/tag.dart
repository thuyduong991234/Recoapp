import 'dart:convert';

import 'package:intl/intl.dart';

List<Tag> tagsFromJson(String str) =>
    List<Tag>.from(json.decode(str).map((x) => Tag.fromJson(x)));

class Tag {
  int id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  int countTag;

  Tag({
    this.id,
    this.name,
    this.countTag,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
      id: json["tag"] != null
          ? json["tag"]["id"]
          : (json["id"] != null ? json["id"] : null),
      name: json["tag"] != null ? json["tag"]["name"] : json["name"],
      countTag: json["countTag"] != null ? json["countTag"] : 0);
}
