// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_identity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmailIdentityAdapter extends TypeAdapter<EmailIdentity> {
  @override
  final typeId = 1;

  @override
  EmailIdentity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmailIdentity(
      email: fields[0] as String,
      username: fields[1] as String,
      avatarUrl: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, EmailIdentity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.avatarUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailIdentityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
