// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ReviewModel {
  ReviewModel({
    required this.id,
    required this.userId,
    required this.orderId,
    required this.details,
    required this.status,
    required this.createdAt,
    required this.createdBy,
    required this.displayName,
    required this.displayTitle,
    required this.userName,
    required this.userImage,
  });

  final int id;
  final int userId;
  final int orderId;
  final String details;
  final int status;
  final String createdAt;
  final int createdBy;
  final String displayName;
  final String displayTitle;
  final String userName;
  final String userImage;

  ReviewModel copyWith({
    int? id,
    int? userId,
    int? orderId,
    String? details,
    int? status,
    String? createdAt,
    int? createdBy,
    String? displayName,
    String? displayTitle,
    String? userName,
    String? userImage,
  }) =>
      ReviewModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        orderId: orderId ?? this.orderId,
        details: details ?? this.details,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        createdBy: createdBy ?? this.createdBy,
        displayName: displayName ?? this.displayName,
        displayTitle: displayTitle ?? this.displayTitle,
        userName: userName ?? this.userName,
        userImage: userImage ?? this.userImage,
      );

  factory ReviewModel.fromRawJson(String str) => ReviewModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    id: json["id"] ?? 0,
    userId: json["user_id"] ?? 0,
    orderId: json["order_id"] ?? 0,
    details: json["details"] ?? '',
    status: json["status"] ?? 0,
    createdAt: json["created_at"] ?? '',
    createdBy: json["created_by"] ?? 0,
    displayName: json["display_name"] ?? '',
    displayTitle: json["display_title"] ?? '',
    userName: json["user_name"] ?? '',
    userImage: json["user_image"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "order_id": orderId,
    "details": details,
    "status": status,
    "created_at": createdAt,
    "created_by": createdBy,
    "display_name": displayName,
    "display_title": displayTitle,
    "user_name": userName,
    "user_image": userImage,
  };
}
