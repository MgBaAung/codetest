import 'package:b2b_freshmore/base_architecture/core/master_object.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/address_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/cart_model.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/payment_model.dart';
import 'package:b2b_freshmore/presentation/screen/checkout/component/payment_option_item.dart';

// ignore: must_be_immutable
class OrderModel extends MasterObject<OrderModel> {
  AddressData? address;
  PaymentModel? payment;
  List<DataModel>? orderItems;
  SingingCharacter? paymentOption;
  double? taxAmount;
  double? subtotalAmount;
  String? standardDisplayCode;
  String? currency;
  String? paymentMethod;
  String? paymentOptionName;
  String? orderNo;
  DiscountModel? discountModel;

  OrderModel({
    this.address,
    this.payment,
    this.orderItems,
    this.paymentOption,
    this.currency,
    this.standardDisplayCode,
    this.subtotalAmount,
    this.taxAmount,
    this.paymentMethod,
    this.orderNo,
    this.discountModel,
  }) : super(id: 0);

  @override
  OrderModel fromMap(dynamicData) {
    paymentMethod = dynamicData['data']['paymentMethod'];
    paymentOptionName = dynamicData['data']['paymentOption'];
    orderNo = dynamicData['data']['orderNo'];
    id = dynamicData['data']['id'];
    return this;
  }

  OrderModel copyWith({
    AddressData? address,
    PaymentModel? payment,
    List<DataModel>? orderItems,
    SingingCharacter? paymentOption,
    double? taxAmount,
    double? subtotalAmount,
    String? standardDisplayCode,
    String? currency,
    DiscountModel? discountModel,
  }) {
    return OrderModel(
      address: address ?? this.address,
      payment: payment ?? this.payment,
      orderItems: orderItems ?? this.orderItems,
      paymentOption: paymentOption ?? this.paymentOption,
      taxAmount: taxAmount ?? this.taxAmount,
      subtotalAmount: subtotalAmount ?? this.subtotalAmount,
      standardDisplayCode: standardDisplayCode ?? this.standardDisplayCode,
      currency: currency ?? this.currency,
      discountModel: discountModel ?? this.discountModel,
    );
  }

  @override
  List<Object?> get props => [
    address,
    payment,
    orderItems,
    paymentOption,
    currency,
    standardDisplayCode,
    subtotalAmount,
    taxAmount,
  ];

  @override
  List<OrderModel> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(OrderModel? object) {
    return {
      "standardDisplayCode": object?.standardDisplayCode?.toUpperCase(),
      "subtotalAmount": calculateTotal(orderItems!),
      "taxAmount": 0,
      "totalAmount": calculateTotal(orderItems!),
      "currency": object?.currency,
      "orgAddress": {
        "name": address?.name,
        "phone": "",
        "address": address?.address,
        "latitude": address?.latitude,
        "longitude": address?.longitude,
      },
      "remark": "Customer Remark",
      "paymentStatus": "PENDING",
      "paymentMethod": payment?.name,
      "paymentReference": "",
      "paymentOption": paymentOption?.name,
      "items": orderItems
          ?.map(
            (item) => {
              "productId": item.productId,
              "quantity": item.quantity,
              "price": item.price,
              "total": item.subTotal,
            },
          )
          .toList(),
    };
  }

  double calculateTotal(List<DataModel> cartList) {
    double total = 0;
    for (var item in cartList) {
      total += (item.price ?? 0) * (item.quantity ?? 0);
    }
    return total;
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<OrderModel> objectList) {
    throw UnimplementedError();
  }
}
