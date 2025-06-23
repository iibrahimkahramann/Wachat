import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/services.dart' show rootBundle;

final List<String> stickerPaths = [
  'assets/stickers/sticker1.gif',
  'assets/stickers/sticker2.gif',
  'assets/stickers/sticker3.gif',
  'assets/stickers/sticker4.gif',
  'assets/stickers/sticker5.gif',
  'assets/stickers/sticker6.gif',
  'assets/stickers/sticker7.gif',
  'assets/stickers/sticker9.gif',
  'assets/stickers/sticker10.gif',
  'assets/stickers/sticker11.gif',
  'assets/stickers/sticker12.gif',
  'assets/stickers/sticker13.gif',
  'assets/stickers/sticker14.gif',
  'assets/stickers/sticker15.gif',
];

Future<void> shareSticker(String assetPath, BuildContext context) async {
  final directory = await getTemporaryDirectory();
  final filePath = '${directory.path}/sticker.gif';

  final byteData = await rootBundle.load(assetPath);
  final bytes = byteData.buffer.asUint8List();

  final file = File(filePath);
  await file.writeAsBytes(bytes);

  try {
    final file = XFile(filePath);
    await Share.shareXFiles([file], text: 'Stickerınızı paylaşın!');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sticker paylaşılıyor!')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Paylaşma işlemi başarısız!')),
    );
  }
}
