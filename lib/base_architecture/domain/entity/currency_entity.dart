import 'package:b2b_freshmore/base_architecture/core/base_entity.dart';
import 'package:b2b_freshmore/base_architecture/domain/model/currency_model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
part 'currency_entity.g.dart';

@HiveType(typeId: 1)
class CurrencyEntity extends BaseEntity<CurrencyModel, CurrencyEntity> {
  @HiveField(0)
  bool? status;
  @HiveField(1)
  String? path;
  @HiveField(2)
  int? statusCode;
  @HiveField(3)
  String? message;
  @HiveField(4)
  List<DataEntity>? data;
  @HiveField(5)
  String? timestamp;

  CurrencyEntity({
    this.status,
    this.path,
    this.statusCode,
    this.message,
    this.data,
    this.timestamp,
  });

  @override
  CurrencyEntity fromModel(CurrencyModel model) => CurrencyEntity(
    status: model.status,
    path: model.path,
    statusCode: model.statusCode,
    message: model.message,
    data: model.data?.map((e) => DataEntity().fromModel(e)).toList(),
    timestamp: model.timestamp,
  );

  @override
  CurrencyModel toModel() => CurrencyModel(
    status: status,
    path: path,
    statusCode: statusCode,
    message: message,
    data: data?.map((e) => e.toModel()).toList(),
    timestamp: timestamp,
  );

  static void register() {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(CurrencyEntityAdapter());
    }

    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(DataEntityAdapter());
    }
  }
}

@HiveType(typeId: 2)
class DataEntity extends BaseEntity<DataModel, DataEntity> {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? standardDisplayCode;
  @HiveField(2)
  String? currency;

  DataEntity({this.id, this.standardDisplayCode, this.currency});

  @override
  DataEntity fromModel(DataModel model) {
    id = model.id?.toInt();
    standardDisplayCode = model.standardDisplayCode;
    currency = model.currency;
    return this;
  }

  @override
  DataModel toModel() => DataModel(
    id: id,
    standardDisplayCode: standardDisplayCode,
    currency: currency,
  );
}
