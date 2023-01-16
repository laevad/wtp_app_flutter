import 'package:flutter_secure_storage/flutter_secure_storage.dart';

FlutterSecureStorage storage = const FlutterSecureStorage();
AndroidOptions _secureOption() => const AndroidOptions(
      encryptedSharedPreferences: true,
    );

class IsAuth {
  static Future setToken({required String key, required String value}) async {
    await storage.write(
      key: key,
      value: value,
      aOptions: _secureOption(),
    );
  }

  static Future getData(String key) async {
    return await storage.read(key: key, aOptions: _secureOption());
  }

  static deleteKey({required String key}) async {
    await storage.delete(key: key, aOptions: _secureOption());
  }

  static deleteAll() async {
    await storage.deleteAll(aOptions: _secureOption());
  }
}
