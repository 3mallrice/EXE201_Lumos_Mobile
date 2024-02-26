import 'package:exe201_lumos_mobile/core/helper/local_storage_helper.dart';
import 'package:logger/logger.dart';

import 'api_service.dart';

class CallBookingApi {
  static const apiName = '/booking';
  static const rootApi = ApiService.rootApi;
  final String api = rootApi + apiName;
  var log = Logger();

  // ignore: unused_field
  final String _imgUrl = '';
  String token = LocalStorageHelper.getValue("token");
}
