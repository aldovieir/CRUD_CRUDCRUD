import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  final storage = new FlutterSecureStorage();

  //read string
  Future<String> readString(String key) async {
    return await storage.read(key: key);
  }

  //write string
  Future<void> writeString(
      {@required String key, @required String value}) async {
    return await storage.write(key: key, value: value);
  }

  //delete login data
  Future<void> deleteLogin() async {
    await storage.delete(key: "email");
  }
}
