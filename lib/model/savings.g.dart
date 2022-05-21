// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'savings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavingsAdapter extends TypeAdapter<Savings> {
  @override
  final int typeId = 0;

  @override
  Savings read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Savings(
      amount: fields[0] as int,
      date: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Savings obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavingsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
