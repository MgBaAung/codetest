import 'dart:io';

import 'package:b2b_freshmore/base_architecture/core/master_object.dart';

// ignore: must_be_immutable
class AttachementModel extends MasterObject<AttachementModel> {
  File? file;
  AttachementModel({this.file, super.id});

  @override
  AttachementModel fromMap(dynamicData) {
    return this;
  }

  @override
  List<AttachementModel> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(AttachementModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<AttachementModel> objectList) {
    throw UnimplementedError();
  }
}
