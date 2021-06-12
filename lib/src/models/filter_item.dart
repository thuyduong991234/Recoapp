import 'package:recoapp/src/models/tag.dart';

class FilterItem {
  int id;
  String name;
  List<Tag> tags;

  FilterItem({this.id, this.name, this.tags});

  set filterTags (List<Tag> tags) {
    this.tags = tags;
  }

  factory FilterItem.fromJsonMap(Map<String, dynamic> json) {
    List<Tag> tags = [];

    if (json["id"] == 1) {
      if (json["child"] != null) {
        //get correct list for each section by sectionType
        json["child"].forEach((item) {
          tags.add(Tag.fromJson(item));
        });
      }
    }
    else
    {
      if (json["tags"] != null) {
        //get correct list for each section by sectionType
        json["tags"].forEach((item) {
          tags.add(Tag.fromJson(item));
        });
      }
    }

    return FilterItem(id: json["id"], name: json["name"], tags: tags);
  }
}
