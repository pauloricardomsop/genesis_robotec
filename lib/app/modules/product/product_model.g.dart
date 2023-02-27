// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KitAdapter extends TypeAdapter<Kit> {
  @override
  final int typeId = 0;

  @override
  Kit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Kit(
      name: fields[0] as String,
      description: fields[1] as String,
      products: (fields[2] as List).cast<Product>(),
      version: fields[4] as int,
    )
      ..favorite = fields[3] as bool
      ..downloaded = fields[5] as bool;
  }

  @override
  void write(BinaryWriter writer, Kit obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.products)
      ..writeByte(3)
      ..write(obj.favorite)
      ..writeByte(4)
      ..write(obj.version)
      ..writeByte(5)
      ..write(obj.downloaded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 1;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      name: fields[0] as String,
      description: fields[1] as String,
      pdf: fields[2] as String,
      image: fields[3] as String,
      model: fields[4] as String,
      video: fields[5] as String,
      kitName: fields[9] as String,
      steps: (fields[6] as List).cast<Step>(),
    )
      ..favorite = fields[7] as bool
      ..downloaded = fields[8] as bool;
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.pdf)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.model)
      ..writeByte(5)
      ..write(obj.video)
      ..writeByte(6)
      ..write(obj.steps)
      ..writeByte(7)
      ..write(obj.favorite)
      ..writeByte(8)
      ..write(obj.downloaded)
      ..writeByte(9)
      ..write(obj.kitName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StepAdapter extends TypeAdapter<Step> {
  @override
  final int typeId = 2;

  @override
  Step read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Step(
      fields[0] as String,
    )
      ..completed = fields[1] as bool
      ..downloaded = fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, Step obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.model)
      ..writeByte(1)
      ..write(obj.completed)
      ..writeByte(2)
      ..write(obj.downloaded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
