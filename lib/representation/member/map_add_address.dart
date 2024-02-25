import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/core/const/front-end/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_location_search/flutter_location_search.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapAddressAdd extends StatefulWidget {
  const MapAddressAdd({super.key});

  static String routeName = '/map_address_addnew';

  @override
  State<MapAddressAdd> createState() => _MapAddressAddState();
}

class _MapAddressAddState extends State<MapAddressAdd> {
  final _mapController = MapController(
    initMapWithUserPosition: const UserTrackingOption(enableTracking: true),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCom(
        appBarText: "Chọn địa chỉ",
        leading: true,
      ),
    );
  }
}
