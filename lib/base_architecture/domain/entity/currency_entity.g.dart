// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyEntityAdapter extends TypeAdapter<CurrencyEntity> {
  @override
  final typeId = 1;

  @override
  CurrencyEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyEntity(
      status: fields[0] as bool?,
      path: fields[1] as String?,
      statusCode: (fields[2] as num?)?.toInt(),
      message: fields[3] as String?,
      data: (fields[4] as List?)?.cast<DataEntity>(),
      timestamp: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.path)
      ..writeByte(2)
      ..write(obj.statusCode)
      ..writeByte(3)
      ..write(obj.message)
      ..writeByte(4)
      ..write(obj.data)
      ..writeByte(5)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DataEntityAdapter extends TypeAdapter<DataEntity> {
  @override
  final typeId = 2;

  @override
  DataEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataEntity(
      id: (fields[0] as num?)?.toInt(),
      standardDisplayCode: fields[1] as String?,
      currency: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, DataEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.standardDisplayCode)
      ..writeByte(2)
      ..write(obj.currency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
