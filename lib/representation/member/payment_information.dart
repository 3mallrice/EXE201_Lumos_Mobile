import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../component/alert_dialog.dart';
import '../../core/const/back-end/error_reponse.dart';
import '../../core/const/front-end/color_const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api_model/payment/payment.dart';
import '../../component/app_bar.dart';

class QrPayment extends StatefulWidget {
  const QrPayment({super.key});

  static String routeName = '/qr_payment';

  @override
  State<QrPayment> createState() => _QrPaymentState();
}

class _QrPaymentState extends State<QrPayment> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AddPaymentResponse? addPaymentResponse =
        ModalRoute.of(context)?.settings.arguments as AddPaymentResponse;
    return Scaffold(
      appBar: const AppBarCom(
        appBarText: "Tạo mới hồ sơ",
        leading: true,
      ),
      body: PopScope(
        onPopInvoked: (didPop) async {
          // Hiển thị dialog xác nhận và đợi kết quả
          bool? confirm = await showDialog<bool>(
            context: context,
            builder: (context) => CustomAlertDialog(
              title: Text(
                'Xác nhận',
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.blueBold2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              message: Text(
                'Khi thoát, đặt hẹn sẽ bị hủy. Bạn có chắc chắn muốn thoát không?',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: ColorPalette.blueBold2,
                ),
              ),
              action: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      //call api to cancel payment
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      DiaLogMessage.confirm,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text(
                      DiaLogMessage.cancel,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );

          // Trả về kết quả cho didPop
          // ignore: void_checks
          return Future.value(confirm!);
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Swiper(
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 223, 219, 231),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: QrImageView(
                      data: addPaymentResponse.qrCode,
                      version: QrVersions.auto,
                      size: 250,
                      dataModuleStyle: const QrDataModuleStyle(
                          color: Color.fromRGBO(37, 23, 78, 1),
                          dataModuleShape: QrDataModuleShape.circle),
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    addPaymentResponse.qrCode,
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: ColorPalette.blueBold2,
                    ),
                  ),
                ],
              );
            },
            itemCount: 2,
            autoplay: false,
            pagination: const SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                color: ColorPalette.blueBold2,
                activeColor: ColorPalette.blueBold2,
              ),
            ),
            layout: SwiperLayout.TINDER,
            curve: Curves.easeInOut,
            fade: 0.5,
          ),
        ),
      ),
    );
  }
}
