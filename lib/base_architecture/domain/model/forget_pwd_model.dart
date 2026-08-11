import 'package:b2b_freshmore/base_architecture/core/master_object.dart';

// ignore: must_be_immutable
class ForgetPwdModel extends MasterObject<ForgetPwdModel> {
  int? statusCode;
  String? message;
  ForgetPwdModel({this.level, this.orgCode}) : super(id: 0);

  String? orgCode;
  String? level;

  @override
  ForgetPwdModel fromMap(dynamicData) {
    statusCode = dynamicData['statusCode'];
    message = dynamicData['message'];
    return this;
  }

  @override
  List<ForgetPwdModel> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(ForgetPwdModel? object) {
    return {"orgCode": object?.orgCode, "level": object?.level};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<ForgetPwdModel> objectList) {
    throw UnimplementedError();
  }
}
