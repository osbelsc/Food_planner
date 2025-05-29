// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_plan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyPlanAdapter extends TypeAdapter<DailyPlan> {
  @override
  final int typeId = 2;

  @override
  DailyPlan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyPlan(
      date: fields[0] as DateTime,
      meals: (fields[1] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, DailyPlan obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.meals);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyPlanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
