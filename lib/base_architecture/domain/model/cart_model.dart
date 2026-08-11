import '../../core/master_object.dart';

// ignore: must_be_immutable
class CartModel extends MasterObject<CartModel> {
  bool? status;
  String? path;
  int? statusCode;
  String? message;
  String? timestamp;
  List<DataModel>? data;
  int? productId;
  int? quantity;
  num? price;
  num? subTotal;
  String? currency;
  DiscountModel? discountModel;

  CartModel({
    super.id,
    this.status,
    this.path,
    this.statusCode,
    this.message,
    this.timestamp,
    this.data,
    this.productId,
    this.quantity,
    this.price,
    this.subTotal,
    this.currency,
    this.discountModel,
  });

  @override
  CartModel fromMap(dynamicData) {
    status = dynamicData['status'];
    path = dynamicData['path'];
    statusCode = dynamicData['statusCode'];
    message = dynamicData['message'];
    timestamp = dynamicData['timestamp'];
    var dat = dynamicData['data']['items'];
    data = dat is List ? DataModel().fromMapList(dat) : null;

    var discount = dynamicData['data']['discount'];
    discountModel = discount != null ? DiscountModel().fromMap(discount) : null;

    return this;
  }

  @override
  List<CartModel> fromMapList(List list) =>
      list.map((v) => fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(CartModel? object) {
    return currency != null
        ? {
            "productId": productId,
            "quantity": quantity,
            "price": price,
            "subTotal": subTotal,
            "currency": currency,
          }
        : {
            "items": object!.data!
                .map(
                  (e) => {
                    "productId": e.productId,
                    "quantity": e.quantity,
                    "price": e.price,
                    "subTotal": (e.quantity ?? 0) * (e.price ?? 0),
                    "currency": e.currency,
                  },
                )
                .toList(),
          };
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<CartModel> objectList) {
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
class DataModel extends MasterObject<DataModel> {
  String? orgCode;
  int? orgUserId;
  int? productId;
  int? quantity;
  num? price;
  num? subTotal;
  String? currency;
  String? createdAt;
  String? updatedAt;
  ProductModel? product;

  DataModel({
    super.id,
    this.orgCode,
    this.orgUserId,
    this.productId,
    this.quantity,
    this.price,
    this.subTotal,
    this.currency,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  @override
  DataModel fromMap(dynamicData) {
    id = dynamicData['id'];
    orgCode = dynamicData['orgCode'];
    orgUserId = dynamicData['orgUserId'];
    productId = dynamicData['productId'];
    quantity = dynamicData['quantity'];
    price = dynamicData['price'];
    subTotal = dynamicData['subTotal'];
    currency = dynamicData['currency'];
    createdAt = dynamicData['createdAt'];
    updatedAt = dynamicData['updatedAt'];
    product = dynamicData['product'] != null
        ? ProductModel().fromMap(dynamicData['product'])
        : null;
    return this;
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
    orgCode,
    orgUserId,
    productId,
    quantity,
    price,
    subTotal,
    currency,
    createdAt,
    updatedAt,
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
      list.map((v) => ProductModel().fromMap(v)).toList();

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
      list.map((v) => UnitModel().fromMap(v)).toList();

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

  ImagesModel({super.id, this.url});

  @override
  ImagesModel fromMap(dynamicData) {
    id = dynamicData['id'];
    url = dynamicData['url'];
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
  List<Object?> get props => [id, url];
}

// ignore: must_be_immutable
class DiscountModel extends MasterObject<DiscountModel> {
  int? orgId;
  int? countryId;
  int? currentLevel;
  String? currency;
  int? orderDiscountPercent;
  num? orderDiscountAmount;
  num? inputAmount;

  DiscountModel({
    super.id,
    this.orgId,
    this.countryId,
    this.currentLevel,
    this.currency,
    this.orderDiscountPercent,
    this.orderDiscountAmount,
    this.inputAmount,
  });

  @override
  DiscountModel fromMap(dynamicData) {
    orgId = dynamicData['orgId'];
    countryId = dynamicData['countryId'];
    currentLevel = dynamicData['currentLevel'];
    currency = dynamicData['currency'];
    orderDiscountPercent = dynamicData['orderDiscountPercent'];
    orderDiscountAmount = dynamicData['orderDiscountAmount'];
    inputAmount = dynamicData['inputAmount'];
    return this;
  }

  @override
  List<DiscountModel> fromMapList(List list) =>
      list.map((v) => fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(DiscountModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<DiscountModel> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
    orgId,
    countryId,
    currentLevel,
    currency,
    orderDiscountPercent,
    inputAmount,
    orderDiscountAmount,
  ];
}
