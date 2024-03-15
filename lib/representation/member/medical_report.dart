import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';

import '../../api_model/authentication/login.dart';
import '../../api_model/customer/medical_report.dart';
import '../../api_services/customer_service.dart';
import '../../component/alert_dialog.dart';
import '../../component/app_bar.dart';
import '../../core/const/back-end/error_reponse.dart';
import '../../core/const/front-end/color_const.dart';
import '../../core/helper/local_storage_helper.dart';
import '../../login.dart';
import 'medical_report_add.dart';
import 'medical_report_detail.dart';

class MedicalReportPage extends StatefulWidget {
  const MedicalReportPage({super.key});

  static String routeName = '/medical_report';

  @override
  State<MedicalReportPage> createState() => _MedicalReportPageState();
}

class _MedicalReportPageState extends State<MedicalReportPage> {
  CallCustomerApi api = CallCustomerApi();
  var log = Logger();

  List<MedicalReport> _reports = [];
  List<MedicalReport>? reports;
  bool _isEmptyList = true;
  bool isLoaded = false;

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
      _fetchMedicalReports();
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    if (mounted) {
      super.setState(fn);
    }
  }

  void _fetchMedicalReports() async {
    try {
      if (userDetails != null && userDetails!.id != null) {
        reports = await api.getMedicalReport(userDetails!.id!);
        setState(() {
          _reports = reports!;
          _isEmptyList = _reports.isEmpty;
          isLoaded = true;
        });
      } else {
        log.e("User details or user id is null.");
        throw Exception("User details or user id is null.");
      }
    } catch (e) {
      setState(() {
        log.e("Error when fetching medical reports: $e");
        _reports = [];
        _isEmptyList = true;
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCom(
        appBarText: "Danh sách hồ sơ",
        leading: true,
      ),
      body: !isLoaded
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: ColorPalette.pinkBold,
                size: 80,
              ),
            )
          : _isEmptyList
              ? Center(
                  child: Text(
                    "Không có hồ sơ nào, hãy thêm hồ sơ!",
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: ColorPalette.blueBold2,
                      ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              : Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: ShapeDecoration(
                    color: ColorPalette.blue2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                  child: ListView.builder(
                    clipBehavior: Clip.antiAlias,
                    shrinkWrap: true,
                    itemCount: _reports.length,
                    itemBuilder: (context, index) {
                      final item = _reports[index];
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                MedicalReportDetail.routeName,
                                arguments: reports![index],
                              );
                            },
                            child: ListTile(
                              leading: const Icon(
                                Icons.medical_services,
                                size: 23,
                                color: ColorPalette.pink,
                              ),
                              title: Text(
                                item.fullname,
                                style: GoogleFonts.roboto(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: ColorPalette.blueBold2,
                                  ),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () => onDevelopmentFeature(),
                                      child: const Text(
                                        'Sửa',
                                        style: TextStyle(
                                          color: ColorPalette.pink,
                                          fontSize: 16,
                                          fontFamily: 'roboto',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (index < _reports.length - 1 &&
                              _reports.length > 1)
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
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(MedicalReportAdd.routeName);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorPalette.pink,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(12),
          ),
          child: const Icon(
            Icons.add,
            size: 40,
            color: ColorPalette.white,
          ),
        ),
      ),
    );
  }

  void onDevelopmentFeature() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          title: Text(OnDevelopmentMessage.fearureOnDevelopmentTitle,
              style: GoogleFonts.roboto(
                color: ColorPalette.blueBold2,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
          message: Text(
            OnDevelopmentMessage.featureOnDevelopment,
            style: GoogleFonts.roboto(
              color: ColorPalette.blueBold2,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          confirmText: "OK",
          onConfirm: () {
            setState(() {});
            Navigator.of(context).pop();
          },
        );
      },
    );
  }
}
