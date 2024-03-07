import 'dart:developer';

class CategoryModel {
  String? name;
  bool? isActive;
  int? id;

  CategoryModel({this.name, this.isActive, this.id});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    try {
      name = json['name'] ?? "";
      id = json['id'] ?? "";
      isActive = json['isActive'] ?? false;
    } catch (e) {
      log("Exception - CategoryModel.dart - CategoryModel.fromJson():$e");
    }
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
        'isActive': isActive,
      };
}
