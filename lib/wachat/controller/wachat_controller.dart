import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getDownloadPath() async {
  Directory? directory;
  try {
    directory = await getApplicationDocumentsDirectory();
  } catch (err) {
    print("Cannot get download folder path");
  }

  return directory!.path;
}

Future<String> loadJavascript() async {
  try {
    String? downloadDir = await getDownloadPath();
    var data = await rootBundle.loadString("$downloadDir/preload.js");

    return data;
  } catch (e) {
    return await rootBundle.loadString("assets/javascript/preload.js");
  }
}
