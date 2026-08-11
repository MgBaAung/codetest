import '../../core/master_object.dart';

// ignore: must_be_immutable
class WalletHistoryDataModel extends MasterObject<WalletHistoryDataModel> {
  int? walletId;
  String? transactionNo;
  String? type;
  String? direction;
  String? amount;
  String? balanceBefore;
  String? balanceAfter;
  String? orderNo;
  String? topupRequestNo;
  String? remark;
  String? currency;
  String? createdBy;
  String? createdAt;
  int? topupRequestId;
  String? status;

  WalletHistoryDataModel({
    super.id,
    this.walletId,
    this.transactionNo,
    this.type,
    this.direction,
    this.amount,
    this.balanceBefore,
    this.balanceAfter,
    this.orderNo,
    this.topupRequestNo,
    this.remark,
    this.currency,
    this.createdBy,
    this.createdAt,
    this.topupRequestId,
    this.status,
  });

  @override
  WalletHistoryDataModel fromMap(dynamicData) {
    id = dynamicData['id'];
    walletId = dynamicData['walletId'];
    transactionNo = dynamicData['transactionNo'];
    type = dynamicData['type'];
    direction = dynamicData['direction'];
    amount = dynamicData['amount'];
    balanceBefore = dynamicData['balanceBefore'];
    balanceAfter = dynamicData['balanceAfter'];
    orderNo = dynamicData['orderNo'];
    topupRequestNo = dynamicData['topupRequestNo'];
    remark = dynamicData['remark'];
    currency = dynamicData['currency'];
    createdBy = dynamicData['createdBy'];
    createdAt = dynamicData['createdAt'];
    topupRequestId = dynamicData['topupRequestId'];
    status = dynamicData['status'];
    return this;
  }

  @override
  List<WalletHistoryDataModel> fromMapList(List list) =>
      list.map((v) => WalletHistoryDataModel().fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(WalletHistoryDataModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(
    List<WalletHistoryDataModel> objectList,
  ) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
    id,
    walletId,
    transactionNo,
    type,
    direction,
    amount,
    balanceBefore,
    balanceAfter,
    orderNo,
    topupRequestNo,
    remark,
    currency,
    createdBy,
    createdAt,
    topupRequestId,
  ];
}
