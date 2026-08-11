import 'package:b2b_freshmore/base_architecture/core/master_object.dart';

// ignore: must_be_immutable
class CategoryModel extends MasterObject<CategoryModel> {
  int? statusCode;
  String? message;
  List<CategoryData>? datas;

  CategoryModel({this.message, this.statusCode, this.datas}) : super(id: 0);

  @override
  CategoryModel fromMap(dynamicData) {
    statusCode = dynamicData["statusCode"];
    message = dynamicData["message"];

    if (dynamicData["data"] != null) {
      datas = (dynamicData["data"] as List).map((data) {
        return CategoryData().fromMap(data);
      }).toList();
    } else {
      datas = [];
    }

    return this;
  }

  @override
  List<CategoryModel> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(CategoryModel? object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<CategoryModel> objectList) {
    throw UnimplementedError();
  }
}

// ignore: must_be_immutable
class CategoryData extends MasterObject<CategoryData> {
  String? enName;
  String? enDescription;
  String? enRemark;
  String? imageUrl;
  bool? status;
  String? createdAt;
  String? updatedAt;

  CategoryData({
    super.id,
    this.enName,
    this.enDescription,
    this.enRemark,
    this.imageUrl,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  @override
  CategoryData fromMap(dynamicData) {
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
  List<CategoryData> fromMapList(List<dynamic> dynamicDataList) {
    return dynamicDataList.map((data) => fromMap(data)).toList();
  }

  @override
  Map<String, dynamic>? toMap(CategoryData? object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<CategoryData> objectList) {
    throw UnimplementedError();
  }
}
