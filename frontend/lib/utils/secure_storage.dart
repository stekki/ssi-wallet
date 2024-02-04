import 'dart:io' show Platform;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorage {
  Future<void> writeToken(String token);
  Future<String?> getToken();
  Future<void> deleteToken();
}

class SecureStorageUtil implements SecureStorage {
  //Singleton pattern to avoid object creation when accesing the methods
  //through SecureStorageUtil().readToken()
  static final SecureStorageUtil _instance = SecureStorageUtil._internal();
  factory SecureStorageUtil() => _instance;

  final SecureStorage _storage = Platform.isAndroid || Platform.isIOS
      ? RealSecureStorage()
      : FakeSecureStorage();

  SecureStorageUtil._internal();

  @override
  Future<void> writeToken(String token) => _storage.writeToken(token);

  @override
  Future<String?> getToken() => _storage.getToken();

  @override
  Future<void> deleteToken() => _storage.deleteToken();
}

// for iOS/Android builds
class RealSecureStorage implements SecureStorage {
  static const _storage = FlutterSecureStorage();

  @override
  Future<void> writeToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }

  @override
  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }

  @override
  Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
  }
}

// for Web, Mac and Linux builds
class FakeSecureStorage implements SecureStorage {
  final Map<String, String> _storage = {};

  @override
  Future<void> writeToken(String token) async {
    _storage['token'] = token;
  }

  @override
  Future<String?> getToken() async {
    return _storage['token'];
  }

  @override
  Future<void> deleteToken() async {
    _storage.remove('token');
  }
}
