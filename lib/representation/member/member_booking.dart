import 'payment_information.dart';

import '../../api_model/customer/booking.dart';
import '../../api_model/payment/payment.dart';
import '../../api_services/booking_service.dart';
import '../../api_services/payment_service.dart';
import '../../component/alert_dialog.dart';
import '../../core/const/back-end/workship.dart';

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
  // TimeOfDay? selectedTime = TimeOfDay.now();
  int selectedDayOfWeek = 0;
  int selectedTime = 0;

  final TextEditingController _addController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  BuildContext? dialogContext;

  var log = Logger();
  List<MedicalReportService?> medicalReportServices = [];

  List<Address> address = [];
  Partner? partner;

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
        selectedTime = 0;
      });
    }
  }

  ///=== Note ===
  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //     initialEntryMode: TimePickerEntryMode.input,
  //     builder: (BuildContext context, Widget? child) {
  //       return Theme(
  //         data: ThemeData.light().copyWith(
  //           colorScheme: const ColorScheme.light(
  //             primary: ColorPalette.pink,
  //             onPrimary: ColorPalette.white,
  //             surface: ColorPalette.blue2,
  //             onSurface: ColorPalette.blueBold2,
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );

  //   if (picked != null && picked != selectedTime) {
  //     setState(() {
  //       selectedTime = picked;
  //     });
  //   }
  // }

  ///=== Note ===

  CallCustomerApi calCustomerlApi = CallCustomerApi();
  CallBookingApi callBookingApi = CallBookingApi();
  CallPaymentAPI callPaymentAPI = CallPaymentAPI();
  UserDetails? userDetails;
  List<Payment> payments = [];

  Future<UserDetails>? loadAccount() async {
    return await LoginAccount.loadAccount();
  }

  OverlayEntry? _overlayEntry;

  // Hàm để hiển thị vòng loading
  void _showLoadingOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Center(
              child: LoadingAnimationWidget.fourRotatingDots(
            color: ColorPalette.pinkBold,
            size: 80,
          )),
        ],
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  // Hàm để ẩn vòng loading
  void _hideLoadingOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void fetchUserData() async {
    userDetails = await loadAccount();
    if (userDetails == null) {
      Future.delayed(Duration.zero, () {
        Navigator.of(context).pushReplacementNamed(Login.routeName);
        setState(() {});
      });
    } else {
      // _fetchAddress();
    }
  }

  @override
  void initState() {
    super.initState();
    partner = widget.partner;
    fetchUserData();
    fetchMedicalReports();
    _fetchAddress();
    fetchPayments();
  }

  Future<AddBookingResponse> addBooking(int paymentId) async {
    AddBooking newBooking = AddBooking(
      partnerId: partner!.partnerId!,
      paymentId: paymentId,
      bookingDate: selectedDate,
      dayOfWeek: selectedDayOfWeek,
      bookingTime: selectedTime,
      address: _addController.text,
      note: _noteController.text,
      cartModel: widget.cart!
          .map((e) => BookingCart(
                reportId: e.medicalReportId,
                services: e.services.map((e) => e.serviceId!).toList(),
              ))
          .toList(),
    );
    return await postAddBooking(newBooking);
  }

  Future<void> _fetchAddress() async {
    try {
      if (userDetails != null && userDetails!.id != null) {
        List<Address>? addressList =
            await calCustomerlApi.getCustomerAddress(userDetails!.id!);
        Future.delayed(
          Duration.zero,
          () {
            setState(
              () {
                address = addressList;
                log.i(address.length);
              },
            );
            log.i(address);
          },
        );
      } else {
        log.e("User details or user id is null.");
        throw Exception("User details or user id is null.");
      }
    } catch (e) {
      log.e("Error when fetching address: $e");
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

  Future<bool> fetchPayments() async {
    try {
      List<Payment> paymentList = await callPaymentAPI.getAllPayment();
      if (paymentList.isEmpty) {
        throw Exception("Failed to get all payment: $paymentList");
      } else {
        setState(() {
          payments = paymentList;
        });
        return true;
      }
    } catch (e) {
      log.e("Failed to get all payment: $e");
      return false;
    }
  }

  Future<AddBookingResponse> postAddBooking(AddBooking newBooking) async {
    try {
      AddBookingResponse result = await callBookingApi.addBooking(newBooking);
      return result;
    } catch (e) {
      log.e("Failed to add booking: $e");
      throw Exception("Failed to add booking: $e");
    }
  }

  void onTap(int totalPrice, List<MedicalReportService?> medicalReportServices,
      int selectedTime, String note, String address) {
    try {
      // Kiểm tra danh sách là null hoặc rỗng
      if (totalPrice < 0 || medicalReportServices.isEmpty) {
        showErrorDialog(BookingErrorMessage.emptyList);
        return;
      }

      // Kiểm tra danh sách không null và không rỗng
      if (selectedTime == 0 || _addController.text.isEmpty) {
        showErrorDialog(BookingErrorMessage.bookingDateTimeAddrEmpty);
      } else {
        showPaymentListBottomSheet();
      }
    } catch (e) {
      // Xử lý ngoại lệ khi dữ liệu null
      showErrorDialog(OperationErrorMessage.systemError);
    }
  }

  List<String> listWorkshift = [];

  List<String> getListWorkshift() {
    List<String> listWorkshift = [];
    selectedDayOfWeek = selectedDate.weekday + 1;
    for (Schedule schedule in partner!.schedules!) {
      if (schedule.dayOfWeek == selectedDayOfWeek) {
        int workshift = schedule.workShift!;
        listWorkshift.add(Workshift.workshiftTime[workshift]!);
      }
    }
    setState(() {});
    return listWorkshift;
  }

  void showPaymentListBottomSheet() {
    showModalBottomSheet(
      backgroundColor: ColorPalette.blue2,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  'Chọn phương thức thanh toán',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: ColorPalette.blueBold2,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(
                      Icons.double_arrow_sharp,
                      size: 30,
                      color: payments[index].status == 1
                          ? ColorPalette.pinkBold
                          : ColorPalette.pinkBold.withOpacity(0.6),
                    ),
                    title: Text(
                      payments[index].name,
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: payments[index].status == 1
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: payments[index].status == 1
                            ? ColorPalette.blueBold2
                            : ColorPalette.blueBold2.withOpacity(0.6),
                      ),
                    ),
                    subtitle: payments[index].status == 1
                        ? const Text(
                            'Đang hoạt động',
                            style: TextStyle(
                              fontSize: 16,
                              color: ColorPalette.blueBold2,
                            ),
                          )
                        : Text(
                            OnDevelopmentMessage.fearureOnDevelopmentTitle,
                            style: TextStyle(
                              color: ColorPalette.blueBold2.withOpacity(0.6),
                            ),
                          ),
                    onTap: payments[index].status == 1
                        ? () => showConfirmDialog(payments[index].paymentId)
                        : () {
                            showErrorDialog(
                                OnDevelopmentMessage.fearureOnDevelopmentTitle);
                          },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void showErrorDialog(String systemError) {
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
          content: Text(
            systemError,
            style: const TextStyle(
              color: ColorPalette.blueBold2,
            ),
            textAlign: TextAlign.justify,
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
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
  }

  void returnToPage(String routeName) {
    Navigator.of(context).pushReplacementNamed(routeName);
  }

  void popBack() {
    Navigator.of(context).pop();
  }

  void pushToPage(String routeName, Object? arguments) {
    Navigator.of(context).pushNamed(
      routeName,
      arguments: arguments,
    );
  }

  //show confirm dialog after choose payment method using CustomAlertDialog
  void showConfirmDialog(int paymentId) {
    popBack();
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
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
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
              TextButton(
                onPressed: () async {
                  try {
                    popBack();
                    _showLoadingOverlay(context);
                    AddBookingResponse result = await addBooking(paymentId);
                    if (result.bookingId > 0 && result.totalPrice > 0) {
                      AddPayment addPayment = AddPayment(
                        buyerName: userDetails!.username,
                        buyerEmail: userDetails!.email,
                        buyerPhone: userDetails!.phone,
                        buyerAddress: _addController.text,
                        bookingId: result.bookingId,
                        description: "Thanh toán đơn hàng Lumos",
                      );

                      AddPaymentResponse addPaymentResponse =
                          await callPaymentAPI.addPayment(addPayment);
                      if (addPaymentResponse.checkoutUrl.isNotEmpty) {
                        //push to payment page
                        pushToPage(QrPayment.routeName, addPaymentResponse);
                        log.i("Add payment success: $addPaymentResponse");
                      } else {
                        throw Exception(
                            "Failed to add payment: $addPaymentResponse. Please try again.");
                      }
                    } else {
                      throw Exception(
                          "Failed to add booking: $result. Please try again.");
                    }
                  } catch (e) {
                    log.e("Failed to add booking: $e");
                    showErrorDialog(OperationErrorMessage.systemError);
                  } finally {
                    _hideLoadingOverlay();
                  }
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
          PaymentMessage.paymentSuccess,
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
    // String formattedTime = selectedTime.format(context);
    Partner? partner = widget.partner;
    // total price
    int totalPrice = 0;

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
                    partner?.displayName ?? "Đang cập nhật",
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
                    textAlign: TextAlign.center,
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
                    // Expanded(
                    //   child: InkWell(
                    //     onTap: () => _selectTime(context),
                    //     child: Container(
                    //       alignment: Alignment.centerLeft,
                    //       padding: const EdgeInsets.symmetric(
                    //         vertical: 10.0,
                    //         horizontal: 20.0,
                    //       ),
                    //       decoration: BoxDecoration(
                    //         color: ColorPalette.white,
                    //         borderRadius: BorderRadius.circular(16.0),
                    //         border: Border.all(
                    //           color: ColorPalette.grey2,
                    //           width: 1.0,
                    //         ),
                    //       ),
                    //       child: Column(
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             'Giờ',
                    //             style: GoogleFonts.roboto(
                    //               fontWeight: FontWeight.normal,
                    //               fontSize: 13,
                    //               color: ColorPalette.blue3,
                    //             ),
                    //           ),
                    //           Text(
                    //             formattedTime,
                    //             style: GoogleFonts.roboto(
                    //               color: ColorPalette.blueBold2,
                    //               fontSize: 16,
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Khung giờ',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                color: ColorPalette.blue3,
                              ),
                            ),
                            DropdownButton<String>(
                              isExpanded: true,
                              hint: Text(
                                'Chọn khung giờ',
                                style: GoogleFonts.roboto(
                                  color: ColorPalette.blueBold2,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              isDense: true,
                              value: Workshift.workshiftTime[selectedTime],
                              items: getListWorkshift().map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: GoogleFonts.roboto(
                                        color: ColorPalette.blueBold2,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      )),
                                );
                              }).toList(),
                              icon: const Icon(
                                Icons.arrow_drop_down_outlined,
                                color: ColorPalette.blueBold2,
                              ),
                              iconSize: 24,
                              elevation: 3,
                              iconEnabledColor: ColorPalette.blueBold2,
                              style: GoogleFonts.roboto(
                                color: ColorPalette.blueBold2,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              underline: Container(
                                height: 0,
                              ),
                              onChanged: (String? newValue) {
                                setState(
                                  () {
                                    selectedTime =
                                        Workshift.workshiftTime.entries
                                            .firstWhere(
                                              (element) =>
                                                  element.value == newValue,
                                            )
                                            .key;
                                  },
                                );
                              },
                              alignment: Alignment.center,
                              dropdownColor: ColorPalette.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ],
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
                        controller: _noteController,
                        maxLines: 3,
                        maxLength: 255,
                        keyboardAppearance: Brightness.light,
                        keyboardType: TextInputType.multiline,
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
                    "Bằng đặt hẹn, tôi đã chắc chắn rằng những thông tin trên là chính xác.",
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
                  onTap: () => onTap(
                    totalPrice,
                    medicalReportServices,
                    selectedTime,
                    _noteController.text,
                    _addController.text,
                  ),
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
                    _addController.text = item.address;
                    Navigator.of(context).pop();
                    log.i(item.displayName);
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
