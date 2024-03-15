import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../api_model/authentication/login.dart';
import '../../api_model/partner/partner.dart';
import '../../api_services/partner_service.dart';
import '../../component/app_bar.dart';
import '../../core/const/front-end/color_const.dart';
import '../../core/helper/asset_helper.dart';
import '../../core/helper/local_storage_helper.dart';
import '../../login.dart';
import 'partner_service_list.dart';

class SearchBooking extends StatefulWidget {
  const SearchBooking({super.key});

  static String routeName = '/search_booking';

  @override
  State<SearchBooking> createState() => _SearchBookingState();
}

class _SearchBookingState extends State<SearchBooking> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  CallPartnerApi api = CallPartnerApi();
  var log = Logger();

  List<Partner> _partner = [];
  List<PartnerService> _service = [];
  bool isEmptyList = true;

  UserDetails? userDetails;

  Future<UserDetails>? loadAccount() async {
    return await LoginAccount.loadAccount();
  }

  void _fetchUserData() async {
    userDetails = await loadAccount();
    if (userDetails == null) {
      Future.delayed(
        Duration.zero,
        () {
          Navigator.of(context).pushReplacementNamed(Login.routeName);
        },
      );
    } else {
      _fetchPartners();
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _fetchPartners();
    _fetchUserData();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 10),
      () {
        _fetchPartners();
      },
    );
  }

  void _fetchPartners() async {
    try {
      String? keyword =
          _searchController.text.isEmpty ? '' : _searchController.text;
      if (userDetails != null) {
        List<Partner>? partner =
            await api.getPartnerPartnerServiceByKeyword(keyword);
        if (mounted) {
          setState(
            () {
              _partner = partner;
              isEmptyList = _partner.isEmpty;
            },
          );
        }
      } else {
        log.e("User details or user keyword is null.");
        throw Exception("User details or user keyword is null.");
      }
    } catch (e) {
      if (mounted) {
        setState(
          () {
            log.e("Error when fetching partner: $e");
            _partner = [];
            isEmptyList = true;
          },
        );
      }
    }
  }

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Tìm kiếm trên ứng dụng Lumos',
                  hintStyle: TextStyle(color: ColorPalette.pink),
                  prefixIcon: Icon(Icons.search_rounded),
                  prefixIconColor: ColorPalette.pink,
                  filled: true,
                  fillColor: ColorPalette.secondaryWhite,
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: ColorPalette.grey2, width: 2.0),
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
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
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  // padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: ColorPalette.blue2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: _partner.isEmpty
                      ? Center(
                          child: isEmptyList
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Image.asset(
                                        AssetHelper.imgLogo,
                                        fit: BoxFit.fitWidth,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Không tìm thấy kết quả',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: ColorPalette.blueBold2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const CircularProgressIndicator(
                                  color: ColorPalette.pink,
                                ),
                        )
                      : ListView.builder(
                          clipBehavior: Clip.antiAlias,
                          shrinkWrap: true,
                          itemCount: _partner.length,
                          itemBuilder: (context, index) {
                            _service =
                                _partner[index].partnerServices?.isEmpty ?? true
                                    ? []
                                    : _partner[index].partnerServices
                                        as List<PartnerService>;
                            final item = _partner[index];
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PartnerServiceList(
                                          partnerId: item.partnerId,
                                        ),
                                      ),
                                    );
                                  },
                                  child: ListTile(
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.displayName ?? 'Đang cập nhật',
                                          style: GoogleFonts.roboto(
                                            textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: ColorPalette.blueBold2,
                                            ),
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              const WidgetSpan(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    right: 5,
                                                    bottom: 3,
                                                  ),
                                                  child: Icon(
                                                    Icons.location_on_rounded,
                                                    size: 15,
                                                    color:
                                                        ColorPalette.blueBold2,
                                                  ),
                                                ),
                                              ),
                                              TextSpan(
                                                text: item.address ??
                                                    "Đang cập nhật",
                                                style: GoogleFonts.roboto(
                                                  textStyle: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 16,
                                                    color:
                                                        ColorPalette.blueBold2,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding:
                                              const EdgeInsets.only(left: 8),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children:
                                                _service.take(3).map((item2) {
                                              return Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 5),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width: 200,
                                                            child: Text(
                                                              item2.name ??
                                                                  "Đang cập nhật",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                textStyle:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize: 16,
                                                                  color: ColorPalette
                                                                      .blueBold2,
                                                                ),
                                                              ),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              softWrap: true,
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const RatingStars(
                                                                value: 3.5,
                                                                starColor:
                                                                    ColorPalette
                                                                        .pink,
                                                                starSize: 13,
                                                                valueLabelVisibility:
                                                                    false,
                                                              ),
                                                              Container(
                                                                height: 13,
                                                                width: 1.2,
                                                                color: ColorPalette
                                                                    .blueBold2,
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            10,
                                                                        right:
                                                                            6),
                                                              ),
                                                              const Icon(
                                                                FontAwesomeIcons
                                                                    .calendarCheck,
                                                                size: 13,
                                                                color: ColorPalette
                                                                    .blueBold2,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            3.5),
                                                                child: Text(
                                                                  ' ${item2.quantity.toString()} lượt',
                                                                  style:
                                                                      GoogleFonts
                                                                          .roboto(
                                                                    fontSize:
                                                                        13,
                                                                    color: ColorPalette
                                                                        .blueBold2,
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    fit: FlexFit.loose,
                                                    child: Text(
                                                      '₫${formatCurrency(item2.price ?? 0)}',
                                                      style:
                                                          GoogleFonts.aBeeZee(
                                                        fontSize: 13,
                                                        color: ColorPalette
                                                            .blueBold2,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                if (index < _partner.length - 1 &&
                                    _partner.length > 1)
                                  const Divider(
                                    thickness: 2,
                                    height: 2,
                                    color: ColorPalette.white,
                                  ),
                              ],
                            );
                          },
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String formatCurrency(int amount) {
    final formatCurrency = NumberFormat("#,##0", "vi_VN");
    return formatCurrency.format(amount);
  }
}
