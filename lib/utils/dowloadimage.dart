import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

Future<bool> dowloadImage(String url) async {
  HttpClient clinet = HttpClient();
  final require = await clinet.getUrl(Uri.parse(url));
  final response = await require.close();
  if (response.statusCode == 200) {
    var bytes = await consolidateHttpClientResponseBytes(response);
    final result = await ImageGallerySaver.saveImage(bytes);
    return result['isSuccess'];
  }
  return false;
}
