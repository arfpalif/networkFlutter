// To parse this JSON data, do
//
//     final userResponseModel = userResponseModelFromJson(jsonString);

import 'dart:convert';

List<UserResponseModel> userResponseModelFromJson(String str) => List<UserResponseModel>.from(json.decode(str).map((x) => UserResponseModel.fromJson(x)));

String userResponseModelToJson(List<UserResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserResponseModel {
    DateTime createdAt;
    String name;
    String avatar;
    String address;
    String id;

    UserResponseModel({
        required this.createdAt,
        required this.name,
        required this.avatar,
        required this.address,
        required this.id,
    });

    factory UserResponseModel.fromJson(Map<String, dynamic> json) => UserResponseModel(
        createdAt: DateTime.parse(json["createdAt"]),
        name: json["name"],
        avatar: json["avatar"],
        address: json["address"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "name": name,
        "avatar": avatar,
        "address": address,
        "id": id,
    };
}
