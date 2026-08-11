import '../../core/master_object.dart';

// ignore: must_be_immutable
class WalletModel extends MasterObject<WalletModel> {
  bool? status;
  String? path;
  int? statusCode;
  String? message;
  String? timestamp;
  WelletDataModel? data;

  WalletModel({
    super.id,
    this.status,
    this.path,
    this.statusCode,
    this.message,
    this.timestamp,
    this.data,
  });

  @override
  WalletModel fromMap(dynamicData) {
    status = dynamicData['status'];
    path = dynamicData['path'];
    statusCode = dynamicData['statusCode'];
    message = dynamicData['message'];
    timestamp = dynamicData['timestamp'];
    data = dynamicData['data'] != null
        ? WelletDataModel().fromMap(dynamicData['data'])
        : null;
    return this;
  }

  @override
  List<WalletModel> fromMapList(List list) =>
      list.map((v) => fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(WalletModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<WalletModel> objectList) {
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
class WelletDataModel extends MasterObject<WelletDataModel> {
  int? userId;
  String? balance;
  String? status;
  int? version;
  String? currency;
  String? createdAt;
  String? updatedAt;

  WelletDataModel({
    super.id,
    this.userId,
    this.balance,
    this.status,
    this.version,
    this.currency,
    this.createdAt,
    this.updatedAt,
  });

  @override
  WelletDataModel fromMap(dynamicData) {
    id = dynamicData['id'];
    userId = dynamicData['userId'];
    balance = dynamicData['balance'];
    status = dynamicData['status'];
    version = dynamicData['version'];
    currency = dynamicData['currency'];
    createdAt = dynamicData['createdAt'];
    updatedAt = dynamicData['updatedAt'];
    return this;
  }

  @override
  List<WelletDataModel> fromMapList(List list) =>
      list.map((v) => fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(WelletDataModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<WelletDataModel> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    balance,
    status,
    version,
    currency,
    createdAt,
    updatedAt,
  ];
}
