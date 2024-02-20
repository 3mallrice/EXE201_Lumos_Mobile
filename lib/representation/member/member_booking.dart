import '../../component/app_bar.dart';
import '../../component/my_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../core/const/front-end/color_const.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  static String routeName = '/booking';

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

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
              primary: ColorPalette.pink, // Màu chính của DatePicker
              onPrimary: ColorPalette.white, // Màu chữ trên nút xác nhận
              surface: ColorPalette.blue2, // Màu nền của DatePicker
              onSurface: ColorPalette.blueBold2, // Màu chữ trên nền DatePicker
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
              primary: ColorPalette.pink, // Màu chính của DatePicker
              onPrimary: ColorPalette.white, // Màu chữ trên nút xác nhận
              surface: ColorPalette.blue2, // Màu nền của DatePicker
              onSurface: ColorPalette.blueBold2, // Màu chữ trên nền DatePicker
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

  dynamic Function() onTap() {
    return () {
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
                  style: GoogleFonts.almarai(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: ColorPalette.blueBold2,
                  ),
                ),
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
                  /* Xử lý khi chọn 'Video' */
                },
              ),
            ],
          );
        },
      );
    };
  }

  final List<String> _customer = [
    "Nguyễn Vũ Hồng Hoa",
    "Bùi Hữu Phúc",
  ];
  final List<String> _service = [
    "Tắm cho bé",
    "Tắm cho mẹ",
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String formattedDate = DateFormat('dd-MM-yyyy').format(selectedDate);
    String formattedTime = selectedTime.format(context);

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
                    'Bệnh viện đại học Y Dược Hà Nội',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.almarai(
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
                  height: 20,
                ),
                //

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
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _service.length,
                    itemBuilder: (context, index) {
                      final item = _customer[index];
                      return Column(
                        children: [
                          ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item,
                                  style: GoogleFonts.almarai(
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: ColorPalette.blueBold2),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: ListView.builder(
                                    clipBehavior: Clip.antiAlias,
                                    shrinkWrap: true,
                                    itemCount: _service.length,
                                    itemBuilder: (context, index) {
                                      final item2 = _service[index];
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item2,
                                            style: GoogleFonts.almarai(
                                              textStyle: const TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                color: ColorPalette.blueBold2,
                                              ),
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
                          if (index < _customer.length - 1)
                            const Divider(
                              thickness: 1,
                              height: 2,
                              color: ColorPalette.blue,
                            ),
                        ],
                      );
                    },
                  ),
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
                                style: GoogleFonts.almarai(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                  color: ColorPalette.blue3,
                                ),
                              ),
                              Text(
                                formattedDate,
                                style: GoogleFonts.almarai(
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
                                style: GoogleFonts.almarai(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 13,
                                  color: ColorPalette.blue3,
                                ),
                              ),
                              Text(
                                formattedTime,
                                style: GoogleFonts.almarai(
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
                      style: GoogleFonts.almarai(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: 'Nhập địa chỉ của bạn',
                        hintStyle: GoogleFonts.almarai(
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
                      style: GoogleFonts.almarai(
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
                      style: GoogleFonts.almarai(
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
                        maxLines: 5,
                        maxLength: 255,
                        decoration: InputDecoration(
                          hintText: 'Nhập ghi chú...',
                          hintStyle: GoogleFonts.almarai(
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
                        style: GoogleFonts.almarai(
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
                Text(
                  "Bằng việc bấm nút \"Đặt hẹn\", tôi đã xác nhận rằng những thông tin tôi cung cấp là chính xác.",
                  style: GoogleFonts.almarai(
                    color: ColorPalette.blueBold2.withOpacity(0.42),
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.justify,
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
                    style: GoogleFonts.almarai(
                      color: ColorPalette.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
