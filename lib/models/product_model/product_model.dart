import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

// Convert JSON string to ProductModel
ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

// Convert ProductModel to JSON string
String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    required this.image,
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.isFavourite,
    required this.categoryid,
    required this.url,
    this.timestamp, required String status,
  });

  String image;
  String id;
  String categoryid;
  bool isFavourite;
  String name;
  dynamic price; // Ensure dynamic type handling
  String url;
  String description;
  DateTime? timestamp;

  // Create a ProductModel from JSON
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      image: json["image"] ?? "",
      id: json["id"] ?? "",
      url: json["url"] ?? "",
      isFavourite: json["isFavourite"] ?? false,
      name: json["name"] ?? "",
      categoryid: json['categoryid'] ?? "",
      price: json["price"], // Handle as dynamic
      description: json["description"] ?? "",
      timestamp: json['timestamp'] is Timestamp
          ? (json['timestamp'] as Timestamp).toDate()
          : (json['timestamp'] != null
              ? DateTime.parse(json['timestamp'])
              : null),
    );
  }

  // Convert ProductModel to JSON
  Map<String, dynamic> toJson() => {
        "image": image,
        "id": id,
        "url": url,
        "isFavourite": isFavourite,
        "name": name,
        "price": price,
        "description": description,
        "categoryid": categoryid,
        "timestamp":
            timestamp?.toIso8601String(), // Convert DateTime to ISO 8601 string
      };

  // Create a copy of the ProductModel with some properties changed
  ProductModel copyWith({
    String? image,
    String? name,
    String? id,
    String? categoryid,
    String? description,
    dynamic price,
    String? url,
    bool? isFavourite,
    DateTime? timestamp,
  }) =>
      ProductModel(
        id: id ?? this.id,
        image: image ?? this.image,
        name: name ?? this.name,
        categoryid: categoryid ?? this.categoryid,
        isFavourite: isFavourite ?? this.isFavourite,
        price: price ?? this.price,
        description: description ?? this.description,
        url: url ?? this.url,
        timestamp: timestamp ?? this.timestamp,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
