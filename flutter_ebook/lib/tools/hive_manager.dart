import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
// import 'package:device_info/device_info.dart';

class HiveManager {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  static const String TOKEN_KEY = 'tokenKey';
  static const String REFRESH_TOKEN_KEY = 'refreshTokenKey';

  Future<bool> isBoxExist({required String boxName}) async {
    final openBox = await Hive.openBox(boxName);
    int length = openBox.length;
    return length != 0;
  }

  Future<bool> get containsTokenKey async {
    return this.secureStorage.containsKey(key: TOKEN_KEY);
  }

  Future<bool> get containsRefreshTokenKey async {
    return this.secureStorage.containsKey(key: REFRESH_TOKEN_KEY);
  }

  /// Получение ID устройства
  // Future<String?> getDeviceId() async {
  //   String? id;
  //   final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  //   try {
  //     if (Platform.isAndroid) {
  //       final build = await deviceInfoPlugin.androidInfo;
  //       id = build.androidId;
  //     } else if (Platform.isIOS) {
  //       final data = await deviceInfoPlugin.iosInfo;
  //       id = data.identifierForVendor;
  //     }
  //   } on PlatformException {
  //     print('Failed to get platform version');
  //   }
  //   return id;
  // }

  /// Сохранение [token] в защищенное хранилище
  Future<void> saveUserToken(String token) async {
    try {
      if (!(await this.containsTokenKey)) {
        final secureKey = Hive.generateSecureKey();
        await this
            .secureStorage
            .write(key: TOKEN_KEY, value: base64UrlEncode(secureKey));
      }

      var encryptionKey =
          base64Url.decode((await this.secureStorage.read(key: TOKEN_KEY))!);

      var encryptedBox = await Hive.openBox('auth',
          encryptionCipher: HiveAesCipher(encryptionKey));
      encryptedBox.put('token', token);
      print(encryptedBox.get('token'));
    } on Exception catch (e) {
      print(e.toString());
      // throw CacheException(message: e.toString());
    }
  }

  /// Сохранение [refresh token] в защищенное хранилище
  Future<void> saveRefreshToken(String refreshToken) async {
    try {
      if (!(await this.containsRefreshTokenKey)) {
        final secureKey = Hive.generateSecureKey();
        await this
            .secureStorage
            .write(key: REFRESH_TOKEN_KEY, value: base64UrlEncode(secureKey));
      }

      var encryptionKey = base64Url
          .decode((await this.secureStorage.read(key: REFRESH_TOKEN_KEY))!);

      var encryptedBox = await Hive.openBox('auth',
          encryptionCipher: HiveAesCipher(encryptionKey));
      encryptedBox.put('refresh_token', refreshToken);
      print(encryptedBox.get('refresh_token'));
    } on Exception catch (e) {
      print(e.toString());
      // throw CacheException(message: e.toString());
    }
  }

  Future<String?> get getUserToken async {
    try {
      if (!(await this.containsTokenKey)) {
        print('Токен не содержится в хранилище');
        return null;
      }
      var encryptionKey =
          base64Url.decode((await this.secureStorage.read(key: TOKEN_KEY))!);

      var encryptedBox = await Hive.openBox('auth',
          encryptionCipher: HiveAesCipher(encryptionKey));
      return encryptedBox.get('token').toString();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<String?> get getRefreshToken async {
    try {
      if (!(await this.containsRefreshTokenKey)) {
        print('Токен не содержится в хранилище');
        return null;
      }
      var encryptionKey = base64Url
          .decode((await this.secureStorage.read(key: REFRESH_TOKEN_KEY))!);

      var encryptedBox = await Hive.openBox('auth',
          encryptionCipher: HiveAesCipher(encryptionKey));
      return encryptedBox.get('refresh_token').toString();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  /// Очистить хранилище от записанных токенов
  Future<void> clearTokens() async {
    try {
      if (!(await this.containsTokenKey) &&
          !(await this.containsRefreshTokenKey)) {
        print('Токены не содержится в хранилище');
        return;
      }
      var encryptionKey =
          base64Url.decode((await this.secureStorage.read(key: TOKEN_KEY))!);
      var encryptedBox = await Hive.openBox('auth',
          encryptionCipher: HiveAesCipher(encryptionKey));

      var encryptionKeyR = base64Url
          .decode((await this.secureStorage.read(key: REFRESH_TOKEN_KEY))!);
      var encryptedBoxR = await Hive.openBox('auth',
          encryptionCipher: HiveAesCipher(encryptionKeyR));

      encryptedBox.clear();
      encryptedBoxR.clear();
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
