import '../../core/master_object.dart';

// ignore: must_be_immutable
class AddressModel extends MasterObject<AddressModel> {
  bool? status;
  String? path;
  int? statusCode;
  String? message;
  String? previousPage;
  int? nextPage;
  int? firstPage;
  int? lastPage;
  int? total;
  String? timestamp;
  List<AddressData>? data;

  AddressModel({
    super.id,
    this.status,
    this.path,
    this.statusCode,
    this.message,
    this.previousPage,
    this.nextPage,
    this.firstPage,
    this.lastPage,
    this.total,
    this.timestamp,
    this.data,
  });

  @override
  AddressModel fromMap(dynamicData) {
    status = dynamicData['status'];
    path = dynamicData['path'];
    statusCode = dynamicData['statusCode'];
    message = dynamicData['message'];
    previousPage = dynamicData['previousPage'];
    nextPage = dynamicData['nextPage'];
    firstPage = dynamicData['firstPage'];
    lastPage = dynamicData['lastPage'];
    total = dynamicData['total'];
    timestamp = dynamicData['timestamp'];
    data = AddressData().fromMapList(dynamicData['data']);
    return this;
  }

  @override
  List<AddressModel> fromMapList(List list) =>
      list.map((v) => fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(AddressModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<AddressModel> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
    status,
    path,
    statusCode,
    message,
    previousPage,
    nextPage,
    firstPage,
    lastPage,
    total,
    timestamp,
    data,
  ];
}

// ignore: must_be_immutable
class AddressData extends MasterObject<AddressData> {
  String? name;
  String? address;
  String? latitude;
  String? longitude;
  bool? status;
  int? organizationId;
  String? createdAt;
  String? updatedAt;

  AddressData({
    super.id,
    this.name,
    this.address,
    this.latitude,
    this.longitude,
    this.status,
    this.organizationId,
    this.createdAt,
    this.updatedAt,
  });

  @override
  AddressData fromMap(dynamicData) {
    id = dynamicData['id'];
    name = dynamicData['name'];
    address = dynamicData['address'];
    latitude = dynamicData['latitude'];
    longitude = dynamicData['longitude'];
    status = dynamicData['status'];
    organizationId = dynamicData['organizationId'];
    createdAt = dynamicData['createdAt'];
    updatedAt = dynamicData['updatedAt'];
    return this;
  }

  @override
  List<AddressData> fromMapList(List list) =>
      list.map((v) => AddressData().fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(AddressData? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<AddressData> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
    id,
    name,
    address,
    latitude,
    longitude,
    status,
    organizationId,
    createdAt,
    updatedAt,
  ];
}
