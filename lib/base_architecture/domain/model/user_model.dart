import 'package:b2b_freshmore/base_architecture/core/master_object.dart';

// ignore: must_be_immutable
class UserModel extends MasterObject<UserModel> {
  String? ownerId;
  String? password;
  String? accessToken;
  String? refreshToken;
  String? organizationName;
  String? userName;
  String? code;
  String? phone;
  String? email;
  String? position;
  String? userId;
  num? locationId;
  int? organizationId;
  String? userRole;
  num? level;

  UserModel({
    num? id,
    this.ownerId,
    this.password,
    this.organizationName,
    this.userName,
    this.code,
    this.phone,
    this.email,
    this.position,
    this.userId,
    this.locationId,
    this.organizationId,
    this.userRole,
    this.level,
  }) : super(id: id ?? 0);

  @override
  UserModel fromMap(dynamicData) {
    // accessToken = dynamicData["data"]["access_token"];
    accessToken = dynamicData["data"]["token"];
    id = dynamicData["data"]["id"];
    organizationName = dynamicData["data"]["organization"]["name"];
    userName = dynamicData["data"]["name"];
    phone = dynamicData["data"]["phone"];
    email = dynamicData["data"]["email"];
    position = dynamicData["data"]["level"];
    userId = dynamicData["data"]["userId"];
    code = dynamicData["data"]["organization"]["code"];
    organizationId = dynamicData["data"]["organization"]["id"];
    locationId = dynamicData["data"]["organization"]["locationId"];
    userRole = dynamicData['data']['code'];
    level = dynamicData['data']['organization']['currentLevel'];
    return this;
  }

  @override
  List<UserModel> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(UserModel? object) {
    return {"orgCode": ownerId, "code": code, "password": password};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<UserModel> objectList) {
    throw UnimplementedError();
  }

  // @override
  // String toString() {
  //   return "User model : userId $user";
  // }
}
