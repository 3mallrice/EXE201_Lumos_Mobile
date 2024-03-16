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
        fullname: await LocalStorageHelper.getValue('username'),
        email: await LocalStorageHelper.getValue('email'),
        code: await LocalStorageHelper.getValue('code'),
        role: await LocalStorageHelper.getValue('role'),
        phone: await LocalStorageHelper.getValue('phone'),
        pronounce: await LocalStorageHelper.getValue('pronounce'),
        lastUpdate: await LocalStorageHelper.getValue('lastUpdate'),
        lastLogin: await LocalStorageHelper.getValue('updatedBy'),
        imgUrl: await LocalStorageHelper.getValue('imgUrl'));

    return userDetails;
  }

  static saveLoginAccount(UserDetails userDetails) async {
    await LocalStorageHelper.setValue('id', userDetails.id);
    await LocalStorageHelper.setValue('username', userDetails.fullname);
    await LocalStorageHelper.setValue('email', userDetails.email);
    await LocalStorageHelper.setValue('code', userDetails.code);
    await LocalStorageHelper.setValue('role', userDetails.role);
    await LocalStorageHelper.setValue('phone', userDetails.phone);
    await LocalStorageHelper.setValue('pronounce', userDetails.pronounce);
    await LocalStorageHelper.setValue('lastUpdate', userDetails.lastUpdate);
    await LocalStorageHelper.setValue('updatedBy', userDetails.lastLogin);
    await LocalStorageHelper.setValue('imgUrl', userDetails.imgUrl);
  }

  static clearLoginAccount() async {
    await LocalStorageHelper.setValue('id', -1);
    await LocalStorageHelper.setValue('username', '');
    await LocalStorageHelper.setValue('email', '');
    await LocalStorageHelper.setValue('code', '');
    await LocalStorageHelper.setValue('role', -1);
    await LocalStorageHelper.setValue('status', -1);
    await LocalStorageHelper.setValue('createdDate', '');
    await LocalStorageHelper.setValue('lastUpdate', '');
    await LocalStorageHelper.setValue('updatedBy', '');
    await LocalStorageHelper.setValue('imgUrl', '');
  }
}
