import 'package:exe201_lumos_mobile/api_model/authentication/login.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

class LocalStorageHelper {
  var log = Logger();
  LocalStorageHelper._internal();
  static final LocalStorageHelper _shared = LocalStorageHelper._internal();

  factory LocalStorageHelper() {
    return _shared;
  }

  Box<dynamic>? hiveBox;

  static initLocalStorageHelper() async {
    try {
      _shared.hiveBox = await Hive.openBox('Lumos');
    } catch (e) {
      _shared.log.e('Failed to open hive box: $e');
    }
  }

  static dynamic getValue(String key) {
    dynamic value = _shared.hiveBox?.get(key);
    _shared.log.i(value);
    return value;
  }

  static setValue(String key, dynamic val) {
    _shared.hiveBox?.put(key, val);
  }
}

class LoginAccount {
  static Future<UserDetails> loadAccount() async {
    UserDetails userDetails = UserDetails(
        id: await LocalStorageHelper.getValue('id'),
        username: await LocalStorageHelper.getValue('username'),
        email: await LocalStorageHelper.getValue('email'),
        code: await LocalStorageHelper.getValue('code'),
        role: await LocalStorageHelper.getValue('role'),
        phone: await LocalStorageHelper.getValue('phone'),
        pronounce: await LocalStorageHelper.getValue('pronounce'),
        status: await LocalStorageHelper.getValue('status'),
        createdDate: await LocalStorageHelper.getValue('createdDate'),
        lastUpdate: await LocalStorageHelper.getValue('lastUpdate'),
        updatedBy: await LocalStorageHelper.getValue('updatedBy'),
        imgUrl: await LocalStorageHelper.getValue('imgUrl'));

    return userDetails;
  }

  static saveLoginAccount(UserDetails userDetails) async {
    await LocalStorageHelper.setValue('id', userDetails.id);
    await LocalStorageHelper.setValue('username', userDetails.username);
    await LocalStorageHelper.setValue('email', userDetails.email);
    await LocalStorageHelper.setValue('code', userDetails.code);
    await LocalStorageHelper.setValue('role', userDetails.role);
    await LocalStorageHelper.setValue('status', userDetails.status);
    await LocalStorageHelper.setValue('phone', userDetails.phone);
    await LocalStorageHelper.setValue('pronounce', userDetails.pronounce);
    await LocalStorageHelper.setValue('createdDate', userDetails.createdDate);
    await LocalStorageHelper.setValue('lastUpdate', userDetails.lastUpdate);
    await LocalStorageHelper.setValue('updatedBy', userDetails.updatedBy);
    await LocalStorageHelper.setValue('imgUrl', userDetails.imgUrl);
  }

  static clearLoginAccount() async {
    await LocalStorageHelper.setValue('id', null);
    await LocalStorageHelper.setValue('username', null);
    await LocalStorageHelper.setValue('email', null);
    await LocalStorageHelper.setValue('code', null);
    await LocalStorageHelper.setValue('role', null);
    await LocalStorageHelper.setValue('status', null);
    await LocalStorageHelper.setValue('createdDate', null);
    await LocalStorageHelper.setValue('lastUpdate', null);
    await LocalStorageHelper.setValue('updatedBy', null);
    await LocalStorageHelper.setValue('imgUrl', null);
  }
}
