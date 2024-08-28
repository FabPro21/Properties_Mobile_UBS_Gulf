import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TenantDateRange extends StatefulWidget {
  TenantDateRange({Key? key}) : super(key: key);

  @override
  State<TenantDateRange> createState() => _TenantDateRangeState();
}

class _TenantDateRangeState extends State<TenantDateRange> {
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {}
  // var initialDate = DateTime.now();
  // var initialDateRange =
  //     DateTimeRange(start: DateTime.now(), end: DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.0.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 2.0.h, right: 2.0.h),
                child: Row(
                  children: [
                    Text(
                      "Date Range",
                      style: AppTextStyle.semiBoldBlack16,
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: Colors.grey,
                        size: 3.5.h,
                      ),
                    ),
                  ],
                ),
              ),
              AppDivider(),
              Padding(
                padding: EdgeInsets.all(2.0.h),
                child: Container(
                  width: 100.0.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2.0.h),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 0.5.h,
                        spreadRadius: 0.1.h,
                        offset: Offset(0.1.h, 0.1.h),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [],
                      ),
                      Padding(
                        padding: EdgeInsets.all(1.0.h),
                        child: SfDateRangePicker(
                          selectionShape:
                              DateRangePickerSelectionShape.rectangle,
                          headerStyle: DateRangePickerHeaderStyle(
                            textAlign: TextAlign.center,
                          ),
                          headerHeight: 8.0.h,
                          selectionColor: Color.fromRGBO(0, 98, 255, 1),
                          startRangeSelectionColor:
                              Color.fromRGBO(0, 98, 255, 1),
                          endRangeSelectionColor: Color.fromRGBO(0, 98, 255, 1),
                          onSelectionChanged: _onSelectionChanged,
                          selectionMode: DateRangePickerSelectionMode.range,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
