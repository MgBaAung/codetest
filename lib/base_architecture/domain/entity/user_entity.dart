import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../core/base_entity.dart';
import '../model/user_model.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 0)
class UserEntity extends BaseEntity<UserModel, UserEntity> {
  @HiveField(0)
  num? id;
  @HiveField(1)
  String? organization;
  @HiveField(2)
  String? phone;
  @HiveField(3)
  String? usename;
  @HiveField(4)
  String? code;
  @HiveField(5)
  String? ownerId;
  @HiveField(6)
  String? email;
  @HiveField(7)
  String? position;
  @HiveField(8)
  String? userId;
  @HiveField(9)
  num? locationId;
  @HiveField(10)
  int? organitionId;
  @HiveField(11)
  String? userRole;
  @HiveField(12)
  num? level;
  @override
  UserEntity fromModel(UserModel model) {
    id = model.id;
    organization = model.organizationName;
    usename = model.userName;
    phone = model.phone;
    code = model.code;
    email = model.email;
    position = model.position;
    userId = model.userId;
    locationId = model.locationId;
    organitionId = model.organizationId;
    userRole = model.userRole;
    level = model.level;
    return this;
  }

  @override
  UserModel toModel() {
    return UserModel(
      id: id,
      organizationName: organization,
      userName: usename,
      code: code,
      phone: phone,
      email: email,
      position: position,
      userId: userId,
      locationId: locationId,
      organizationId: organitionId,
      userRole: userRole,
      level: level,
    );
  }

  static void register() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserEntityAdapter());
    }
  }
}
