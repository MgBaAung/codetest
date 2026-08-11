import '../../core/master_object.dart';

// ignore: must_be_immutable
class OrderHistoryModel extends MasterObject<OrderHistoryModel> {
  String? orderNo;
  String? orgCode;
  String? orgName;
  String? orgUserName;
  String? orgUserPhone;
  String? orgUserLevel;
  String? orgUserCode;
  OrgAddressModel? orgAddress;
  num? totalAmount;
  num? subtotalAmount;
  num? taxAmount;
  String? currency;
  String? remark;
  String? status;
  String? paymentStatus;
  bool? deliveryStatus;
  bool? saleInvoiceStatus;
  String? paymentMethod;
  String? paymentReference;
  String? paymentOption;
  String? paymentAttachmentUrl;
  String? standardDisplayCode;
  String? orderUpdatedBy;
  String? financeUpdatedBy;
  String? deliveryUpdatedBy;
  String? saleInvoiceUpdatedBy;
  String? createdAt;
  String? updatedAt;
  List<ItemsModel>? items;

  OrderHistoryModel({
    super.id,
    this.orderNo,
    this.orgCode,
    this.orgName,
    this.orgUserName,
    this.orgUserPhone,
    this.orgUserLevel,
    this.orgUserCode,
    this.orgAddress,
    this.totalAmount,
    this.subtotalAmount,
    this.taxAmount,
    this.currency,
    this.remark,
    this.status,
    this.paymentStatus,
    this.deliveryStatus,
    this.saleInvoiceStatus,
    this.paymentMethod,
    this.paymentReference,
    this.paymentOption,
    this.paymentAttachmentUrl,
    this.standardDisplayCode,
    this.orderUpdatedBy,
    this.financeUpdatedBy,
    this.deliveryUpdatedBy,
    this.saleInvoiceUpdatedBy,
    this.createdAt,
    this.updatedAt,
    this.items,
  });

  @override
  OrderHistoryModel fromMap(dynamicData) {
    id = dynamicData['id'];
    orderNo = dynamicData['orderNo'];
    orgCode = dynamicData['orgCode'];
    orgName = dynamicData['orgName'];
    orgUserName = dynamicData['orgUserName'];
    orgUserPhone = dynamicData['orgUserPhone'];
    orgUserLevel = dynamicData['orgUserLevel'];
    orgUserCode = dynamicData['orgUserCode'];
    orgAddress = dynamicData['orgAddress'] != null
        ? OrgAddressModel().fromMap(dynamicData['orgAddress'])
        : null;
    totalAmount = dynamicData['totalAmount'];
    subtotalAmount = dynamicData['subtotalAmount'];
    taxAmount = dynamicData['taxAmount'];
    currency = dynamicData['currency'];
    remark = dynamicData['remark'];
    status = dynamicData['status'];
    paymentStatus = dynamicData['paymentStatus'];
    deliveryStatus = dynamicData['deliveryStatus'];
    saleInvoiceStatus = dynamicData['saleInvoiceStatus'];
    paymentMethod = dynamicData['paymentMethod'];
    paymentReference = dynamicData['paymentReference'];
    paymentOption = dynamicData['paymentOption'];
    paymentAttachmentUrl = dynamicData['paymentAttachmentUrl'];
    standardDisplayCode = dynamicData['standardDisplayCode'];
    orderUpdatedBy = dynamicData['orderUpdatedBy'];
    financeUpdatedBy = dynamicData['financeUpdatedBy'];
    deliveryUpdatedBy = dynamicData['deliveryUpdatedBy'];
    saleInvoiceUpdatedBy = dynamicData['saleInvoiceUpdatedBy'];
    createdAt = dynamicData['createdAt'];
    updatedAt = dynamicData['updatedAt'];
    items = ItemsModel().fromMapList(dynamicData['items']);
    return this;
  }

  @override
  List<OrderHistoryModel> fromMapList(List list) =>
      list.map((v) => OrderHistoryModel().fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(OrderHistoryModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<OrderHistoryModel> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
    id,
    orderNo,
    orgCode,
    orgName,
    orgUserName,
    orgUserPhone,
    orgUserLevel,
    orgUserCode,
    orgAddress,
    totalAmount,
    subtotalAmount,
    taxAmount,
    currency,
    remark,
    status,
    paymentStatus,
    deliveryStatus,
    saleInvoiceStatus,
    paymentMethod,
    paymentReference,
    paymentOption,
    paymentAttachmentUrl,
    standardDisplayCode,
    orderUpdatedBy,
    financeUpdatedBy,
    deliveryUpdatedBy,
    saleInvoiceUpdatedBy,
    createdAt,
    updatedAt,
    items,
  ];
}

// ignore: must_be_immutable
class OrgAddressModel extends MasterObject<OrgAddressModel> {
  String? name;
  String? address;
  String? fullName;
  String? latitude;
  String? longitude;

  OrgAddressModel({
    super.id,
    this.name,
    this.address,
    this.fullName,
    this.latitude,
    this.longitude,
  });

  @override
  OrgAddressModel fromMap(dynamicData) {
    name = dynamicData['name'];
    address = dynamicData['address'];
    fullName = dynamicData['fullName'];
    latitude = dynamicData['latitude'];
    longitude = dynamicData['longitude'];
    return this;
  }

  @override
  List<OrgAddressModel> fromMapList(List list) =>
      list.map((v) => fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(OrgAddressModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<OrgAddressModel> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [name, address, fullName, latitude, longitude];
}

// ignore: must_be_immutable
class ItemsModel extends MasterObject<ItemsModel> {
  int? orderId;
  int? productId;
  int? quantity;
  num? price;
  num? total;
  ProductModel? product;

  ItemsModel({
    super.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.price,
    this.total,
    this.product,
  });

  @override
  ItemsModel fromMap(dynamicData) {
    id = dynamicData['id'];
    orderId = dynamicData['orderId'];
    productId = dynamicData['productId'];
    quantity = dynamicData['quantity'];
    price = dynamicData['price'];
    total = dynamicData['total'];
    product = dynamicData['product'] != null
        ? ProductModel().fromMap(dynamicData['product'])
        : null;
    return this;
  }

  @override
  List<ItemsModel> fromMapList(List list) =>
      list.map((v) => ItemsModel().fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(ItemsModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<ItemsModel> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
    id,
    orderId,
    productId,
    quantity,
    price,
    total,
    product,
  ];
}

// ignore: must_be_immutable
class ProductModel extends MasterObject<ProductModel> {
  String? productId;
  String? barcode;
  String? sku;
  String? nameEn;
  String? grade;
  String? uomQty;
  int? unitId;
  List<ImagesModel>? images;
  UnitModel? unit;

  ProductModel({
    super.id,
    this.productId,
    this.barcode,
    this.sku,
    this.nameEn,
    this.grade,
    this.uomQty,
    this.unitId,
    this.images,
    this.unit,
  });

  @override
  ProductModel fromMap(dynamicData) {
    id = dynamicData['id'];
    productId = dynamicData['productId'];
    barcode = dynamicData['barcode'];
    sku = dynamicData['sku'];
    nameEn = dynamicData['nameEn'];
    grade = dynamicData['grade'];
    uomQty = dynamicData['uomQty'];
    unitId = dynamicData['unitId'];
    images = ImagesModel().fromMapList(dynamicData['images']);
    unit = dynamicData['unit'] != null
        ? UnitModel().fromMap(dynamicData['unit'])
        : null;
    return this;
  }

  @override
  List<ProductModel> fromMapList(List list) =>
      list.map((v) => fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(ProductModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<ProductModel> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
    id,
    productId,
    barcode,
    sku,
    nameEn,
    grade,
    uomQty,
    unitId,
    images,
    unit,
  ];
}

// ignore: must_be_immutable
class UnitModel extends MasterObject<UnitModel> {
  String? name;
  String? description;
  bool? status;

  UnitModel({super.id, this.name, this.description, this.status});

  @override
  UnitModel fromMap(dynamicData) {
    id = dynamicData['id'];
    name = dynamicData['name'];
    description = dynamicData['description'];
    status = dynamicData['status'];
    return this;
  }

  @override
  List<UnitModel> fromMapList(List list) =>
      list.map((v) => fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(UnitModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<UnitModel> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [id, name, description, status];
}

// ignore: must_be_immutable
class ImagesModel extends MasterObject<ImagesModel> {
  String? url;
  String? presignedUrl;

  ImagesModel({super.id, this.url, this.presignedUrl});

  @override
  ImagesModel fromMap(dynamicData) {
    id = dynamicData['id'];
    url = dynamicData['url'];
    presignedUrl = dynamicData['presignedUrl'];
    return this;
  }

  @override
  List<ImagesModel> fromMapList(List list) =>
      list.map((v) => ImagesModel().fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(ImagesModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<ImagesModel> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [id, url, presignedUrl];
}
