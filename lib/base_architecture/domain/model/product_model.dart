import 'package:b2b_freshmore/base_architecture/core/master_object.dart';

// ignore: must_be_immutable
class ProductModel extends MasterObject<ProductModel> {
  int? statuscode;
  String? message;
  int? productId;
  List<ProductData>? productData = [];

  ProductModel({
    this.productId,
    this.message,
    this.statuscode,
    this.productData,
  }) : super(id: 0);

  @override
  List<Object?> get props => [statuscode, message, productId, productData];

  @override
  ProductModel fromMap(dynamicData) {
    final rawData = dynamicData["data"];
    if (rawData != null) {
      if (rawData is List) {
        productData = rawData.map((data) {
          return ProductData().fromMap(data);
        }).toList();
      } else if (rawData is Map) {
        productData = [ProductData().fromMap(rawData)];
      }
    } else {
      productData = [];
    }
    return ProductModel(
      statuscode: dynamicData['statusCode'],
      message: dynamicData['message'],
      productData: productData,
    );
  }

  @override
  List<ProductModel> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(ProductModel? object) {
    return {"productId": productId};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<ProductModel> objectList) {
    throw UnimplementedError();
  }
}

// ignore: must_be_immutable
class ProductData extends MasterObject<ProductData> {
  String? descrip;
  num? price;
  String? currency;
  num? subCategoId;
  String? subCategoName;
  String? featStatus;
  List<Images>? images;
  String? name;
  String? sku;
  String? updatedAt;
  String? categoryName;
  String? priceStatus;
  String? uomQty;
  bool? isBookmark;
  UnitModel? unit;

  ProductData({
    num? id,
    this.descrip,
    this.price,
    this.currency,
    this.subCategoId,
    this.subCategoName,
    this.featStatus,
    this.name,
    this.updatedAt,
    this.categoryName,
    this.priceStatus,
    this.uomQty,
    this.isBookmark,
    this.unit,
  }) : super(id: id ?? 0);

  @override
  List<Object?> get props => [
    descrip,
    price,
    currency,
    subCategoId,
    subCategoName,
    featStatus,
    name,
    updatedAt,
    categoryName,
    priceStatus,
    uomQty,
    isBookmark,
    unit,
  ];

  @override
  ProductData fromMap(dynamicData) {
    descrip = dynamicData["enDescription"];
    id = dynamicData["id"];
    featStatus = dynamicData['featStatus'];
    name = dynamicData['nameEn'];
    sku = dynamicData['sku'];
    isBookmark = dynamicData['isBookmark'];
    uomQty = dynamicData['uomQty'];
    updatedAt = dynamicData['updatedAt'];
    categoryName = dynamicData['category'] == null
        ? ""
        : dynamicData['category']['enName'];
    final pricingList = dynamicData["productPricings"] as List?;

    if (pricingList != null && pricingList.isNotEmpty) {
      currency = pricingList[0]["currency"];
      price = pricingList[0]["price"];
      priceStatus = pricingList[0]["priceStatus"];
    } else {
      currency = null;
      price = null;
    }

    if (dynamicData["subCategory"] != null) {
      subCategoId = dynamicData["subCategory"]["id"];
      subCategoName = dynamicData["subCategory"]["enName"];
    }
    final imageList = dynamicData['images'] as List?;
    if (imageList != null && imageList.isNotEmpty) {
      images = imageList.map((img) => Images().fromMap(img)).toList();
    } else {
      images = [];
    }
    unit = UnitModel().fromMap(dynamicData['unit']);

    return this;
  }

  @override
  List<ProductData> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(ProductData? object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<ProductData> objectList) {
    throw UnimplementedError();
  }
}

// ignore: must_be_immutable
class Images extends MasterObject<Images> {
  String? url;

  Images({this.url}) : super(id: 0);
  @override
  Images fromMap(dynamicData) {
    url = dynamicData['url'];
    return this;
  }

  @override
  List<Images> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(Images? object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<Images> objectList) {
    throw UnimplementedError();
  }
}

// ignore: must_be_immutable
class UnitModel extends MasterObject<UnitModel> {
  String? name;
  String? description;
  bool? status;

  UnitModel({super.id, this.name, this.description, this.status});

  @override
  UnitModel fromMap(dynamicData) => UnitModel(
    id: dynamicData['id'],
    name: dynamicData['name'],
    description: dynamicData['description'],
    status: dynamicData['status'],
  );
  @override
  List<UnitModel> fromMapList(List list) =>
      list.map((v) => fromMap(v)).toList();
  @override
  List<Object?> get props => [id, name, description, status];

  @override
  Map<String, dynamic>? toMap(UnitModel? object) {
    throw UnimplementedError();
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<UnitModel> objectList) {
    throw UnimplementedError();
  }
}
