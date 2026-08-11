// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserEntityAdapter extends TypeAdapter<UserEntity> {
  @override
  final typeId = 0;

  @override
  UserEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserEntity()
      ..id = fields[0] as num?
      ..organization = fields[1] as String?
      ..phone = fields[2] as String?
      ..usename = fields[3] as String?
      ..code = fields[4] as String?
      ..ownerId = fields[5] as String?
      ..email = fields[6] as String?
      ..position = fields[7] as String?
      ..userId = fields[8] as String?
      ..locationId = fields[9] as num?
      ..organitionId = (fields[10] as num?)?.toInt()
      ..userRole = fields[11] as String?
      ..level = fields[12] as num?;
  }

  @override
  void write(BinaryWriter writer, UserEntity obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.organization)
      ..writeByte(2)
      ..write(obj.phone)
      ..writeByte(3)
      ..write(obj.usename)
      ..writeByte(4)
      ..write(obj.code)
      ..writeByte(5)
      ..write(obj.ownerId)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.position)
      ..writeByte(8)
      ..write(obj.userId)
      ..writeByte(9)
      ..write(obj.locationId)
      ..writeByte(10)
      ..write(obj.organitionId)
      ..writeByte(11)
      ..write(obj.userRole)
      ..writeByte(12)
      ..write(obj.level);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
