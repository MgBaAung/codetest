import '../../core/master_object.dart';

// ignore: must_be_immutable
class CurrencyModel extends MasterObject<CurrencyModel> {
  bool? status;
  String? path;
  int? statusCode;
  String? message;
  List<DataModel>? data;
  String? timestamp;
  String? currency;
  String? standardDisplayCode;

  CurrencyModel({
    this.status,
    this.path,
    this.statusCode,
    this.message,
    this.data,
    this.timestamp,
    this.currency,
    this.standardDisplayCode,
  }) : super(id: 0);

  @override
  CurrencyModel fromMap(dynamicData) {
    status = dynamicData['status'];
    path = dynamicData['path'];
    statusCode = dynamicData['statusCode'];
    message = dynamicData['message'];
    data = DataModel().fromMapList(dynamicData['data']);
    timestamp = dynamicData['timestamp'];
    return this;
  }

  @override
  List<CurrencyModel> fromMapList(List list) =>
      list.map((v) => CurrencyModel().fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(CurrencyModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<CurrencyModel> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
    status,
    path,
    statusCode,
    message,
    data,
    timestamp,
  ];
}

// ignore: must_be_immutable
class DataModel extends MasterObject<DataModel> {
  String? name;
  String? countryCode;
  String? languageCode;
  String? callingCode;
  int? serviceLayerId;
  int? parentId;
  bool? endPoint;
  bool? superAdminStartPoint;
  bool? superAdminEndPoint;
  bool? portfolioStartPoint;
  bool? portfolioEndPoint;
  bool? portfolioServiceStatus;
  bool? b2bStartPoint;
  bool? b2bEndPoint;
  bool? b2bServiceStatus;
  bool? hrmsStartPoint;
  bool? hrmsEndPoint;
  bool? hrmsServiceStatus;
  bool? inventoryStartPoint;
  bool? inventoryEndPoint;
  bool? inventoryServiceStatus;
  bool? franchiseStartPoint;
  bool? franchiseEndPoint;
  bool? franchiseServiceStatus;
  bool? retailStartPoint;
  bool? retailEndPoint;
  bool? retailServiceStatus;
  bool? supplierStartPoint;
  bool? supplierEndPoint;
  bool? supplierServiceStatus;
  String? standardInputCode;
  String? standardDisplayCode;
  String? legalCompany;
  String? orgName;
  String? currency;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? timeZone;

  DataModel({super.id, this.currency, this.standardDisplayCode});

  @override
  DataModel fromMap(dynamicData) {
    id = dynamicData['id'];

    currency = dynamicData['currency'];
    standardDisplayCode = dynamicData['standardDisplayCode'];
    return this;
  }

  @override
  String toString() {
    return "Currency: $currency id: $id";
  }

  @override
  List<DataModel> fromMapList(List list) =>
      list.map((v) => DataModel().fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(DataModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<DataModel> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
    id,
    name,
    countryCode,
    languageCode,
    callingCode,
    serviceLayerId,
    parentId,
    endPoint,
    superAdminStartPoint,
    superAdminEndPoint,
    portfolioStartPoint,
    portfolioEndPoint,
    portfolioServiceStatus,
    b2bStartPoint,
    b2bEndPoint,
    b2bServiceStatus,
    hrmsStartPoint,
    hrmsEndPoint,
    hrmsServiceStatus,
    inventoryStartPoint,
    inventoryEndPoint,
    inventoryServiceStatus,
    franchiseStartPoint,
    franchiseEndPoint,
    franchiseServiceStatus,
    retailStartPoint,
    retailEndPoint,
    retailServiceStatus,
    supplierStartPoint,
    supplierEndPoint,
    supplierServiceStatus,
    standardInputCode,
    standardDisplayCode,
    legalCompany,
    orgName,
    currency,
    createdAt,
    updatedAt,
    deletedAt,
    timeZone,
  ];
}
