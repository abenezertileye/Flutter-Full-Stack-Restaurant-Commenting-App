import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._privateConstructor() {
    _initialize();
  }

  static final SecureStorage instance = SecureStorage._privateConstructor();

  final FlutterSecureStorage _storage = FlutterSecureStorage();
//STORES TOKEN
  Future<void> write(String key, value) async {
    print("writing to storage...");
    print("$key : $value");
    await _storage.write(key: key, value: value);
  }

//READS TOKEN
  Future<String?> read(key) async {
    return await _storage.read(key: key);
  }

//DELETES TOKEN
  Future<void> delete(key) async {
    await _storage.delete(key: key);
  }

  Future<void> _initialize() async {}
}
