import 'package:b2b_freshmore/base_architecture/core/master_object.dart';

// ignore: must_be_immutable
class SubCategoryData extends MasterObject<SubCategoryData> {
  String? enName;
  String? enDescription;
  String? enRemark;
  bool? status;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  Category? category;

  SubCategoryData({
    int? id,
    this.enName,
    this.enDescription,
    this.enRemark,
    this.status,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.category,
  }) : super(id: id ?? 0);

  @override
  SubCategoryData fromMap(dynamicData) {
    id = dynamicData['id'];
    enName = dynamicData['enName'];
    enDescription = dynamicData['enDescription'];
    enRemark = dynamicData['enRemark'];
    status = dynamicData['status'];
    categoryId = dynamicData['categoryId'];
    createdAt = dynamicData['createdAt'];
    updatedAt = dynamicData['updatedAt'];
    category = dynamicData['category'] != null
        ? Category().fromMap(dynamicData['category'])
        : null;
    return this;
  }

  @override
  List<SubCategoryData> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(SubCategoryData? object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<SubCategoryData> objectList) {
    throw UnimplementedError();
  }
}

// ignore: must_be_immutable
class Category extends MasterObject<Category> {
  String? enName;
  String? enDescription;
  String? enRemark;
  String? imageUrl;
  bool? status;
  String? createdAt;
  String? updatedAt;

  Category({
    int? id,
    this.enName,
    this.enDescription,
    this.enRemark,
    this.imageUrl,
    this.status,
    this.createdAt,
    this.updatedAt,
  }) : super(id: id ?? 0);

  @override
  Category fromMap(dynamicData) {
    id = dynamicData['id'];
    enName = dynamicData['enName'];
    enDescription = dynamicData['enDescription'];
    enRemark = dynamicData['enRemark'];
    imageUrl = dynamicData['imageUrl'];
    status = dynamicData['status'];
    createdAt = dynamicData['createdAt'];
    updatedAt = dynamicData['updatedAt'];
    return this;
  }

  @override
  List<Category> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(Category? object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Category> objectList) {
    throw UnimplementedError();
  }
}
