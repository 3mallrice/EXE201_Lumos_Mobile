import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:flutter/material.dart';

class SearchBooking extends StatefulWidget {
  const SearchBooking({super.key});

  static String routeName = '/search_booking';

  @override
  State<SearchBooking> createState() => _SearchBookingState();
}

class _SearchBookingState extends State<SearchBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCom(
        appBarText: 'Tìm kiếm',
        leading: true,
      ),
      body: Container(
        alignment: AlignmentDirectional.topCenter,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onTap: () {
                    //
                  },
                  decoration: const InputDecoration(
                    hintText: 'Tìm kiếm',
                    hintStyle: TextStyle(color: ColorPalette.pink),
                    prefixIcon: Icon(Icons.search_rounded),
                    prefixIconColor: ColorPalette.pink,
                    filled: true,
                    fillColor: ColorPalette.secondaryWhite,
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorPalette.grey2, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorPalette.grey2, width: 1.0),
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: ColorPalette.blue2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: ListView.builder(
                    clipBehavior: Clip.antiAlias,
                    shrinkWrap: true,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const Column(
                        children: [
                          SearchList(),
                          Divider(
                            thickness: 2,
                            height: 2,
                            color: ColorPalette.white,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchList extends StatelessWidget {
  const SearchList({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell();
  }
}
