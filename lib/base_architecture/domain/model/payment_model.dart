import '../../core/master_object.dart';

// ignore: must_be_immutable
class PaymentModel extends MasterObject<PaymentModel> {
  String? name;
  String? logoUrl;
  bool? status;
  String? createdAt;
  String? updatedAt;
  String? trasferAccountName;
  String? trasferAccountNo;

  PaymentModel({
    super.id,
    this.name,
    this.logoUrl,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.trasferAccountName,
    this.trasferAccountNo,
  });

  @override
  PaymentModel fromMap(dynamicData) {
    id = dynamicData['id'];
    name = dynamicData['name'];
    logoUrl = dynamicData['logoUrl'];
    status = dynamicData['status'];
    createdAt = dynamicData['createdAt'];
    updatedAt = dynamicData['updatedAt'];
    trasferAccountName = dynamicData['trasferAccountName'];
    trasferAccountNo = dynamicData['trasferAccountNo'];
    return this;
  }

  @override
  List<PaymentModel> fromMapList(List list) =>
      list.map((v) => fromMap(v)).toList();

  @override
  Map<String, dynamic>? toMap(PaymentModel? object) {
    return {};
  }

  @override
  List<Map<String, dynamic>?> toMapList(List<PaymentModel> objectList) {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [id, name, logoUrl, status, createdAt, updatedAt];
}
