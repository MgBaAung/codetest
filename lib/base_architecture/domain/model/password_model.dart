import 'package:b2b_freshmore/base_architecture/core/master_object.dart';

// ignore: must_be_immutable
class PasswordModel extends MasterObject<PasswordModel> {
  String? oldPassword;
  String? newPassword;

  PasswordModel({this.newPassword, this.oldPassword}) : super(id: 0);
  @override
  PasswordModel fromMap(dynamicData) {
    return this;
  }

  @override
  List<PasswordModel> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(PasswordModel? object) {
    return {"oldPassword": oldPassword, "newPassword": newPassword};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<PasswordModel> objectList) {
    throw UnimplementedError();
  }
}
