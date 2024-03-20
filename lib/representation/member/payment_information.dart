import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

import '../../api_model/payment/payment.dart';
import '../../api_services/booking_service.dart';
import '../../api_services/payment_service.dart';
import '../../component/app_bar.dart';
import '../../core/const/back-end/reponse_text.dart';
import '../../core/const/front-end/color_const.dart';
import '../../core/helper/asset_helper.dart';
import 'member_main_navbar.dart';

class QrPayment extends StatefulWidget {
  const QrPayment({super.key});

  static String routeName = '/qr_payment';

  @override
  State<QrPayment> createState() => _QrPaymentState();
}

class _QrPaymentState extends State<QrPayment> {
  CallPaymentAPI callPaymentAPI = CallPaymentAPI();
  CallBookingApi callBookingApi = CallBookingApi();
  var log = Logger();

  AddPaymentResponse? addPaymentResponse;

  DateTime? startTime; // Thêm biến lưu thời gian bắt đầu tạo QR

  @override
  void initState() {
    super.initState();
    startTime = DateTime.now(); // Khởi tạo thời gian bắt đầu
  }

  @override
  void dispose() {
    onDispose(addPaymentResponse!.paymentLinkId, addPaymentResponse!.orderCode);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    addPaymentResponse =
        ModalRoute.of(context)?.settings.arguments as AddPaymentResponse;
    return Scaffold(
      appBar: const AppBarCom(
        appBarText: "Thông tin thanh toán",
        leading: false,
      ),
      body: PopScope(
        canPop: false,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: ColorPalette.thirdWhite,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TimerCountdown(
                    startTime: startTime!,
                    duration: const Duration(minutes: 20),
                    // Xử lý khi mã QR hết hạn
                    onExpired: () => onCompleted(
                        addPaymentResponse!.paymentLinkId,
                        addPaymentResponse!.orderCode),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.63,
                    decoration: const BoxDecoration(
                      color: ColorPalette.secondaryWhite,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: PrettyQrView.data(
                      data: addPaymentResponse!.qrCode,
                      decoration: const PrettyQrDecoration(
                        image: PrettyQrDecorationImage(
                          scale: 0.2,
                          fit: BoxFit.contain,
                          image: AssetImage(
                            AssetHelper.imglogo3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Column(
                        children: [
                          FieldTransferInfo(
                            text: addPaymentResponse!.accountNumber,
                            label: "Số tài khoản",
                          ),
                          FieldTransferInfo(
                            text:
                                "${formatCurrency(addPaymentResponse!.amount)} ${addPaymentResponse!.currency}",
                            label: "Số tiền chuyển khoản",
                          ),
                          FieldTransferInfo(
                            text: addPaymentResponse!.description,
                            label: "Nội dung chuyển khoản",
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Text(
                    "Mở App Ngân hàng bất kỳ để quét mã VietQR hoặc chuyển khoản chính xác nội dung bên trên.",
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: ColorPalette.blueBold2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    textBaseline: TextBaseline.alphabetic,
                    verticalDirection: VerticalDirection.down,
                    children: [
                      Flexible(
                        flex:
                            1, // Sử dụng Flexible thay vì Expanded và đặt flex cho từng nút
                        child: ElevatedButton(
                          clipBehavior: Clip.antiAlias,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorPalette.pink,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => onCanceled(
                              addPaymentResponse!.paymentLinkId,
                              addPaymentResponse!.orderCode),
                          child: Text(
                            'Hủy',
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: ColorPalette.thirdWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: ElevatedButton(
                          clipBehavior: Clip.antiAlias,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorPalette.blueBold,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () => onCompleted(
                              addPaymentResponse!.paymentLinkId,
                              addPaymentResponse!.orderCode),
                          child: Text(
                            'Hoàn thành',
                            style: GoogleFonts.roboto(
                              fontSize: 20,
                              color: ColorPalette.thirdWhite,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

  void backToPage(String routeName) {
    Navigator.of(context).pushNamed(routeName);
  }

  void onDispose(String paymentLinkId, int bookingId) async {
    try {
      CheckPayment checkPayment =
          await callPaymentAPI.getPaymentByPaymentLinkId(paymentLinkId);

      if (checkPayment.status == PaymentStatus.PAID) {
        // Gọi hàm update booking status
        updateBookingStatus(bookingId, paymentLinkId);
      } else {
        // Các status khác (chưa thanh toán, hủy, hết hạn...)

        // Cancel booking
        cancelBooking(bookingId, PaymentMessage.paymentExpired);

        // Cancel payment
        // ignore: unused_local_variable
        CheckPayment payment = await callPaymentAPI.cancelPayment(
            paymentLinkId, OperationErrorMessage.killAppUnexpectly);
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void onCompleted(String paymentLinkId, int bookingId) async {
    try {
      _showLoadingOverlay(context);
      // Xử lý khi nút hoàn thành được nhấn
      CheckPayment checkPayment =
          await callPaymentAPI.getPaymentByPaymentLinkId(paymentLinkId);
      if (checkPayment.status == PaymentStatus.PAID) {
        paymentSuccessfully();
        // call update booking status api
        updateBookingStatus(bookingId, paymentLinkId);

        backToPage(MemberMain.routeName);
      } else if (checkPayment.status == PaymentStatus.PENDING) {
        // Hiển thị dialog thông báo thanh toán chưa thành công
        showErrorDialog(PaymentMessage.paymentPending);
      } else if (checkPayment.status == PaymentStatus.PROCESSING) {
        // Hiển thị dialog thông báo thanh toán chưa thành công
        showErrorDialog(PaymentMessage.paymentProcessing);
      } else if (checkPayment.status == PaymentStatus.CANCELLED) {
        // call cancel booking api

        cancelBooking(bookingId, PaymentMessage.paymentCancelled);

        // Hiển thị dialog thông báo thanh toán chưa thành công
        showErrorDialog(
          PaymentMessage.paymentCancelled,
          routeName: MemberMain.routeName,
        );
      } else if (checkPayment.status == PaymentStatus.EXPIRED) {
        // call cancel booking api
        cancelBooking(bookingId, PaymentMessage.paymentExpired);

        // Hiển thị dialog thông báo thanh toán chưa thành công
        showErrorDialog(
          PaymentMessage.paymentExpired,
          routeName: MemberMain.routeName,
        );
      }
    } catch (e) {
      log.e(e.toString());
      showErrorDialog(OperationErrorMessage.systemError);
    } finally {
      _hideLoadingOverlay();
    }
  }

  void cancelBooking(int bookingId, String cancellationReason) async {
    try {
      // call cancel booking api
      bool result =
          await callBookingApi.cancelBooking(bookingId, cancellationReason);
      if (result) {
        log.i("Cancel booking success");
      } else {
        log.e("Cancel booking failed");
      }
    } catch (e) {
      log.e(e.toString());
      throw Exception('Failed to cancel booking: $e');
    }
  }

  void updateBookingStatus(int bookingId, String paymentLinkId) async {
    try {
      // call update booking status api
      bool result =
          await callBookingApi.pendingBooking(bookingId, paymentLinkId);
      if (result) {
        log.i("Update booking status success");
      } else {
        log.e("Update booking status failed");
      }
    } catch (e) {
      log.e(e.toString());
      throw Exception('Failed to update booking status: $e');
    }
  }

  void onCanceled(String paymentLinkId, int bookingId) async {
    // Show dialog get reason
    TextEditingController reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: ColorPalette.blue2,
          title: Text(
            "Lý do hủy",
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: ColorPalette.pinkBold,
            ),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Column(
              children: [
                TextField(
                  controller: reasonController,
                  keyboardAppearance: Brightness.light,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    hintText: "Nhập lý do hủy",
                    hintStyle: TextStyle(
                      color: ColorPalette.blueBold2,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  PaymentMessage.paymentCancelNoti,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: ColorPalette.grey,
                  ),
                ),
              ],
            ),
          ),
          actions: [
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
                  Navigator.of(context).pop();
                  _showLoadingOverlay(context);
                  // call cancel payment api
                  CheckPayment checkPayment =
                      await callPaymentAPI.cancelPayment(
                    paymentLinkId,
                    reasonController.text,
                  );
                  //snackbar cancel success
                  if (checkPayment.status == PaymentStatus.CANCELLED ||
                      checkPayment.status == PaymentStatus.EXPIRED) {
                    paymentCancelSuccess();
                    // call cancel booking api
                    cancelBooking(bookingId, reasonController.text);

                    backToPage(MemberMain.routeName);
                  } else {
                    showErrorDialog(
                      PaymentMessage.paymentError(bookingId),
                      routeName: MemberMain.routeName,
                    );
                  }
                } catch (e) {
                  showErrorDialog(e.toString());
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
        );
      },
    );
  }

  void paymentCancelSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: ColorPalette.blueBold,
        content: Text(
          PaymentMessage.paymentCancelSuccess,
          style: TextStyle(
            color: ColorPalette.thirdWhite,
          ),
        ),
        duration: Duration(seconds: 2), // Thời gian hiển thị của snackbar
      ),
    );
  }

  void paymentSuccessfully() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorPalette.blueBold,
        content: Text(PaymentMessage.paymentSuccess,
            style: GoogleFonts.roboto(color: ColorPalette.thirdWhite)),
        duration: const Duration(seconds: 2), // Thời gian hiển thị của snackbar
      ),
    );
  }

  void showErrorDialog(String message, {String? routeName}) {
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
            message,
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
                routeName != null
                    ? Navigator.of(context).pushReplacementNamed(routeName)
                    : Navigator.of(context).pop();
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

  String formatCurrency(int amount) {
    final formatCurrency = NumberFormat("#,##0", "vi_VN");
    return formatCurrency.format(amount);
  }
}

class FieldTransferInfo extends StatefulWidget {
  const FieldTransferInfo({
    super.key,
    required this.label,
    required this.text,
  });

  final String label;
  final String text;

  @override
  State<StatefulWidget> createState() {
    return _FieldTransferInfo();
  }
}

class _FieldTransferInfo extends State<FieldTransferInfo> {
  var isClick = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Color.fromARGB(255, 168, 161, 161), width: 0.5))),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: ColorPalette.grey,
                  ),
                ),
                const SizedBox(height: 4),
                // ignore: unnecessary_string_interpolations
                Text(
                  widget.text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorPalette.blueBold2,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: IconButton(
              onPressed: () async {
                setState(() => isClick = true);
                await Clipboard.setData(ClipboardData(text: widget.text));
                await Future.delayed(const Duration(seconds: 2));
                setState(() => isClick = false);
              },
              icon: isClick
                  ? const Icon(
                      Icons.check,
                      color: ColorPalette.pinkBold,
                    )
                  : const Icon(
                      Icons.copy,
                      color: ColorPalette.pinkBold,
                    ),
            ),
          )
        ],
      ),
    );
  }
}

class TimerCountdown extends StatefulWidget {
  final DateTime startTime;
  final Duration duration;
  final VoidCallback onExpired;

  const TimerCountdown({
    super.key,
    required this.startTime,
    required this.duration,
    required this.onExpired,
  });

  @override
  TimerCountdownState createState() => TimerCountdownState();
}

class TimerCountdownState extends State<TimerCountdown> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    final endTime = widget.startTime.add(widget.duration);
    _remaining = endTime.difference(DateTime.now());

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remaining -= const Duration(seconds: 1);
        if (_remaining.isNegative) {
          _timer.cancel();
          widget.onExpired();
        }
      });
    });
  }

  @override
  void dispose() {
    widget.onExpired();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final minutes = _remaining.inMinutes.toString().padLeft(2, '0');
    final seconds = (_remaining.inSeconds % 60).toString().padLeft(2, '0');

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Text(
            "Thời gian còn lại:",
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: ColorPalette.grey,
            ),
          ),
          Text(
            '$minutes:$seconds',
            style: GoogleFonts.roboto(
              fontSize: 25,
              color: ColorPalette.blueBold2,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
