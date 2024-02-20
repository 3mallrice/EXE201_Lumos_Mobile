import 'package:hive_flutter/hive_flutter.dart';

import 'local_storage_helper.dart';

class CartServiceAdapter extends TypeAdapter<CartService> {
  @override
  final int typeId = 34;

  @override
  CartService read(BinaryReader reader) {
    return CartService(
      serviceId: reader.read() as int,
      medicalReportId: reader.read() as int,
    );
  }

  @override
  void write(BinaryWriter writer, CartService obj) {
    writer
      ..write(obj.serviceId)
      ..write(obj.medicalReportId);
  }
}
