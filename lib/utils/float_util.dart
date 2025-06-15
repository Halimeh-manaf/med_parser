import 'dart:typed_data';

/// TODO: make it as extension on [Uint8List] or [ByteData]
Float32List convertBytesToFloat32(Uint8List bytes) {
  final values = Float32List(bytes.length ~/ 2);

  final data = ByteData.view(bytes.buffer);

  for (var i = 0; i < bytes.length; i += 2) {
    int short = data.getInt16(i, Endian.little);
    values[i ~/ 2] = short / 32768.0;
  }

  return values;
}
