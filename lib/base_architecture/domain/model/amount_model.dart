import 'package:b2b_freshmore/base_architecture/core/master_object.dart';

// ignore: must_be_immutable
class AmountModel extends MasterObject<AmountModel> {
  bool? status;
  String? path;
  int? statusCode;
  String? message;
  String? timestamp;
  List<AmountDataModel>? data;

  AmountModel({
    super.id,
    this.status,
    this.path,
    this.statusCode,
    this.message,
    this.timestamp,
    this.data,
  });

  @override
  AmountModel fromMap(dynamicData) {
    status = dynamicData['status'];
    path = dynamicData['path'];
    statusCode = dynamicData['statusCode'];
    message = dynamicData['message'];
    timestamp = dynamicData['timestamp'];
    data = AmountDataModel().fromMapList(dynamicData['data']);
    return this;
  }

  @override
  List<AmountModel> fromMapList(List list) =>
      list.map((v) => fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(AmountModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<AmountModel> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
    status,
    path,
    statusCode,
    message,
    timestamp,
    data,
  ];
}

// ignore: must_be_immutable
class AmountDataModel extends MasterObject<AmountDataModel> {
  int? countryId;
  String? countryCode;
  String? countryName;
  String? currency;
  String? amount;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  AmountDataModel({
    super.id,
    this.countryId,
    this.countryCode,
    this.countryName,
    this.currency,
    this.amount,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  @override
  AmountDataModel fromMap(dynamicData) {
    id = dynamicData['id'];
    countryId = dynamicData['countryId'];
    countryCode = dynamicData['countryCode'];
    countryName = dynamicData['countryName'];
    currency = dynamicData['currency'];
    amount = dynamicData['amount'];
    isActive = dynamicData['isActive'];
    createdAt = dynamicData['createdAt'];
    updatedAt = dynamicData['updatedAt'];
    return this;
  }

  @override
  List<AmountDataModel> fromMapList(List list) =>
      list.map((v) => AmountDataModel().fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(AmountDataModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<AmountDataModel> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
    id,
    countryId,
    countryCode,
    countryName,
    currency,
    amount,
    isActive,
    createdAt,
    updatedAt,
  ];
}
