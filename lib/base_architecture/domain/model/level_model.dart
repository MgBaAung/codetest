import 'package:b2b_freshmore/base_architecture/core/master_object.dart';

// ignore: must_be_immutable
class LevelModel extends MasterObject<LevelModel> {
  bool? status;
  String? path;
  int? statusCode;
  String? message;
  String? timestamp;
  Data? data;

  LevelModel({
    this.status,
    this.path,
    this.statusCode,
    this.message,
    this.timestamp,
    this.data,
  }) : super(id: 0);

  @override
  LevelModel fromMap(dynamicData) {
    status = dynamicData['status'];
    path = dynamicData['path'];
    statusCode = dynamicData['statusCode'];
    message = dynamicData['message'];
    timestamp = dynamicData['timestamp'];
    data = dynamicData['data'] != null
        ? Data().fromMap(dynamicData['data'])
        : null;

    return this;
  }

  @override
  List<LevelModel> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(LevelModel? object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<LevelModel> objectList) {
    throw UnimplementedError();
  }
}

// ignore: must_be_immutable
class Data extends MasterObject<Data> {
  String? logoUrl;
  String? code;
  num? businessTypeId;
  num? locationId;
  String? websiteUrl;
  String? contactName;
  String? contactPhoneNumber;
  num? contactPositionId;
  String? contactEmail;
  num? userRequestId;
  num? maxUsers;
  String? createdAt;
  String? updatedAt;
  List<Users>? users;
  List<String>? roles;

  Data({
    num? id,
    this.logoUrl,
    this.code,
    this.businessTypeId,
    this.locationId,
    this.websiteUrl,
    this.contactName,
    this.contactPhoneNumber,
    this.contactPositionId,
    this.contactEmail,
    this.userRequestId,
    this.maxUsers,
    this.createdAt,
    this.updatedAt,
    this.users,
    this.roles,
  }) : super(id: id ?? 0);

  @override
  Data fromMap(dynamicData) {
    id = dynamicData['id'];
    logoUrl = dynamicData['logoUrl'];
    code = dynamicData['code'];
    businessTypeId = dynamicData['businessTypeId'];
    locationId = dynamicData['locationId'];
    websiteUrl = dynamicData['websiteUrl'];
    contactName = dynamicData['contactName'];
    contactPhoneNumber = dynamicData['contactPhoneNumber'];
    contactPositionId = dynamicData['contactPositionId'];
    contactEmail = dynamicData['contactEmail'];
    userRequestId = dynamicData['userRequestId'];
    maxUsers = dynamicData['maxUsers'];
    createdAt = dynamicData['createdAt'];
    updatedAt = dynamicData['updatedAt'];
    if (dynamicData['users'] != null) {
      users = [];
      dynamicData['users'].forEach((v) {
        users?.add(Users().fromMap(v));
      });
    }
    roles = dynamicData['roles'].cast<String>();
    return this;
  }

  @override
  List<Data> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(Data? object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Data> objectList) {
    throw UnimplementedError();
  }
}

// ignore: must_be_immutable
class Users extends MasterObject<Users> {
  String? name;
  String? email;
  String? phone;
  String? emailVerifiedAt;
  String? code;
  String? level;
  String? position;
  String? rememberToken;
  num? organizationId;
  bool? isNew;
  num? serialId;
  String? createdAt;
  String? updatedAt;

  Users({
    super.id,
    this.name,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.code,
    this.level,
    this.position,
    this.rememberToken,
    this.organizationId,
    this.isNew,
    this.serialId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  Users fromMap(dynamicData) {
    id = dynamicData['id'];
    name = dynamicData['name'];
    email = dynamicData['email'];
    phone = dynamicData['phone'];
    emailVerifiedAt = dynamicData['emailVerifiedAt'];
    code = dynamicData['code'];
    level = dynamicData['level'];
    position = dynamicData['position'];
    rememberToken = dynamicData['rememberToken'];
    organizationId = dynamicData['organizationId'];
    isNew = dynamicData['isNew'];
    serialId = dynamicData['serialId'];
    createdAt = dynamicData['createdAt'];
    updatedAt = dynamicData['updatedAt'];
    return this;
  }

  @override
  List<Users> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(Users? object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Users> objectList) {
    throw UnimplementedError();
  }
}
