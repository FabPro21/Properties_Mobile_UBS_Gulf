import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/tenant/tenant_more/consent_setting/consent_Setting_controller.dart';
import 'package:fap_properties/views/widgets/custom_app_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TenantConsentSetting extends StatefulWidget {
  const TenantConsentSetting({Key? key}) : super(key: key);

  @override
  _TenantConsentSettingState createState() => _TenantConsentSettingState();
}

class _TenantConsentSettingState extends State<TenantConsentSetting> {
  TenantConsentSettingController _controller =
      Get.put(TenantConsentSettingController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: Directionality(
          textDirection: SessionController().getLanguage() == 1
              ? TextDirection.ltr
              : TextDirection.rtl,
          child: Column(children: [
            CustomAppBar2(
              title: AppMetaLabels().consentSetting,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(4.w, 4.0.h, 4.w, 0.2.h),
              child: Container(
                padding: EdgeInsets.fromLTRB(4.w, 2.0.h, 4.w, 2.h),
                width: 94.0.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2.0.h),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 0.5.h,
                      spreadRadius: 0.3.h,
                      offset: Offset(0.1.h, 0.1.h),
                    ),
                  ],
                ),
                child: Obx(() {
                  return _controller.loading.value
                      ? SizedBox()
                      : Row(
                          children: [
                            Text(
                              AppMetaLabels().personalDataShare,
                              style: AppTextStyle.semiBoldBlack13,
                            ),
                            const Spacer(),
                            Obx(() {
                              return FlutterSwitch(
                                inactiveColor: Color.fromRGBO(188, 190, 192, 1),
                                activeColor: Colors.blue[600]??Colors.lightBlue,
                                activeToggleColor: Colors.white,
                                inactiveToggleColor:
                                    Color.fromRGBO(76, 78, 84, 1),
                                width: 11.0.w,
                                height: 3.0.h,
                                toggleSize: 3.0.h,
                                value:
                                    _controller.sharedPersonalDataValue.value,
                                borderRadius: 2.0.h,
                                padding: 0.2.h,
                                onToggle: (val) {
                                  _controller.sharedPersonalDataValue.value =
                                      val;
                                  print(
                                      'Value ::::: ${_controller.sharedPersonalDataValue.value}');
                                  setState(() {});
                                },
                              );
                            }),
                          ],
                        );
                }),
              ),
            ),
          ]),
        ));
  }
}
