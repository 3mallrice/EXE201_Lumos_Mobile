import 'package:exe201_lumos_mobile/representation/member/medical_report.dart';

import '../../api_model/authentication/login.dart';
import '../../api_model/customer/medical_report.dart';
import '../../api_services/customer_service.dart';
import '../../core/helper/local_storage_helper.dart';
import '../../login.dart';
import 'package:logger/logger.dart';

import '../../component/app_bar.dart';
import '../../core/const/front-end/color_const.dart';
import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MedicalReportAdd extends StatefulWidget {
  const MedicalReportAdd({super.key});

  static String routeName = '/medical_report_addnew';

  @override
  State<MedicalReportAdd> createState() => _MedicalReportAddState();
}

const List<String> _listPro = [
  'Ông',
  'Bà',
  'Bé',
  'Anh',
  'Chị',
];

const List<String> _listSex = [
  'Nam', //true
  'Nữ',
];

const List<String> _listBlood = [
  'Nhóm A Rh+',
  'Nhóm A Rh-',
  'Nhóm B Rh-',
  'Nhóm B Rh-',
  'Nhóm O Rh+',
  'Nhóm O Rh-',
  'Nhóm AB Rh+',
  'Nhóm AB Rh-',
];

class _MedicalReportAddState extends State<MedicalReportAdd> {
  DateTime _selectedDate = DateTime.now();
  CallCustomerApi api = CallCustomerApi();
  var log = Logger();

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
      _saveData();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _saveData() async {
    if (userDetails != null) {
      final customerId = userDetails!.id;
      final name = _nameController.text;
      final pronoun = _selectedPronoun;
      final gender = _selectedGender;
      final dob = _selectedDate;
      final bloodType = _selectedBloodType;
      final phoneNumber = _phoneNumberController.text;
      final note = _noteController.text;

      final newMedicalReport = MedicalReport(
        fullname: name,
        pronounce: pronoun,
        gender: gender,
        dob: dob,
        bloodType: bloodType,
        phone: phoneNumber,
        note: note,
      );

      try {
        bool isSuccess =
            await api.addNewMedicalReport(customerId!, newMedicalReport);

        if (isSuccess) {
          //show dialog
          _showSuccessDialog();
        } else {
          _showFailDialog();
        }

        // Clear text controllers
        _nameController.clear();
        _phoneNumberController.clear();
        _noteController.clear();

        // Reset state variables for dropdowns and date selection
        setState(() {
          _selectedPronoun = 0;
          _selectedGender = true;
          _selectedBloodType = 0;
          _selectedDate = DateTime.now();
        });
        Navigator.of(context).pushNamed(MedicalReportPage.routeName);
      } catch (error) {
        log.e('Error adding new medical report: $error');
      }
    }
  }

  void _showResultDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
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
  }

  void _showSuccessDialog() {
    _showResultDialog('Thành công', 'Thêm mới bệnh nhân thành công!');
  }

  void _showFailDialog() {
    _showResultDialog(
        'Thất bại', 'Thêm mới bệnh nhân thất bại! Vui lòng thử lại!');
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      currentDate: DateTime.now(),
      locale: const Locale("vi", "VN"),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: _selectedDate,
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
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

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  int _selectedPronoun = 0;
  bool _selectedGender = true;
  int _selectedBloodType = 0;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String formattedDate = DateFormat('dd-MM-yyyy').format(_selectedDate);
    return Scaffold(
      appBar: const AppBarCom(
        appBarText: "Tạo mới danh sách bệnh nhân",
        leading: true,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: screenWidth * 0.9,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Họ và tên',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    TextField(
                      controller: _nameController,
                      textAlign: TextAlign.start,
                      maxLength: 20,
                      decoration: InputDecoration(
                        hintText: 'Nguyễn Văn A',
                        hintStyle: GoogleFonts.roboto(
                          color: ColorPalette.blueBold2.withOpacity(0.65),
                        ),
                        filled: true,
                        fillColor: ColorPalette.secondaryWhite,
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
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Danh xưng',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: ColorPalette.blueBold2,
                            ),
                          ),
                          CustomDropdown<String>(
                            closedHeaderPadding: const EdgeInsets.all(20),
                            hintText: 'Chọn danh xưng',
                            items: _listPro,
                            initialItem: _listPro[0],
                            onChanged: (value) {
                              setState(() {
                                _selectedPronoun = _listPro.indexOf(value);
                              });
                            },
                            decoration: CustomDropdownDecoration(
                              headerStyle: GoogleFonts.roboto(
                                color: ColorPalette.blueBold2.withOpacity(0.65),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              hintStyle: GoogleFonts.roboto(
                                color: ColorPalette.blueBold2.withOpacity(0.65),
                              ),
                              closedFillColor: ColorPalette.secondaryWhite,
                              closedBorderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                              closedBorder: const Border(
                                top: BorderSide(
                                    color: ColorPalette.grey2, width: 1.0),
                                left: BorderSide(
                                    color: ColorPalette.grey2, width: 1.0),
                                right: BorderSide(
                                    color: ColorPalette.grey2, width: 1.0),
                                bottom: BorderSide(
                                    color: ColorPalette.grey2, width: 1.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Giới tính',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: ColorPalette.blueBold2,
                            ),
                          ),
                          CustomDropdown<String>(
                            closedHeaderPadding: const EdgeInsets.all(20),
                            hintText: 'Chọn giới tính',
                            items: _listSex,
                            initialItem: _listSex[0],
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value == 'Nam';
                              });
                            },
                            decoration: CustomDropdownDecoration(
                              headerStyle: GoogleFonts.roboto(
                                color: ColorPalette.blueBold2.withOpacity(0.65),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              hintStyle: GoogleFonts.roboto(
                                color: ColorPalette.blueBold2.withOpacity(0.65),
                              ),
                              closedFillColor: ColorPalette.secondaryWhite,
                              closedBorderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                              closedBorder: const Border(
                                top: BorderSide(
                                    color: ColorPalette.grey2, width: 1.0),
                                left: BorderSide(
                                    color: ColorPalette.grey2, width: 1.0),
                                right: BorderSide(
                                    color: ColorPalette.grey2, width: 1.0),
                                bottom: BorderSide(
                                    color: ColorPalette.grey2, width: 1.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ngày sinh',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: ColorPalette.blueBold2,
                            ),
                          ),
                          InkWell(
                            onTap: () => _selectDate(context),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: ColorPalette.secondaryWhite,
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                  color: ColorPalette.grey2,
                                  width: 1.0,
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    color: ColorPalette.blueBold2,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    formattedDate,
                                    style: GoogleFonts.roboto(
                                      color: ColorPalette.blueBold2
                                          .withOpacity(0.65),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nhóm máu',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                              color: ColorPalette.blueBold2,
                            ),
                          ),
                          CustomDropdown<String>(
                            closedHeaderPadding: const EdgeInsets.all(20),
                            hintText: 'Chọn nhóm máu',
                            items: _listBlood,
                            initialItem: _listBlood[0],
                            onChanged: (value) {
                              setState(() {
                                _selectedBloodType = _listBlood.indexOf(value);
                              });
                            },
                            decoration: CustomDropdownDecoration(
                              headerStyle: GoogleFonts.roboto(
                                color: ColorPalette.blueBold2.withOpacity(0.65),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                              hintStyle: GoogleFonts.roboto(
                                color: ColorPalette.blueBold2.withOpacity(0.65),
                              ),
                              closedFillColor: ColorPalette.secondaryWhite,
                              closedBorderRadius: const BorderRadius.all(
                                Radius.circular(16),
                              ),
                              closedBorder: const Border(
                                top: BorderSide(
                                    color: ColorPalette.grey2, width: 1.0),
                                left: BorderSide(
                                    color: ColorPalette.grey2, width: 1.0),
                                right: BorderSide(
                                    color: ColorPalette.grey2, width: 1.0),
                                bottom: BorderSide(
                                    color: ColorPalette.grey2, width: 1.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Số điện thoại',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    TextField(
                      controller: _phoneNumberController,
                      textAlign: TextAlign.start,
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText: '0912345678',
                        hintStyle: GoogleFonts.roboto(
                          color: ColorPalette.blueBold2.withOpacity(0.65),
                        ),
                        filled: true,
                        fillColor: ColorPalette.secondaryWhite,
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
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ghi chú',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    SingleChildScrollView(
                      child: TextField(
                        controller: _noteController,
                        maxLines: 5,
                        maxLength: 255,
                        decoration: InputDecoration(
                          hintText: 'Nhập ghi chú...',
                          hintStyle: GoogleFonts.roboto(
                            color: ColorPalette.blueBold2.withOpacity(0.65),
                          ),
                          filled: true,
                          fillColor: ColorPalette.secondaryWhite,
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: FractionallySizedBox(
        widthFactor: 0.9,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: ElevatedButton(
            onPressed: () {
              _saveData();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorPalette.pink,
              padding: const EdgeInsets.all(12),
              minimumSize: const Size(100, 40),
            ),
            child: Text(
              'Lưu',
              style: GoogleFonts.roboto(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: ColorPalette.secondaryWhite,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
