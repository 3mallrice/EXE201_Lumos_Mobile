import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'package:rich_readmore/rich_readmore.dart';

import '../../api_model/authentication/login.dart';
import '../../api_model/customer/cart_model.dart';
import '../../api_model/customer/medical_report.dart';
import '../../api_model/partner/partner.dart';
import '../../api_services/customer_service.dart';
import '../../api_services/partner_service.dart';
import '../../component/app_bar.dart';
import '../../core/const/back-end/reponse_text.dart';
import '../../core/const/front-end/color_const.dart';
import '../../core/helper/asset_helper.dart';
import '../../core/helper/local_storage_helper.dart';
import '../../login.dart';
import 'member_booking.dart';

class PartnerServiceList extends StatefulWidget {
  final int? partnerId;

  const PartnerServiceList({super.key, this.partnerId});

  static String routeName = '/partner_service_list';

  @override
  State<PartnerServiceList> createState() => _PartnerServiceListState();
}

class _PartnerServiceListState extends State<PartnerServiceList> {
  final CallCustomerApi customerApi = CallCustomerApi();
  final CallPartnerApi partnerApi = CallPartnerApi();
  bool _isFavorited = false;
  UserDetails? userDetails;
  Partner? partner;
  int? partnerId;

  var log = Logger();

  List<MedicalReport> _reports = [];
  List<CartModel> carts = [];
  bool isEmptyList = true;

  Future<UserDetails>? loadAccount() async {
    return await LoginAccount.loadAccount();
  }

  void _fetchUserData() async {
    partnerId = widget.partnerId;
    userDetails = await loadAccount();
    if (userDetails == null) {
      Future.delayed(
        Duration.zero,
        () =>
            Navigator.restorablePushReplacementNamed(context, Login.routeName),
      );
    } else {
      await _fetchPartnerData(widget.partnerId);
    }
  }

  Future<void> _fetchPartnerData(int? partnerId) async {
    if (!mounted) return;
    try {
      if (partnerId != null) {
        Partner? partner = await partnerApi.getPartnerById(partnerId);
        setState(() {
          this.partner = partner;
        });
      } else {
        log.e("Partner id is null.");
        throw Exception("Partner id is null.");
      }
    } catch (e) {
      setState(() {
        log.e("Error when fetching partner data: $e");
        partner = null;
      });
    }
  }

  Future<void> _fetchMedicalReports() async {
    try {
      if (userDetails != null && userDetails!.id != null) {
        List<MedicalReport>? reports =
            await customerApi.getMedicalReport(userDetails!.id!);
        setState(
          () {
            _reports = reports;
            isEmptyList = _reports.isEmpty;
          },
        );
      } else {
        log.e("User details or user id is null.");
        throw Exception("User details or user id is null.");
      }
    } catch (e) {
      setState(() {
        log.e("Error when fetching medical reports: $e");
        _reports = [];
        isEmptyList = true;
      });
    }
  }

  CartModel onAddToCart(int? reportId, PartnerService service) {
    if (reportId == null) return carts.first;

    // Kiểm tra xem đã có cart cho hồ sơ này chưa
    var existingCartIndex =
        carts.indexWhere((cart) => cart.medicalReportId == reportId);

    if (existingCartIndex != -1) {
      // Nếu đã có, kiểm tra xem service đã tồn tại trong danh sách không
      if (carts[existingCartIndex].services.contains(service)) {
        // Nếu service đã tồn tại, hiển thị AlertDialog thông báo
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: const Text(OnInvalidInputMessage.serviceExisted),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Nếu service chưa tồn tại, thêm vào danh sách của cart đó
        carts[existingCartIndex].services.add(service);
      }
    } else {
      // Nếu chưa có, tạo mới cart
      carts.add(CartModel(
        medicalReportId: reportId,
        services: [service],
      ));
    }

    // Cập nhật lại giao diện
    setState(
      () {},
    );

    // Trả về giỏ hàng đã được cập nhật
    return carts[
        existingCartIndex != -1 ? existingCartIndex : carts.length - 1];
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  List<PartnerService> services = [];

  Future<void Function(PartnerService service)?> onTap(
      PartnerService service) async {
    await _fetchMedicalReports();
    showMedicalReportDialog(service);
    return null;
  }

  void showMedicalReportDialog(PartnerService service) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorPalette.blue2,
          alignment: Alignment.center,
          title: Text(
            'Chọn hồ sơ',
            style: GoogleFonts.roboto(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorPalette.blueBold2,
            ),
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: ColorPalette.thirdWhite,
              ),
              child: ListView.builder(
                itemCount: _reports.length,
                itemBuilder: (BuildContext context, int index) {
                  return (_reports.isNotEmpty)
                      ? Column(
                          children: [
                            ListTile(
                              title: Text(
                                _reports[index].fullname,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              leading: const Icon(
                                Icons.medical_services,
                                size: 20,
                                color: ColorPalette.pink,
                              ),
                              titleTextStyle: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: ColorPalette.blueBold2,
                              ),
                              onTap: () {
                                var cart = onAddToCart(
                                    _reports[index].reportId!, service);
                                log.i("Cart: $cart");
                                Navigator.of(context).pop();
                              },
                            ),
                            if (index < _reports.length - 1)
                              const Divider(
                                thickness: 0.7,
                                height: 2,
                                color: ColorPalette.blue2,
                              ),
                          ],
                        )
                      : const Center(
                          child: Text(
                            SearchErrorMessage.noResultsFound,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: ColorPalette.blueBold2,
                            ),
                          ),
                        );
                },
              ),
            ),
          ),
          actions: [
            Container(
              width: 97,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorPalette.pink,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'HỦY',
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.white,
                  ),
                ),
              ),
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
          elevation: 2,
        );
      },
    );
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

    final int cartItemCount = carts.fold<int>(
        0, (previousValue, element) => previousValue + element.services.length);

    final bool showBadge = cartItemCount > 0;

    return Scaffold(
      appBar: AppBarCom(
        appBarText: 'Dịch vụ',
        leading: true,
        action: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorPalette.blue2,
            ),
            child: showBadge
                ? Badge(
                    offset: const Offset(6, -6),
                    label: Text(
                      // Số lượng dịch vụ trong giỏ hàng
                      '${carts.fold<int>(0, (previousValue, element) => previousValue + element.services.length)}',
                      style: GoogleFonts.roboto(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.white,
                      ),
                    ),
                    isLabelVisible: true,
                    child: IconButton(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(bottom: 2),
                      icon: const Icon(
                        Ionicons.calendar_outline,
                        size: 21,
                        color: ColorPalette.blueBold2,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingPage(
                              cart: carts,
                              partner: partner,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : (partner!.partnerServices!.isEmpty)
                    ? IconButton(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(bottom: 2),
                        icon: Icon(
                          Ionicons.calendar_outline,
                          size: 21,
                          color: ColorPalette.blueBold2.withOpacity(0.7),
                        ),
                        onPressed: () {},
                      )
                    : IconButton(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(bottom: 2),
                        icon: const Icon(
                          Ionicons.calendar_outline,
                          size: 21,
                          color: ColorPalette.blueBold2,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingPage(
                                cart: carts,
                                partner: partner,
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
      body: ListView(
        children: [
          loadImage(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              //go to partner page
              // onTap: () {
              //   Navigator.pushNamed(
              //     context,
              //     PartnerPage.routeName,
              //     arguments: partner,
              //   );
              // },
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
          (partner!.partnerServices!.isEmpty)
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: isEmptyList
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                AssetHelper.imgLogo,
                                fit: BoxFit.fitWidth,
                                width: MediaQuery.of(context).size.width * 0.5,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Đối tác chưa cung cấp dịch vụ nào',
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: ColorPalette.blueBold2,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : const CircularProgressIndicator(
                            color: ColorPalette.pink,
                          ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: partner!.partnerServices!.map((service) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () => onTap(service),
                            child: ListTile(
                              leading: const Icon(
                                Icons.medical_services,
                                size: 23,
                                color: ColorPalette.pink,
                              ),
                              title: Text(
                                service.name ?? "Tên dịch vụ",
                                style: GoogleFonts.roboto(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: ColorPalette.blueBold2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${service.duration} phút',
                                          style: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: ColorPalette.blueBold2,
                                          ),
                                        ),
                                        RichReadMoreText.fromString(
                                          text: service.description ??
                                              "Mô tả dịch vụ",
                                          textStyle: GoogleFonts.roboto(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                            color: ColorPalette.bluelight2,
                                            decorationStyle:
                                                TextDecorationStyle.solid,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                          ),
                                          settings: LineModeSettings(
                                            trimLines: 2,
                                            trimCollapsedText: '... Xem thêm',
                                            trimExpandedText: ' Rút gọn',
                                            moreStyle: const TextStyle(
                                              color: ColorPalette.blueBold2,
                                            ),
                                            lessStyle: const TextStyle(
                                              color: ColorPalette.blueBold2,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '₫ ${formatCurrency(service.price!)}',
                                            style: GoogleFonts.roboto(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: ColorPalette.pink,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (service != partner!.partnerServices!.last)
                            const Divider(
                              thickness: 0.7,
                              height: 2,
                              color: ColorPalette.blue2,
                            ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
          Container(
            height: 10,
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

  String formatCurrency(int amount) {
    final formatCurrency = NumberFormat("#,##0", "vi_VN");
    return formatCurrency.format(amount);
  }
}
