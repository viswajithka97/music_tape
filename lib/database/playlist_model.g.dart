// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistmodelAdapter extends TypeAdapter<Playlistmodel> {
  @override
  final int typeId = 0;

  @override
  Playlistmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Playlistmodel(
      songname: fields[0] as String?,
      artist: fields[1] as String?,
      songurl: fields[2] as String?,
      duration: fields[3] as int?,
      id: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Playlistmodel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.songname)
      ..writeByte(1)
      ..write(obj.artist)
      ..writeByte(2)
      ..write(obj.songurl)
      ..writeByte(3)
      ..write(obj.duration)
      ..writeByte(4)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
