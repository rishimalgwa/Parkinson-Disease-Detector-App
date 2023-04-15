import 'dart:io';
import 'dart:typed_data';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart' as pp;

Future<File> writeToFile(ByteData data) async {
  final buffer = data.buffer;
  Directory? tempDir = await pp.getExternalStorageDirectory();
  String tempPath = tempDir!.path;
  await ImageGallerySaver.saveImage(
      buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  var filePath =
      '$tempPath/pkd_image.png'; // file_01.tmp is dump file, can be anything
  return File(filePath)
      .writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
}
