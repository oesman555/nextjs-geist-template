import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = FlutterSecureStorage();
  final String _passwordKey = 'user_password';

  Future<void> savePassword(String password) async {
    await _storage.write(key: _passwordKey, value: password);
  }

  Future<String?> getPassword() async {
    return await _storage.read(key: _passwordKey);
  }

  Future<void> deletePassword() async {
    await _storage.delete(key: _passwordKey);
  }
}
