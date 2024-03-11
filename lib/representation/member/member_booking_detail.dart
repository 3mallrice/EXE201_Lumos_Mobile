import '../../core/const/back-end/error_reponse.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import '../../api_model/authentication/login.dart';
import '../../api_model/customer/booking.dart';
import '../../api_model/customer/coming_booking.dart';
import '../../api_services/booking_service.dart';
import '../../component/app_bar.dart';
import '../../component/my_button.dart';
import '../../core/const/back-end/booking_status.dart';
import '../../core/const/back-end/workship.dart';
import '../../core/const/front-end/color_const.dart';
import '../../core/helper/local_storage_helper.dart';
import '../../login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'package:rich_readmore/rich_readmore.dart';

class BookingDetail extends StatefulWidget {
  final int? bookingId;
  const BookingDetail({super.key, this.bookingId});

  static String routeName = '/booking_detail';

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {
  BookingComing? bookingComing;
  List<MedicalService> medicalService = [];
  List<Service> service = [];

  double value = 3.5;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  CallBookingApi api = CallBookingApi();
  var log = Logger();
  bool isLoading = true;
  bool isEmptyList = true;

  TextEditingController cancelReasonController = TextEditingController();

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
      await _fetchBookingDetail(widget.bookingId);
    }
  }

  Future<void> _fetchBookingDetail(int? bookingId) async {
    if (!mounted) return;
    try {
      if (bookingId != null) {
        BookingComing? booking = await api.getBookingDetail(bookingId);
        setState(() {
          bookingComing = booking;
          medicalService = booking.medicalServices;
          isLoading = false;
        });
      } else {
        log.e("Booking id is null.");
      }
    } catch (e) {
      log.e("Error when fetching booking detail: $e");
      throw Exception("Error when fetching booking detail: $e");
    }
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if(mounted){
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    String statusText;
    int? status = bookingComing?.status;

    if (status == 0) {
      statusText = BookingStatus.status[0] ?? 'N/A';
    } else if (status == 2) {
      statusText = BookingStatus.status[2] ?? 'N/A';
    } else if (status == 3) {
      statusText = BookingStatus.status[3] ?? 'N/A';
    } else if (status == 4) {
      statusText = BookingStatus.status[4] ?? 'N/A';
    } else if (status == 5) {
      statusText = BookingStatus.status[5] ?? 'N/A';
    } else {
      statusText = 'N/A';
    }

    return Scaffold(
      appBar: AppBarCom(
        leading: true,
        appBarText: !isLoading ? '#${bookingComing?.code}' : '',
      ),
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: ColorPalette.pinkBold,
                size: 80,
              ),
            )
          : SingleChildScrollView(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.only(top: 15),
                        decoration: const BoxDecoration(
                          color: ColorPalette.blue2,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: Column(
                          children: [
                            Text(
                              bookingComing?.partner ?? '',
                              style: GoogleFonts.roboto(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: ColorPalette.blueBold2,
                              ),
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              'Mã đặt hẹn: #${bookingComing?.code ?? ''}',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: ColorPalette.blueBold2,
                              ),
                              softWrap: true,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            const Divider(
                                color: ColorPalette.white, thickness: 2),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Tình trạng: ',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: ColorPalette.blueBold2,
                                  ),
                                  softWrap: true,
                                ),
                                Text(
                                  statusText,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: ColorPalette.blueBold2,
                                  ),
                                  softWrap: true,
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_month_sharp,
                                  color: ColorPalette.blueBold2,
                                  size: 15,
                                  weight: 1.4,
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  formatDate(bookingComing?.bookingDate),
                                  style: GoogleFonts.roboto(
                                    color: ColorPalette.blueBold2,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: ColorPalette.blueBold2,
                                  size: 15,
                                  weight: 5,
                                ),
                                const SizedBox(width: 3),
                                Icon(
                                  Icons.circle,
                                  color:
                                      ColorPalette.blueBold2.withOpacity(0.5),
                                  weight: 5,
                                  size: 5.5,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  Workshift
                                      .workshiftTime[bookingComing?.bookingTime]
                                      .toString(),
                                  style: GoogleFonts.roboto(
                                    color: ColorPalette.blueBold2,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Địa chỉ: ${bookingComing?.address}',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: ColorPalette.blueBold2,
                              ),
                              softWrap: true,
                            ),
                            const SizedBox(height: 2),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              padding: const EdgeInsets.all(10),
                              decoration: ShapeDecoration(
                                color: ColorPalette.bgColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: medicalService.length,
                                itemBuilder: (context, index) {
                                  MedicalService medical =
                                      medicalService[index];
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        medical.medicalName ?? 'đang cập nhật',
                                        style: GoogleFonts.roboto(
                                          textStyle: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: ColorPalette.blueBold2,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 5),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: medical.services.length,
                                          itemBuilder: (context, serviceIndex) {
                                            Service service =
                                                medical.services[serviceIndex];
                                            return Text(
                                              service.name ?? '',
                                              style: GoogleFonts.roboto(
                                                fontSize: 16,
                                                fontWeight: FontWeight.normal,
                                                color: ColorPalette.blueBold2,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      if (index < medicalService.length - 1)
                                        const Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Divider(
                                            thickness: 1,
                                            height: 2,
                                            color: ColorPalette.blue,
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Ghi chú:',
                                    style: GoogleFonts.roboto(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: ColorPalette.blueBold2,
                                    ),
                                    softWrap: true,
                                    textAlign: TextAlign.justify,
                                  ),
                                  RichReadMoreText.fromString(
                                    text: bookingComing?.note ?? '\n',
                                    textStyle: GoogleFonts.roboto(
                                      textStyle: const TextStyle(
                                        color: ColorPalette.blueBold2,
                                        fontSize: 16,
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                        textBaseline: TextBaseline.alphabetic,
                                      ),
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
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  LumosMessage.contactSupport,
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: ColorPalette.grey,
                                    fontStyle: FontStyle.italic,
                                  ),
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  // Button
                  if (bookingComing?.status == 2 || bookingComing?.status == 4)
                    MyButton(
                      onTap: () {
                        bookingComing?.status == 4
                            ? completeBottomSheet(
                                context, bookingComing?.partner ?? 'cơ sở y tế')
                            : cancelReasonBottomSheet(context);
                      },
                      borderRadius: 10,
                      width: MediaQuery.of(context).size.width * 0.3,
                      color: ColorPalette.pinkBold,
                      widget: Text(
                        bookingComing?.status == 2 ? 'Hủy' : 'Hoàn thành',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  void cancelBooking(int bookingId, String reason) async {
    try {
      await api.cancelBooking(bookingId, reason);
      backToPage();
      //snackbar
      callSnackbar(BookingMessage.bookingStatusCancel);

      await _fetchBookingDetail(widget.bookingId);
    } catch (e) {
      log.e("Error when cancel booking: $e");
      showErrorDialog(BookingMessage.cancelBookingError);
    } finally {
      _hideLoadingOverlay();
    }
  }

  void backToPage() {
    Navigator.of(context).pop();
  }

  void completeBooking(
      int bookingId, String reason, BookingFeedback feedback) async {
    try {
      _showLoadingOverlay(context);
      await api.completeBooking(bookingId, reason, feedback);

      //snackbar
      callSnackbar(BookingMessage.bookingStatusSuccess);

      await _fetchBookingDetail(widget.bookingId);
    } catch (e) {
      log.e("Error when complete booking: $e");
      showErrorDialog(BookingMessage.completeBookingError);
    } finally {
      _hideLoadingOverlay();
    }
  }

  void callSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: ColorPalette.pinkBold,
      ),
    );
  }

  //show error dialog
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            DiaLogMessage.title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: ColorPalette.blueBold2,
            ),
          ),
          content: Text(
            message,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: ColorPalette.blueBold2,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                DiaLogMessage.ok,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.blueBold2,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //complete bottom sheet: rating and feedback
  void completeBottomSheet(BuildContext context, String partnerName) {
    showModalBottomSheet(
      backgroundColor: ColorPalette.blue2,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return RatingBottomSheet(
            partnerName: partnerName,
            bookingId: widget.bookingId,
            completeBooking: completeBooking);
      },
    );
  }

  //cancel reason bottom sheet
  void cancelReasonBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: ColorPalette.blue2,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        'Lý do hủy',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.blueBold2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      maxLines: 3,
                      controller: cancelReasonController,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        labelStyle: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: ColorPalette.blueBold2,
                        ),
                        floatingLabelStyle: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: ColorPalette.blueBold2,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorPalette.blueBold2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Nhập lý do hủy',
                      ),
                    ),
                    const SizedBox(height: 10),
                    //hiện note (i) khi hủy, booking sẽ không được thực hiện
                    const Text(
                      'Lưu ý: Khi hủy, đặt hẹn sẽ không được thực hiện.',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: ColorPalette.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 20),
                    MyButton(
                      onTap: () {
                        _showLoadingOverlay(context);
                        String cancelReason =
                            cancelReasonController.text.isEmpty
                                ? OperationSuccessMessage.updateByUser
                                : cancelReasonController.text;
                        cancelBooking(widget.bookingId!, cancelReason);
                      },
                      borderRadius: 10,
                      width: MediaQuery.of(context).size.width * 0.3,
                      color: ColorPalette.pinkBold,
                      widget: const Text(
                        DiaLogMessage.confirm,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String formatDate(String? dateString) {
    if (dateString == null) {
      return 'N/A';
    } else {
      DateTime date = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(date);
    }
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
}

class RatingBottomSheet extends StatefulWidget {
  final String partnerName;
  final int? bookingId;
  final Function completeBooking;

  const RatingBottomSheet(
      {super.key,
      required this.partnerName,
      this.bookingId,
      required this.completeBooking});

  @override
  RatingBottomSheetState createState() => RatingBottomSheetState();
}

class RatingBottomSheetState extends State<RatingBottomSheet> {
  double _ratingValue = 0.0;
  var log = Logger();

  final TextEditingController feedbackPartnerController =
      TextEditingController();
  final TextEditingController feedbackLumosController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String partnerName = widget.partnerName;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Container(
        decoration: const BoxDecoration(
          color: ColorPalette.thirdWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        'Đánh giá và phản hồi',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.blueBold2,
                        ),
                      ),
                    ),
                    // const SizedBox(height: 10),
                    //rating
                    RatingStars(
                      value: _ratingValue,
                      onValueChanged: (v) => setState(() {
                        _ratingValue = v;
                        log.i(_ratingValue);
                      }),
                      starBuilder: (index, color) => Icon(
                        Icons.star,
                        color: color,
                      ),
                      starCount: 5,
                      starSize: 60,
                      maxValue: 5,
                      starSpacing: 3,
                      valueLabelVisibility: false,
                      animationDuration: const Duration(milliseconds: 1000),
                      starOffColor: ColorPalette.grey,
                      starColor: ColorPalette.pinkBold,
                    ),
                    const SizedBox(height: 10),
                    //feedback
                    TextField(
                      maxLines: 3,
                      enableSuggestions: true,
                      textInputAction: TextInputAction.next,
                      controller: feedbackPartnerController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelStyle: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: ColorPalette.blueBold2,
                        ),
                        floatingLabelStyle: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: ColorPalette.blueBold2,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorPalette.blueBold2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Đánh giá $partnerName',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      maxLines: 3,
                      enableSuggestions: true,
                      textInputAction: TextInputAction.done,
                      controller: feedbackLumosController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelStyle: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: ColorPalette.blueBold2,
                        ),
                        floatingLabelStyle: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: ColorPalette.blueBold2,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: ColorPalette.blueBold2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        labelText: 'Đánh giá Lumos',
                      ),
                    ),
                    const SizedBox(height: 25),
                    MyButton(
                      onTap: () {
                        Navigator.of(context).pop();
                        widget.completeBooking(
                          widget.bookingId!,
                          OperationSuccessMessage.updateByUser,
                          BookingFeedback(
                            rating: _ratingValue.toDouble(),
                            feedbackPartner: feedbackPartnerController.text,
                            feedbackLumos: feedbackLumosController.text,
                            feedbackImage: "",
                          ),
                        );
                      },
                      borderRadius: 10,
                      width: MediaQuery.of(context).size.width * 0.3,
                      color: ColorPalette.pinkBold,
                      widget: const Text(
                        DiaLogMessage.confirm,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ColorPalette.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
