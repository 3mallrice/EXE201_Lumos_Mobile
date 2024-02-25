import '../../component/alert_dialog.dart';
import 'member_home.dart';

import '../../api_model/customer/address.dart';
import '../../api_model/partner/partner.dart';
import '../../core/const/back-end/error_reponse.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';

import '../../api_model/authentication/login.dart';
import '../../api_model/customer/cart_model.dart';
import '../../api_model/customer/medical_report.dart';
import '../../api_services/customer_service.dart';
import 'member_address_add.dart';

import '../../component/app_bar.dart';
import '../../component/my_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../core/const/front-end/color_const.dart';
import '../../core/helper/local_storage_helper.dart';
import '../../login.dart';

class BookingPage extends StatefulWidget {
  final List<CartModel>? cart;
  final Partner? partner;

  const BookingPage({
    super.key,
    this.cart,
    this.partner,
  });

  static String routeName = '/booking';

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final TextEditingController _addController = TextEditingController();

  BuildContext? dialogContext;

  var log = Logger();
  List<MedicalReportService?> medicalReportServices = [];

  List<Address> address = [];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      currentDate: DateTime.now(),
      locale: const Locale("vi", "VN"),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      keyboardType:
          const TextInputType.numberWithOptions(decimal: false, signed: false),
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 7)),
      //theme
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorPalette.pink,
              onPrimary: ColorPalette.white,
              surface: ColorPalette.blue2,
              onSurface: ColorPalette.blueBold2,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorPalette.pink,
              onPrimary: ColorPalette.white,
              surface: ColorPalette.blue2,
              onSurface: ColorPalette.blueBold2,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  CallCustomerApi calCustomerlApi = CallCustomerApi();
  UserDetails? userDetails;

  Future<UserDetails>? loadAccount() async {
    return await LoginAccount.loadAccount();
  }

  void fetchUserData() async {
    userDetails = await loadAccount();
    if (userDetails == null) {
      Future.delayed(
        Duration.zero,
        () {
          Navigator.of(context).pushReplacementNamed(Login.routeName);
        },
      );
    } else {
      // _fetchAddress();
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
    fetchMedicalReports();
    _fetchAddress();
  }

  Future<void> _fetchAddress() async {
    try {
      if (userDetails != null && userDetails!.id != null) {
        List<Address>? addressList =
            await calCustomerlApi.getCustomerAddress(userDetails!.id!);
        setState(
          () {
            address = addressList;
            log.i(address.length);
          },
        );
      } else {
        setState(() {
          log.e("User details or user id is null.");
          address = [];
        });
      }
    } catch (e) {
      setState(() {
        log.e("Error when fetching address: $e");
        address = [];
      });
    }
  }

  Future<void> fetchMedicalReports() async {
    for (int i = 0; i < widget.cart!.length; i++) {
      int medicalReportId = widget.cart![i].medicalReportId;
      MedicalReport report = await fetchMedicalReport(medicalReportId);
      MedicalReportService medicalReportService = MedicalReportService(
          report, widget.cart![i].services.cast<PartnerService>());
      setState(
        () {
          medicalReportServices.add(medicalReportService);
        },
      );
    }
  }

  Future<MedicalReport> fetchMedicalReport(int reportId) async {
    return await calCustomerlApi.getMedicalReportById(reportId);
  }

  dynamic Function() onTap() {
    if (medicalReportServices.isEmpty) {
      showErrorDialog();
    }
    return () {
      showPaymentListBottomSheet();
    };
  }

  void showPaymentListBottomSheet() {
    showModalBottomSheet(
      backgroundColor: ColorPalette.blue2,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(
                'Chọn phương thức thanh toán',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: ColorPalette.blueBold2,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.payments_rounded,
                color: ColorPalette.blueBold2,
              ),
              title: const Text(
                'Thanh toán COD',
                style: TextStyle(
                  color: ColorPalette.blueBold2,
                ),
              ),
              onTap: () => {
                showConfirmDialog(),
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.wallet_rounded,
                color: ColorPalette.blueBold2,
              ),
              title: const Text(
                'Thanh toán bằng ví điện tử Momo',
                style: TextStyle(
                  color: ColorPalette.blueBold2,
                ),
              ),
              subtitle: const Text(
                'Đang phát triển ...',
                style: TextStyle(color: ColorPalette.grey),
              ),
              onTap: () => {
                /* Xử lý khi chọn 'Music' */
              },
            ),
            ListTile(
              leading: const Icon(
                FontAwesomeIcons.ccVisa,
                color: ColorPalette.blueBold2,
              ),
              title: const Text(
                'Thanh toán bằng thẻ Visa',
                style: TextStyle(
                  color: ColorPalette.blueBold2,
                ),
              ),
              subtitle: const Text(
                'Đang phát triển ...',
                style: TextStyle(color: ColorPalette.grey),
              ),
              onTap: () => {
                /* Xử lý khi chọn 'Photos' */
              },
            ),
            ListTile(
              leading: const Icon(
                FontAwesomeIcons.ccMastercard,
                color: ColorPalette.blueBold2,
              ),
              title: const Text(
                'Thanh toán bằng thẻ MasterCard',
                style: TextStyle(
                  color: ColorPalette.blueBold2,
                ),
              ),
              subtitle: const Text(
                'Đang phát triển ...',
                style: TextStyle(color: ColorPalette.grey),
              ),
              onTap: () => {
                /* Xử lý khi chọn 'Video' */
              },
            ),
            ListTile(
              leading: const Icon(
                FontAwesomeIcons.buildingColumns,
                color: ColorPalette.blueBold2,
              ),
              title: const Text(
                'Thanh toán bằng ngân hàng',
                style: TextStyle(
                  color: ColorPalette.blueBold2,
                ),
              ),
              subtitle: const Text(
                'Đang phát triển ...',
                style: TextStyle(color: ColorPalette.grey),
              ),
              onTap: () => {
                //
              },
            ),
          ],
        );
      },
    );
  }

  Function showErrorDialog() {
    return () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: ColorPalette.blue2,
            title: const Text(
              DiaLogMessage.title,
              style: TextStyle(
                color: ColorPalette.pinkBold,
              ),
            ),
            content: const Text(
              BookingErrorMessage.emptyList,
              style: TextStyle(
                color: ColorPalette.blueBold2,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  DiaLogMessage.ok,
                  style: TextStyle(
                    color: ColorPalette.blueBold2,
                  ),
                ),
              ),
            ],
          );
        },
      );
    };
  }

  //show confirm dialog after choose payment method using CustomAlertDialog
  void showConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: const Text(
            DiaLogMessage.title,
            style: TextStyle(
              color: ColorPalette.pinkBold,
            ),
          ),
          message: const Text(
            "Xác nhận đặt lịch hẹn?",
            style: TextStyle(
              color: ColorPalette.blueBold2,
            ),
          ),
          action: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  DiaLogMessage.cancel,
                  style: TextStyle(
                    color: ColorPalette.blueBold2,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  showSuccessSnackBar();
                  Navigator.of(context)
                      .pushReplacementNamed(MemberHome.routeName);
                },
                child: const Text(
                  DiaLogMessage.confirm,
                  style: TextStyle(
                    color: ColorPalette.blueBold2,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  //show success snack bar after choose payment method
  void showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          BookingSuccessMessage.bookingSuccess,
          style: TextStyle(
            color: ColorPalette.white,
          ),
        ),
        backgroundColor: ColorPalette.blueBold2,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    String formattedTime = selectedTime.format(context);
    int totalPrice = 0;
    Partner? partner = widget.partner;

    for (var ser in medicalReportServices) {
      for (var item in ser!.services) {
        totalPrice += item.price!;
      }
    }

    if (widget.cart == null) {
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
        leading: true,
        appBarText: "Đặt lịch hẹn",
      ),
      backgroundColor: ColorPalette.bgColor,
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: screenWidth * 0.9,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Text(
                    partner?.partnerName ?? "...",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: ColorPalette.blueBold2,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                //note
                Container(
                  height: 10,
                ),
                if (medicalReportServices.isEmpty)
                  const Text(
                    SearchErrorMessage.noResultsFound,
                    style: TextStyle(
                      color: ColorPalette.pinkBold,
                    ),
                  )
                else
                  Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    padding: const EdgeInsets.all(5),
                    decoration: ShapeDecoration(
                      color: ColorPalette.blue2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: medicalReportServices.length,
                          itemBuilder: (context, index) {
                            final item = medicalReportServices[index];
                            return Column(
                              children: [
                                ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item!.medicalReport.fullname,
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: ColorPalette.blueBold2),
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: ListView.builder(
                                          clipBehavior: Clip.antiAlias,
                                          shrinkWrap: true,
                                          itemCount: item.services.length,
                                          itemBuilder: (context, index) {
                                            PartnerService item2 =
                                                item.services[index];
                                            totalPrice;
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: screenWidth * 0.5,
                                                  child: Text(
                                                    item2.name ?? "",
                                                    style: GoogleFonts.roboto(
                                                      textStyle:
                                                          const TextStyle(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 16,
                                                        color: ColorPalette
                                                            .blueBold2,
                                                      ),
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2,
                                                    softWrap: true,
                                                  ),
                                                ),
                                                Text(
                                                  '₫ ${formatCurrency(item2.price!)}',
                                                  style: GoogleFonts.roboto(
                                                    textStyle: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 16,
                                                      color: ColorPalette
                                                          .blueBold2,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // if (index < medicalReportServices.length - 1)
                                const Divider(
                                  thickness: 1,
                                  height: 2,
                                  color: ColorPalette.blue,
                                ),
                              ],
                            );
                          },
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 23,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Tổng cộng",
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: ColorPalette.pinkBold,
                                  ),
                                ),
                              ),
                              Text(
                                '₫ ${formatCurrency(totalPrice)}',
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: ColorPalette.pinkBold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                Container(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDate(context),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20.0,
                          ),
                          decoration: BoxDecoration(
                            color: ColorPalette.white,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: ColorPalette.grey2,
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ngày',
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                  color: ColorPalette.blue3,
                                ),
                              ),
                              Text(
                                formattedDate,
                                style: GoogleFonts.roboto(
                                  color: ColorPalette.blueBold2,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectTime(context),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 20.0,
                          ),
                          decoration: BoxDecoration(
                            color: ColorPalette.white,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: ColorPalette.grey2,
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Giờ',
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                  color: ColorPalette.blue3,
                                ),
                              ),
                              Text(
                                formattedTime,
                                style: GoogleFonts.roboto(
                                  color: ColorPalette.blueBold2,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Địa chỉ',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      readOnly: true,
                      onTap: () {
                        //Navigator.of(context).pushNamed(MemberAddress.routeName);
                        _showPopUp();
                        log.e('address: ${address.length}');
                      },
                      controller: _addController,
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: 'Chọn địa chỉ của bạn',
                        hintStyle: GoogleFonts.roboto(
                          color: ColorPalette.blueBold2.withOpacity(0.65),
                        ),
                        filled: true,
                        fillColor: ColorPalette.white,
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorPalette.grey2, width: 2.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ColorPalette.grey2, width: 1.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                      ),
                      style: GoogleFonts.roboto(
                        color: ColorPalette.blueBold2.withOpacity(0.65),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ghi chú',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SingleChildScrollView(
                      child: TextField(
                        maxLines: 3,
                        maxLength: 255,
                        decoration: InputDecoration(
                          hintText: 'Nhập ghi chú...',
                          hintStyle: GoogleFonts.roboto(
                            color: ColorPalette.blueBold2.withOpacity(0.65),
                          ),
                          filled: true,
                          fillColor: ColorPalette.white,
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorPalette.grey2, width: 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorPalette.grey2, width: 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                        ),
                        style: GoogleFonts.roboto(
                          color: ColorPalette.blueBold2.withOpacity(0.65),
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Bằng đặt hẹn, tôi đã xác nhận rằng những thông tin trên là chính xác.",
                    style: GoogleFonts.roboto(
                      color: ColorPalette.blueBold2.withOpacity(0.42),
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                  onTap: onTap(),
                  borderRadius: 50,
                  color: ColorPalette.pinkBold,
                  widget: Text(
                    "Đặt hẹn",
                    style: GoogleFonts.roboto(
                      color: ColorPalette.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPopUp() async {
    dialogContext = context;
    await _fetchAddress();
    showDialog(
      context: dialogContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ColorPalette.blue2,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Chọn địa chỉ của bạn:',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: ColorPalette.pinkBold,
                ),
                textAlign: TextAlign.center,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorPalette.pink,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.only(
                      left: 10, right: 8, top: 8, bottom: 8),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AddressAdd.routeName);
                },
                child: const Icon(
                  Icons.add_business,
                  color: ColorPalette.white,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              clipBehavior: Clip.antiAlias,
              shrinkWrap: true,
              itemCount: address.length,
              itemBuilder: (context, index) {
                final item = address[index];
                return ListTile(
                  title: Text(
                    item.displayName,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      color: ColorPalette.blueBold2,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    item.address,
                    style: GoogleFonts.roboto(
                      color: ColorPalette.bluelight2,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  onTap: () {
                    _addController.text = item.displayName;
                    Navigator.of(context).pop();
                    log.e(item.displayName);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  String formatCurrency(int amount) {
    final formatCurrency = NumberFormat("#,##0", "vi_VN");
    return formatCurrency.format(amount);
  }
}

class MedicalReportService {
  final MedicalReport medicalReport;
  final List<PartnerService> services;

  MedicalReportService(
    this.medicalReport,
    this.services,
  );
}
