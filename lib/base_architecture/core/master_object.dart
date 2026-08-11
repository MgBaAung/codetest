import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
abstract class MasterObject<T> extends Equatable {
  num? id;

  MasterObject({required this.id});

  T fromMap(dynamic dynamicData);

  Map<String, dynamic>? toMap(T? object);

  List<T> fromMapList(List<dynamic> dynamicDataList);

  List<Map<String, dynamic>?> toMapList(List<T> objectList);

  @override
  List<Object?> get props => [id];
}
