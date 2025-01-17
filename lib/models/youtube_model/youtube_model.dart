import 'dart:convert';

YoutubeModel youtubeModelFromJson(String str) =>
    YoutubeModel.fromJson(json.decode(str));

String youtubeModelToJson(YoutubeModel data) => json.encode(data.toJson());

class YoutubeModel {
  YoutubeModel({
    required this.url,
    required this.id,
    required this.name,
  });

  String url;
  String id;
  String name;

  factory YoutubeModel.fromJson(Map<String, dynamic> json) {
    return YoutubeModel(
      url: json["url"] ?? "",
      id: json["id"] ?? "",
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "url": url,
        "id": id,
        "name": name,
      };
}
