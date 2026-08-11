import 'package:b2b_freshmore/base_architecture/core/master_object.dart';

// ignore: must_be_immutable
class WalletPaymentModel extends MasterObject<WalletPaymentModel> {
  bool? status;
  String? path;
  int? statusCode;
  String? message;
  String? timestamp;
  
  List<WalletPaymentDataModel>? data;

  WalletPaymentModel({
    super.id,
    this.status,
    this.path,
    this.statusCode,
    this.message,
    this.timestamp,
    this.data,
  });

  @override
  WalletPaymentModel fromMap(dynamicData) {
    status = dynamicData['status'];
    path = dynamicData['path'];
    statusCode = dynamicData['statusCode'];
    message = dynamicData['message'];
    timestamp = dynamicData['timestamp'];
    data = WalletPaymentDataModel().fromMapList(dynamicData['data']);
    return this;
  }

  @override
  List<WalletPaymentModel> fromMapList(List list) =>
      list.map((v) => fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(WalletPaymentModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<WalletPaymentModel> objectList) {
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
class WalletPaymentDataModel extends MasterObject<WalletPaymentDataModel> {
  String? name;
  String? logoUrl;
  bool? status;
  String? createdAt;
  String? updatedAt;
  String? trasferAccountName;
  String? trasferAccountNo;

  WalletPaymentDataModel({
    super.id,
    this.name,
    this.logoUrl,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.trasferAccountName,
    this.trasferAccountNo,
  });

  @override
  WalletPaymentDataModel fromMap(dynamicData) {
    id = dynamicData['id'];
    name = dynamicData['name'];
    logoUrl = dynamicData['logoUrl'];
    status = dynamicData['status'];
    createdAt = dynamicData['createdAt'];
    updatedAt = dynamicData['updatedAt'];
    trasferAccountName = dynamicData['trasferAccountName'];
    trasferAccountNo = dynamicData['trasferAccountNo'];
    return this;
  }

  @override
  List<WalletPaymentDataModel> fromMapList(List list) =>
      list.map((v) => WalletPaymentDataModel().fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(WalletPaymentDataModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(
    List<WalletPaymentDataModel> objectList,
  ) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [id, name, logoUrl, status, createdAt, updatedAt];
}
