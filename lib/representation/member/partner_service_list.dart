import 'package:flutter/foundation.dart';

import '../../api_model/authentication/login.dart';
import '../../api_services/customer_service.dart';
import 'package:logger/logger.dart';

import '../../api_model/customer/cart_model.dart';
import '../../api_model/customer/medical_report.dart';
import '../../core/const/back-end/error_reponse.dart';
import '../../core/helper/local_storage_helper.dart';
import '../../login.dart';
import 'member_booking.dart';
import 'package:flutter/material.dart';
import '../../component/app_bar.dart';
import '../../core/const/front-end/color_const.dart';
import '../../core/helper/asset_helper.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rich_readmore/rich_readmore.dart';

class PartnerServiceList extends StatefulWidget {
  final int? partnerId;

  const PartnerServiceList({super.key, this.partnerId});

  static String routeName = '/partner_service_list';

  @override
  State<PartnerServiceList> createState() => _PartnerServiceListState();
}

class _PartnerServiceListState extends State<PartnerServiceList> {
  final CallCustomerApi api = CallCustomerApi();
  bool _isFavorited = false;
  UserDetails? userDetails;

  var log = Logger();

  List<MedicalReport> _reports = [];
  List<CartModel> carts = [];
  bool isEmptyList = true;

  Future<UserDetails>? loadAccount() async {
    return await LoginAccount.loadAccount();
  }

  void _fetchUserData() async {
    userDetails = await loadAccount();
    if (userDetails == null) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushReplacementNamed(Login.routeName);
      });
    } else {
      _fetchMedicalReports();
    }
  }

  void _fetchMedicalReports() async {
    try {
      if (userDetails != null && userDetails!.id != null) {
        List<MedicalReport>? reports =
            await api.getMedicalReport(userDetails!.id!);
        setState(
          () {
            _reports = reports;
            isEmptyList = _reports.isEmpty;
          },
        );
      } else {
        setState(() {
          log.e("User details or user id is null.");
          _reports = [];
          isEmptyList = true;
        });
      }
    } catch (e) {
      setState(() {
        log.e("Error when fetching medical reports: $e");
        _reports = [];
        isEmptyList = true;
      });
    }
  }

  CartModel onAddToCart(int reportId, Service service) {
    // Kiểm tra xem đã có cart cho bệnh nhân này chưa
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

    // Trả về giỏ hàng đã được cập nhật
    return carts[
        existingCartIndex != -1 ? existingCartIndex : carts.length - 1];
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  List<Service> services = [
    Service(
      id: 1,
      name: 'Điều trị nha khoa',
      executionTime: '60',
      description: 'Dịch vụ chăm sóc và điều trị nha khoa chuyên sâu.',
      price: 200.0,
    ),
    Service(
      id: 2,
      name: 'Kiểm tra mắt',
      executionTime: '30',
      description:
          'Kiểm tra mắt chuyên sâu với các bước đo chính xác và hiện đại.',
      price: 150.0,
    ),
    Service(
      id: 3,
      name: 'Masage thư giãn',
      executionTime: '45',
      description: 'Dịch vụ masage thư giãn giúp giảm căng thẳng và mệt mỏi.',
      price: 120.0,
    ),
    Service(
      id: 4,
      name: 'Điều trị nha khoa',
      executionTime: '60',
      description: 'Dịch vụ chăm sóc và điều trị nha khoa chuyên sâu.',
      price: 200.0,
    ),
    Service(
      id: 5,
      name: 'Kiểm tra mắt',
      executionTime: '30',
      description:
          'Kiểm tra mắt chuyên sâu với các bước đo chính xác và hiện đại.',
      price: 150.0,
    ),
    Service(
      id: 6,
      name: 'Masage thư giãn',
      executionTime: '45',
      description: 'Dịch vụ masage thư giãn giúp giảm căng thẳng và mệt mỏi.',
      price: 120.0,
    ),
    Service(
      id: 7,
      name: 'Điều trị nha khoa',
      executionTime: '60',
      description:
          'Dịch vụ chăm sóc và điều trị nha khoa chuyên sâu. Kiểm tra mắt chuyên sâu với các bước đo chính xác và hiện đại. Kiểm tra mắt chuyên sâu với các bước đo chính xác và hiện đại.',
      price: 200.0,
    ),
    Service(
      id: 8,
      name: 'Kiểm tra mắt',
      executionTime: '30',
      description:
          'Kiểm tra mắt chuyên sâu với các bước đo chính xác và hiện đại. Kiểm tra mắt chuyên sâu với các bước đo chính xác và hiện đại. Kiểm tra mắt chuyên sâu với các bước đo chính xác và hiện đại.',
      price: 150.0,
    ),
    Service(
      id: 9,
      name: 'Masage thư giãn',
      executionTime: '45',
      description:
          'Dịch vụ masage thư giãn giúp giảm căng thẳng và mệt mỏi. Kiểm tra mắt chuyên sâu với các bước đo chính xác và hiện đại. Kiểm tra mắt chuyên sâu với các bước đo chính xác và hiện đại.',
      price: 120.0,
    ),
  ];

  void Function(Service service)? onTap(Service service) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorPalette.blue2,
          alignment: Alignment.center,
          title: Text(
            'Chọn bệnh nhân',
            style: GoogleFonts.almarai(
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
                  return Column(
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
                        titleTextStyle: GoogleFonts.almarai(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: ColorPalette.blueBold2,
                        ),
                        onTap: () {
                          var cart =
                              onAddToCart(_reports[index].reportId, service);
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
                  style: GoogleFonts.almarai(
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
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final partnerId = ModalRoute.of(context)?.settings.arguments;
    if (kDebugMode) {
      print(partnerId);
    }

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
          Image.asset(
            AssetHelper.partnerImage,
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: ListTile(
              title: const Text(
                'Bệnh viện Đại Học Y Dược TPHCM',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              titleTextStyle: GoogleFonts.almarai(
                fontSize: 22,
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
                        value: 1.5,
                        valueLabelVisibility: false,
                        starSize: 16,
                      ),
                      Container(
                        height: 20,
                        width: 1.2,
                        color: ColorPalette.blueBold2,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      const Icon(
                        FontAwesomeIcons.calendarCheck,
                        size: 16,
                        color: ColorPalette.blueBold2,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Text(
                        "30 lượt đã đặt",
                        style: GoogleFonts.almarai(
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
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 12,
            color: ColorPalette.grey2,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: services.map((service) {
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
                          service.name,
                          style: GoogleFonts.almarai(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${service.executionTime} phút',
                                    style: GoogleFonts.almarai(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: ColorPalette.blueBold2,
                                    ),
                                  ),
                                  RichReadMoreText.fromString(
                                    text: service.description,
                                    textStyle: GoogleFonts.almarai(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: ColorPalette.bluelight2,
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                        textStyle: const TextStyle(
                                          textBaseline: TextBaseline.alphabetic,
                                        )),
                                    settings: LineModeSettings(
                                      trimLines: 3,
                                      trimCollapsedText: 'Xem thêm',
                                      trimExpandedText: 'Rút gọn',
                                      // onPressReadMore: () {},
                                      // onPressReadLess: () {},
                                      lessStyle: GoogleFonts.almarai(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: ColorPalette.bluelight2,
                                      ),
                                      moreStyle: GoogleFonts.almarai(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        color: ColorPalette.bluelight2,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '${service.price} VNĐ',
                                      style: GoogleFonts.almarai(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ColorPalette.blueBold2,
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
                    if (service != services.last)
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
            height: 20,
            color: ColorPalette.grey2,
          ),
        ],
      ),
    );
  }
}

class Service {
  int id;
  String name;
  String executionTime;
  String description;
  double price;

  Service({
    required this.id,
    required this.name,
    required this.executionTime,
    required this.description,
    required this.price,
  });

  @override
  String toString() {
    return 'Service{id: $id, name: $name, executionTime: $executionTime, description: $description, price: $price}';
  }
}
