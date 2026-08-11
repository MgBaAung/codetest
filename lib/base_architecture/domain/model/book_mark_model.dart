import 'package:b2b_freshmore/base_architecture/core/master_object.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/product_model.dart';

// ignore: must_be_immutable
class BookMarkModel extends MasterObject<BookMarkModel> {
  int? statusCode;
  String? message;
  int? productId;
  List<ProductData>? products;

  BookMarkModel({this.productId}) : super(id: 0);

  @override
  BookMarkModel fromMap(dynamicData) {
    statusCode = dynamicData['statusCode'];
    message = dynamicData['message'];
    final rawData = productId != null ? null : dynamicData["data"];
    if (rawData != null) {
      if (rawData is List) {
        products = rawData.map((data) {
          return ProductData().fromMap(data);
        }).toList();
      } else if (rawData is Map) {
        int? count = rawData['count'];
        products = count != null ? [] : [ProductData().fromMap(rawData)];
      }
    } else {
      products = [];
    }

    return this;
  }

  @override
  List<BookMarkModel> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(BookMarkModel? object) {
    return {"productId": productId};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<BookMarkModel> objectList) {
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
  UnitModel? unitModel;

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
    this.unitModel,
  }) : super(id: id ?? 0);

  @override
  ProductData fromMap(dynamicData) {
    descrip = dynamicData["enDescription"];
    id = dynamicData["product"]["id"];
    featStatus = dynamicData['featStatus'];
    name = dynamicData["product"]['nameEn'];
    sku = dynamicData['sku'];
    isBookmark = dynamicData['isBookmark'];
    uomQty = dynamicData["product"]['uomQty'];
    updatedAt = dynamicData['updatedAt'];
    categoryName = dynamicData['category'] == null
        ? ""
        : dynamicData['category']['enName'];
    final pricingList = dynamicData["product"]["productPricings"] as List?;

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
    final imageList = dynamicData["product"]['images'] as List?;
    if (imageList != null && imageList.isNotEmpty) {
      images = imageList.map((img) => Images().fromMap(img)).toList();
    } else {
      images = [];
    }
    unitModel = UnitModel().fromMap(dynamicData['product']["unit"]);
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
