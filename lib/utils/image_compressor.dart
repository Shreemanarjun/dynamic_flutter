import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<Uint8List> getCompressedImage(Uint8List list) async {
  var result = await FlutterImageCompress.compressWithList(
    list,
    minHeight: 300,
    minWidth: 300,
    quality: 50,

  );
  print(list.length);
  print(result.length);
  return result;
}

