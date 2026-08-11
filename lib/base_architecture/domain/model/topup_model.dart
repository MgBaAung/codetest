import 'dart:io';
import 'package:b2b_freshmore/base_architecture/core/master_object.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/wallet_payment_model.dart';

// ignore: must_be_immutable
class TopupModel extends MasterObject<TopupModel> {
  String? amount;
  WalletPaymentDataModel? payment;
  File? attachment;
  String? remark;
  String? name;
  String? phone;

  TopupModel({required super.id});

  @override
  TopupModel fromMap(dynamicData) {
    return this;
  }

  @override
  List<TopupModel> fromMapList(List<dynamic> dynamicDataList) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toMap(TopupModel? object) {
    return {
      'amount': amount,
      'paymentMethod': payment?.name,
      'paymentReference': "",
      'currency': "",
      'remark': remark,
    };
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<TopupModel> objectList) {
    throw UnimplementedError();
  }
}
