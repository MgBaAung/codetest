import '../../core/master_object.dart';

// ignore: must_be_immutable
class AuthSettings extends MasterObject {
  String? userId;
  String? password;

  bool? isRemembered;

  AuthSettings({this.password, this.userId, this.isRemembered}) : super(id: 0);

  @override
  fromMap(dynamicData) {
    throw UnimplementedError();
  }

  @override
  List<dynamic> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<dynamic> objectList) {
    throw UnimplementedError();
  }
}
