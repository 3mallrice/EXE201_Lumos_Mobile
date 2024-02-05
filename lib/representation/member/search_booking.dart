import 'package:exe201_lumos_mobile/component/app_bar.dart';
import 'package:exe201_lumos_mobile/core/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

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
                  child: const SearchList(),
                )
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
    List<String> _partner = [
      "Bệnh viện Đại học Y Dược TPHCM",
      "Bệnh viện Đại học Y",
      "Bệnh viện Đại học"
    ];

    List<String> _service = [
      "Tắm cho bé",
      "Chăm sóc mẹ bầu",
      "Tắm cho bé",
      "Chăm sóc mẹ bầu",
      "Massage",
    ];

    return ListView.builder(
      clipBehavior: Clip.antiAlias,
      shrinkWrap: true,
      itemCount: _partner.length,
      itemBuilder: (context, index) {
        final item = _partner[index];
        return Column(
          children: [
            InkWell(
              onTap: () {
                //Navigator.of(context).pushNamed(MedicalReportDetail.routeName);
              },
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item,
                      style: GoogleFonts.almarai(
                        textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: ColorPalette.blueBold2),
                      ),
                    ),
                    Text(
                      '20-22 Dương Quang Trung, Phường 12, Quận 10, TP.HCM',
                      style: GoogleFonts.almarai(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: ColorPalette.blueBold2,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 15),
                      child: ListView.builder(
                        clipBehavior: Clip.antiAlias,
                        shrinkWrap: true,
                        itemCount: _service.length,
                        itemBuilder: (context, index) {
                          final item2 = _service[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item2,
                                        style: GoogleFonts.almarai(
                                          textStyle: const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12,
                                            color: ColorPalette.blueBold2,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const RatingStars(
                                            value: 3.5,
                                            starColor: ColorPalette.star,
                                            starSize: 10,
                                            valueLabelVisibility: false,
                                          ),
                                          const VerticalDivider(
                                            color: ColorPalette.blueBold2,
                                            thickness: 2,
                                          ),
                                          const Icon(
                                            Icons.event_note,
                                            size: 10,
                                            color: ColorPalette.blueBold2,
                                          ),
                                          Text(
                                            '80 lượt đã đặt',
                                            style: GoogleFonts.almarai(
                                              fontSize: 10,
                                              color: ColorPalette.blueBold2,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                '500.000 đ',
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 13,
                                  color: ColorPalette.blueBold2,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            if (index < _partner.length - 1)
              const Divider(
                thickness: 2,
                height: 2,
                color: ColorPalette.white,
              ),
          ],
        );
      },
    );
  }
}
