import 'dart:developer';

class ImageModel {
  String? name;
  String? imageUrl;
  String? type;
  String? dateTime;
  bool? isActive;
  int? id;

  ImageModel({this.name, this.isActive, this.id});

  ImageModel.fromJson(Map<String, dynamic> json) {
    try {
      name = json['name'] ?? "";
      id = json['id'] ?? "";
      isActive = json['isActive'] ?? false;
    } catch (e) {
      log("Exception - ImageModel.dart - ImageModel.fromJson():$e");
    }
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'isActive': isActive,
      };
}
