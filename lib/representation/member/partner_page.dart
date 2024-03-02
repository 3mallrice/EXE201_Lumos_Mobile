import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';

import '../../api_model/authentication/login.dart';
import '../../api_model/partner/partner.dart';
import '../../api_services/partner_service.dart';
import '../../component/app_bar.dart';
import '../../core/const/back-end/error_reponse.dart';
import '../../core/const/front-end/color_const.dart';
import '../../core/helper/asset_helper.dart';
import '../../core/helper/local_storage_helper.dart';
import '../../login.dart';

class PartnerPage extends StatefulWidget {
  final Partner? partner;
  const PartnerPage({super.key, this.partner});

  static String routeName = '/partner_page';

  @override
  State<PartnerPage> createState() => _PartnerPageState();
}

class _PartnerPageState extends State<PartnerPage> {
  final CallPartnerApi partnerApi = CallPartnerApi();
  bool _isFavorited = false;
  UserDetails? userDetails;
  Partner? partner;

  var log = Logger();

  Future<UserDetails>? loadAccount() async {
    return await LoginAccount.loadAccount();
  }

  void _fetchUserData() async {
    userDetails = await loadAccount();
    if (userDetails == null) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushReplacementNamed(Login.routeName);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    partner = widget.partner;
  }

  @override
  Widget build(BuildContext context) {
    if (partner == null) {
      return Scaffold(
        body: Center(
          child: LoadingAnimationWidget.fourRotatingDots(
            color: ColorPalette.pinkBold,
            size: 80,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: const AppBarCom(
        appBarText: 'Dịch vụ',
        leading: true,
      ),
      body: ListView(
        children: [
          loadImage(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              //go to partner page
              onTap: () {
                Navigator.pushNamed(
                  context,
                  PartnerPage.routeName,
                  arguments: partner,
                );
              },
              title: Text(
                partner!.displayName ?? "Đang cập nhật",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              titleTextStyle: GoogleFonts.roboto(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: ColorPalette.blueBold2,
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const RatingStars(
                        starColor: ColorPalette.star,
                        starOffColor: ColorPalette.grey2,
                        value: 4.5,
                        valueLabelVisibility: false,
                        starSize: 14,
                      ),
                      Container(
                        height: 14,
                        width: 1.2,
                        color: ColorPalette.blueBold2,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      const Icon(
                        FontAwesomeIcons.calendarCheck,
                        size: 14,
                        color: ColorPalette.blueBold2,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        "30 lượt đã đặt",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: ColorPalette.blueBold2,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        _isFavorited
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        size: 25,
                        color: _isFavorited
                            ? ColorPalette.pink
                            : ColorPalette.blueBold2,
                      ),
                      onPressed: () {
                        setState(() {
                          _isFavorited = !_isFavorited;
                          //showSnackBar to show the on development message
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                OnDevelopmentMessage.featureOnDevelopment,
                                style: TextStyle(
                                  color: ColorPalette.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              backgroundColor: ColorPalette.pink,
                            ),
                          );
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 10,
            color: ColorPalette.grey2,
          ),
        ],
      ),
    );
  }

  loadImage() {
    return Image.asset(
      AssetHelper.partnerImage,
      fit: BoxFit.fill,
      alignment: Alignment.center,
    );
  }
}
