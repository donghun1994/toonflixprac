import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageRepository {
// Create storage
  final storage = FlutterSecureStorage(aOptions: _getAndoridOptions());

  static AndroidOptions _getAndoridOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  Future getStroredValue(String key) async {
    try {
      return await storage.read(key: key);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<void> storeValue(String key, String value) async {
    try {
      return await storage.write(key: key, value: value);
    } catch (error) {
      return Future.error(error);
    }
  }
}
