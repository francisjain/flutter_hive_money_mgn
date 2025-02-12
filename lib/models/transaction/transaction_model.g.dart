// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransactionModelsAdapter extends TypeAdapter<TransactionModels> {
  @override
  final int typeId = 3;

  @override
  TransactionModels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransactionModels(
      purpose: fields[1] as String,
      amount: fields[2] as double,
      date: fields[3] as DateTime,
      type: fields[4] as CategoryType,
      category: fields[5] as CategoryModels,
    )..id = fields[0] as String?;
  }

  @override
  void write(BinaryWriter writer, TransactionModels obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.purpose)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransactionModelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
