import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class Init {
  static Init? _instance;
  static Init get instance {
    _instance ??= Init._init();

    return _instance!;
  }

  Init._init();

  init() async {
    await downloadJavascript();
  }

  static Future<String> getDownloadPath() async {
    Directory? directory;
    try {
      directory = await getApplicationDocumentsDirectory();
    } catch (err) {
      // ignore: avoid_print
      print("Cannot get download folder path");
    }
    return directory!.path;
  }

  static Future<void> downloadJavascript() async {
    String? downloadDir = await getDownloadPath();
    String remoteJsUrl =
        "https://gist.githubusercontent.com/ismailcaakir/452a04e7d69362e37b00a5c487f8c2e0/raw/jsversion.json";
    String downloadPath = "$downloadDir/remoteJsCheck.json";

    var versionCheckStatus = false;
    try {
      if (File(downloadPath).existsSync()) {
        log("remoteJsCheck.json zaten inmiş!");

        versionCheckStatus = true;
      } else {
        log("remoteJsCheck.json yok, indiriliyor...");
        await Dio().download(
          remoteJsUrl,
          "$downloadDir/remoteJsCheck.json",
        );
        log("remoteJsCheck.json indirildi!");

        String data = await File(downloadPath).readAsString();
        var jsonSeriliazer = json.decode(data);

        await _downloadJavascriptFile(jsonSeriliazer["url"], downloadDir);
      }
    } catch (e) {
      log(e.toString());
    }

    String data = await File(downloadPath).readAsString();
    var jsonSeriliazer = json.decode(data);

    if (versionCheckStatus) {
      log("remoteJsCheck.json versiyonu kontrol ediliyor...!");
      try {
        Response jsonCheck =
            await Dio(BaseOptions(contentType: "application/json"))
                .get(remoteJsUrl);

        if (jsonCheck.data != null) {
          var jsonDataRemoteJsCheck = jsonDecode(jsonCheck.data);
          var version = jsonDataRemoteJsCheck["version"];
          if (jsonSeriliazer["version"] != version) {
            log("remoteJsCheck.json versiyonu değişti, indiriliyor...");

            await Dio().download(
              remoteJsUrl,
              "$downloadDir/remoteJsCheck.json",
            );

            await _downloadJavascriptFile(jsonSeriliazer["url"], downloadDir);
          }
          jsonSeriliazer = jsonDataRemoteJsCheck;
        }
      } catch (e) {
        log(e.toString());
      }
    }
  }

  static Future<void> _downloadJavascriptFile(
      String jsUrl, String downloadDir) async {
    try {
      if (File("$downloadDir/preload.js").existsSync()) {
        File("$downloadDir/preload.js").deleteSync();
      }
      await Dio().download(
        jsUrl,
        "$downloadDir/preload.js",
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
