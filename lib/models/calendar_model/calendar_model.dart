import 'dart:convert';

CalendarModel calendarModelFromJson(String str) =>
    CalendarModel.fromJson(json.decode(str));

String youtubeModelToJson(CalendarModel data) => json.encode(data.toJson());

class CalendarModel {
  CalendarModel({
    required this.image,
    required this.id,
    //required this.name,
  });

  String image;
  String id;
  //String name;

  factory CalendarModel.fromJson(Map<String, dynamic> json) {
    return CalendarModel(
      image: json["image"] ?? "",
      id: json["id"] ?? "",
      //name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "image": image,
        "id": id,
        //"name": name,
      };
}
