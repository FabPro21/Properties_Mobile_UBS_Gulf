import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/vendor/lpos/vendor_lpo_filter/vendor_filter_lpo_status/lpo_status_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class VendorLpoStatusFilter extends StatefulWidget {
  const VendorLpoStatusFilter({Key? key}) : super(key: key);

  @override
  _VendorLpoStatusFilterState createState() => _VendorLpoStatusFilterState();
}

class _VendorLpoStatusFilterState extends State<VendorLpoStatusFilter> {
  final LpoStatusController _controller = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          backgroundColor: Colors.white,
          // backgroundColor: Colors.black,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(4.0.h),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          AppMetaLabels().lPOStatus,
                          style: AppTextStyle.semiBoldBlack16,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Get.back(result: AppMetaLabels().pleaseSelect);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(118, 118, 128, 0.12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(0.5.h),
                              child: Icon(Icons.close,
                                  size: 2.0.h,
                                  color: Color.fromRGBO(158, 158, 158, 1)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    AppDivider(),
                    ////////////////////////////////////
                    ////   Property
                    ////////////////////////////////////
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Expanded(
                      child: Obx(() {
                        return _controller.loading.value
                            ? Center(
                                child: LoadingIndicatorBlue(),
                              )
                            : _controller.error.value != ''
                                ? Center(
                                    child: Text(_controller.error.value),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _controller.lpoStatusLength,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Get.back(
                                              result: _controller.lpoStatusModel
                                                  .value.lpoStatus?[index]);
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 1.0.h),
                                            Text(SessionController()
                                                        .getLanguage() ==
                                                    1
                                                ? _controller
                                                        .lpoStatusModel
                                                        .value
                                                        .lpoStatus![index]
                                                        .lpoStatusName ??
                                                    ""
                                                : _controller
                                                        .lpoStatusModel
                                                        .value
                                                        .lpoStatus![index]
                                                        .lpoStatusNameAr ??
                                                    ""),
                                            SizedBox(height: 2.0.h),
                                            SizedBox(height: 1.0.h),
                                          ],
                                        ),
                                      );
                                    });
                      }),
                    ),
                  ]),
            ),
          )),
    );
  }
}
