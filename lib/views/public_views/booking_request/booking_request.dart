// import 'dart:typed_data';

// import 'package:fap_properties/data/models/public_models/get_property_detail_model.dart';
// import 'package:fap_properties/utils/constants/assets_path.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/utils/styles/colors.dart';
// import 'package:fap_properties/utils/styles/text_styles.dart';
// import 'package:fap_properties/views/public_views/booking_request/booking_request_controller.dart';
// import 'package:fap_properties/views/public_views/booking_request/public_booking_agent_list.dart';
// import 'package:fap_properties/views/public_views/search_properties_properties/search_properties_result/get_property_detail/get_property_detail_controller.dart';
// import 'package:fap_properties/views/public_views/search_properties_properties/search_properties_result/search_properties_result_controller.dart';
// import 'package:fap_properties/views/public_views/search_properties_services_request/public_service_request_tab.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart' as intl;
// import 'package:keyboard_actions/keyboard_actions.dart';
// import 'package:sizer/sizer.dart';

// import '../../../data/helpers/session_controller.dart';
// import '../../../utils/styles/text_field_style.dart';
// import '../../../utils/text_validator.dart';
// import '../../../views/widgets/clear_button.dart';

// class BookingRequest extends StatefulWidget {
//   final Property property?;
//   final int index;
//   const BookingRequest({
//     Key key,
//     this.property?,
//     this.index,
//   }) : super(key: key);

//   @override
//   _BookingRequestState createState() => _BookingRequestState();
// }

// class _BookingRequestState extends State<BookingRequest> {
//   final gPDController = Get.put(GetPropertyDetailController());
//   final bookingRequestController = Get.put(BookingRequestController());
//   final sPRController = Get.put(SearchPropertiesResultController());
//   TextEditingController remarksController = TextEditingController();
//   TextEditingController otherPersonNameController = TextEditingController();
//   TextEditingController otherPersonPnoController = TextEditingController();
//   // final FocusNode _nodeTextReqDetails = FocusNode();
//   // final formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     double am = double.parse((widget.property?.amount ?? 0.0).toString());

//     final paidFormatter = intl.NumberFormat('#,##0.00', 'AR');
//     String amount = paidFormatter.format(am);
//     amount = AppMetaLabels().aed + amount;

//     return Directionality(
//       textDirection: SessionController().getLanguage() == 1
//           ? TextDirection.ltr
//           : TextDirection.rtl,
//       child: Scaffold(
//           resizeToAvoidBottomInset: false,
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back_ios,
//               ),
//               iconSize: 2.0.h,
//               onPressed: () {
//                 Get.back();
//               },
//             ),
//             flexibleSpace: Container(
//               decoration: const BoxDecoration(
//                 color: Colors.white,
//                 image: DecorationImage(
//                   image: AssetImage(
//                     AppImagesPath.appbarimg,
//                   ),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             backgroundColor: Colors.white,
//             title: Text(
//               AppMetaLabels().bookingRequest,
//               style: AppTextStyle.semiBoldWhite14,
//             ),
//           ),
//           body: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: 3.0.w, vertical: 3.0.h),
//                   child: Container(
//                     width: 94.0.w,
//                     padding:
//                         EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(1.0.h),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey[300],
//                           blurRadius: 1.0.h,
//                           spreadRadius: 0.6.h,
//                           offset: Offset(0.1.h, 0.7.h),
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 18.w,
//                           height: 11.h,
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(1.0.h),
//                             child: StreamBuilder<Uint8List>(
//                               stream: sPRController.getUnitImage(widget.index),
//                               builder: (
//                                 BuildContext context,
//                                 AsyncSnapshot<Uint8List> snapshot,
//                               ) {
//                                 if (snapshot.hasData) {
//                                   return Image.memory(snapshot.data,
//                                       fit: BoxFit.cover);
//                                 } else {
//                                   return Center(child: Icon(Icons.ac_unit));
//                                 }
//                               },
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(left: 1.0.h, right: 1.0.h),
//                           child: Container(
//                             width: 62.0.w,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   widget.property?.propertyName ?? "",
//                                   style: AppTextStyle.semiBoldBlack11,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 SizedBox(
//                                   height: 1.0.h,
//                                 ),
//                                 Text(
//                                   "${AppMetaLabels().unit}: ${widget.property?.unitRefNo}",
//                                   style: AppTextStyle.semiBoldGrey10,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 SizedBox(
//                                   height: 1.0.h,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Icon(
//                                       Icons.location_on_outlined,
//                                       color: AppColors.greyColor,
//                                       size: 2.5.h,
//                                     ),
//                                     Container(
//                                       width: 55.0.w,
//                                       child: Text(
//                                         widget.property?.address ?? "",
//                                         style: AppTextStyle.normalGrey10,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 1.2.h,
//                                 ),
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     columnList(AppMetaLabels().beds,
//                                         "${widget.property?.bedRooms ?? ""}"),
//                                     columnList(AppMetaLabels().bath,
//                                         "${widget.property?.noofWashrooms ?? ""}"),
//                                     columnList(AppMetaLabels().sqFt,
//                                         "${widget.property?.areaSize ?? ""}"),
//                                     columnList(
//                                         AppMetaLabels().amount+'', amount),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 3.w),
//                     child: Container(
//                       width: 100.0.w,
//                       padding: EdgeInsets.all(2.0.h),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(2.0.h),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey[300],
//                             blurRadius: 1.0.h,
//                             spreadRadius: 0.6.h,
//                             offset: Offset(0.0.h, 0.7.h),
//                           ),
//                         ],
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             AppMetaLabels().contactPersonDetails,
//                             style: AppTextStyle.semiBoldGrey12,
//                           ),
//                           SizedBox(
//                             height: 2.0.h,
//                           ),
//                           Text(
//                             '${AppMetaLabels().fullName} *',
//                             style: AppTextStyle.normalGrey10,
//                           ),
//                           SizedBox(
//                             height: 1.0.h,
//                           ),
//                           TextField(
//                             controller: otherPersonNameController,
//                             // validator: (value) {
//                             //   if (value.isEmpty)
//                             //     return AppMetaLabels().requiredField;
//                             //   else if (?nameValidator.hasMatch(value)) {
//                             //     return AppMetaLabels().invalidName;
//                             //   } else
//                             //     return null;
//                             // },
//                             decoration: textFieldDecoration.copyWith(
//                                 hintText: AppMetaLabels().pleaseEnter),
//                             keyboardType: TextInputType.name,
//                             style: AppTextStyle.normalGrey10,
//                             maxLines: 1,
//                             onChanged: (value) {},
//                           ),

//                           SizedBox(
//                             height: 2.0.h,
//                           ),
//                           Text(
//                             '${AppMetaLabels().phoneNumber} *',
//                             style: AppTextStyle.normalGrey10,
//                           ),
//                           SizedBox(
//                             height: 1.0.h,
//                           ),
//                           TextField(
//                             controller: otherPersonPnoController,
//                             // validator: (value) {
//                             //   if (value.isEmpty)
//                             //     return AppMetaLabels().requiredField;
//                             //   else if (?phoneValidator.hasMatch(value)) {
//                             //     return AppMetaLabels().invalidPhone;
//                             //   } else
//                             //     return null;
//                             // },
//                             decoration: textFieldDecoration.copyWith(
//                                 hintText: AppMetaLabels().pleaseEnter),
//                             keyboardType: TextInputType.phone,
//                             style: AppTextStyle.normalGrey10,
//                             maxLines: 1,
//                             onChanged: (value) {},
//                           ),

//                         ],
//                       ),
//                     )),
//                 Padding(
//                   padding:
//                       EdgeInsets.symmetric(vertical: 3.0.h, horizontal: 3.w),
//                   child: Container(
//                     width: 100.0.w,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(2.0.h),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey[300],
//                           blurRadius: 1.0.h,
//                           spreadRadius: 0.6.h,
//                           offset: Offset(0.0.h, 0.7.h),
//                         ),
//                       ],
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(2.0.h),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             AppMetaLabels().requestDetails,
//                             style: AppTextStyle.semiBoldGrey12,
//                           ),
//                           SizedBox(
//                             height: 2.0.h,
//                           ),
//                           Text(
//                             '${AppMetaLabels().describeTheService} *',
//                             style: AppTextStyle.normalGrey10,
//                           ),
//                           SizedBox(
//                             height: 1.0.h,
//                           ),
//                           TextField(
//                             // focusNode: _nodeTextReqDetails,
//                             controller: remarksController,
//                             // validator: (value) {
//                             //   if (value.isEmpty)
//                             //     return AppMetaLabels().requiredField;
//                             //   else if (?textValidator.hasMatch(value)) {
//                             //     return AppMetaLabels().invalidText;
//                             //   } else
//                             //     return null;
//                             // },
//                             decoration: textFieldDecoration.copyWith(
//                                 hintText: AppMetaLabels().enterRemarks),
//                             keyboardType: TextInputType.multiline,
//                             style: AppTextStyle.normalGrey10,
//                             maxLines: 5,
//                             minLines: 5,
//                             onChanged: (value) {},
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 3.w),
//                     child: Container(
//                         width: 100.0.w,
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(2.0.h),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey[300],
//                               blurRadius: 1.0.h,
//                               spreadRadius: 0.6.h,
//                               offset: Offset(0.0.h, 0.7.h),
//                             ),
//                           ],
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.all(2.0.h),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 AppMetaLabels().agentDetails,
//                                 style: AppTextStyle.semiBoldGrey12,
//                               ),
//                               SizedBox(
//                                 height: 2.0.h,
//                               ),
//                               Text(
//                                 AppMetaLabels().selectAgent,
//                                 style: AppTextStyle.normalGrey10,
//                               ),
//                               SizedBox(
//                                 height: 1.0.h,
//                               ),

//                               ////////////////////////////////////////////
//                               InkWell(
//                                 onTap: () async {
//                                   FocusScope.of(context).unfocus();
//                                   var agent = await Get.to(
//                                       () => PublicBookingAgentList());
//                                   if (agent ?= null) {
//                                     bookingRequestController.agentId.value =
//                                         agent[1];
//                                     bookingRequestController.agentName.value =
//                                         agent[0];
//                                   }
//                                 },
//                                 //////////////////////////////////////
//                                 child: Container(
//                                   width: 100.0.w,
//                                   height: 5.0.h,
//                                   decoration: BoxDecoration(
//                                     color: Color.fromRGBO(246, 248, 249, 1),
//                                     borderRadius:
//                                         BorderRadius.circular(0.5.h),
//                                   ),
//                                   child: Padding(
//                                     padding: EdgeInsets.only(
//                                         left: 1.5.h, right: 1.5.h),
//                                     child: Row(
//                                       children: [
//                                         Obx(() {
//                                           return Text(
//                                             bookingRequestController
//                                                 .agentName.value,
//                                             style: AppTextStyle.normalGrey10,
//                                           );
//                                         }),
//                                         Spacer(),
//                                         ClearButton(
//                                           clear: () {
//                                             bookingRequestController
//                                                 .agentId('');
//                                             bookingRequestController
//                                                     .agentName.value =
//                                                 AppMetaLabels().pleaseSelect;
//                                           },
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ))),
//                 Obx(() {
//                   return bookingRequestController.loadingSaveBooking.value
//                       ? Center(
//                           child: Padding(
//                             padding: EdgeInsets.all(3.5.h),
//                             child: CircularProgressIndicator(
//                               color: AppColors.blueColor,
//                             ),
//                           ),
//                         )
//                       : Padding(
//                           padding: EdgeInsets.all(3.5.h),
//                           child: ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(1.3.h),
//                               ), backgroundColor: Color.fromRGBO(0, 61, 166, 1),
//                             ),
//                             onPressed: () async {
//                               // if (?formKey.currentState.validate()) {
//                               //   return;
//                               // }
//                               FocusScope.of(context).unfocus();
//                               var resp = await bookingRequestController
//                                   .saveBookingRequestData(
//                                       widget.property?.propertyID,
//                                       remarksController.text,
//                                       widget.property?.unitID,
//                                       otherPersonNameController.text,
//                                       otherPersonPnoController.text);
//                               if (resp ?= null) {
//                                 bookingRequestController.agentName.value =
//                                     AppMetaLabels().pleaseSelect;
//                                 otherPersonPnoController.clear();
//                                 otherPersonNameController.clear();
//                                 remarksController.clear();
//                                 Get.to(
//                                   () => PublicServiceRequestTab(
//                                     requestNo: resp ?? 0,
//                                     unitId: 123,
//                                     backToSearch: true,
//                                     canCommunicate: true,
//                                   ),
//                                 );
//                               }
//                             },
//                             child: SizedBox(
//                               width: 80.w,
//                               height: 6.h,
//                               child: Center(
//                                 child: Text(
//                                   AppMetaLabels().submitRequest,
//                                   style: AppTextStyle.semiBoldWhite12,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                 })
//               ],
//             ),
//           )),
//     );
//   }

//   Column columnList(String t1, String t2) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           t1,
//           style: AppTextStyle.normalGrey10,
//           overflow: TextOverflow.ellipsis,
//         ),
//         SizedBox(
//           height: 0.5.h,
//         ),
//         // 1122
//         Text(
//           t2,
//           style: AppTextStyle.semiBoldBlack10,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ],
//     );
//   }
// }
import 'package:fap_properties/data/models/public_models/get_property_detail_model.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/public_views/booking_request/booking_request_controller.dart';
import 'package:fap_properties/views/public_views/booking_request/public_booking_agent_list.dart';
import 'package:fap_properties/views/public_views/search_properties_properties/search_properties_result/get_property_detail/get_property_detail_controller.dart';
import 'package:fap_properties/views/public_views/search_properties_properties/search_properties_result/search_properties_result_controller.dart';
import 'package:fap_properties/views/public_views/search_properties_services_request/public_service_request_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../data/helpers/session_controller.dart';
import '../../../utils/styles/text_field_style.dart';
import '../../../utils/text_validator.dart';
import '../../../views/widgets/clear_button.dart';

import 'package:flutter/services.dart';

class BookingRequest extends StatefulWidget {
  final Property? property;
  final int? index;
  const BookingRequest({
    Key? key,
    this.property,
    this.index,
  }) : super(key: key);

  @override
  _BookingRequestState createState() => _BookingRequestState();
}

class _BookingRequestState extends State<BookingRequest> {
  final gPDController = Get.put(GetPropertyDetailController());
  final bookingRequestController = Get.put(BookingRequestController());

  final sPRController = Get.put(SearchPropertiesResultController());
  TextEditingController remarksController = TextEditingController();
  TextEditingController otherPersonNameController = TextEditingController();
  TextEditingController otherPersonPnoController = TextEditingController();
  final FocusNode _nodeTextReqDetails = FocusNode();
  final formKey = GlobalKey<FormState>();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: Colors.grey[200],
        nextFocus: true,
        actions: [
          KeyboardActionsItem(
            focusNode: _nodeTextReqDetails,
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    double am = double.parse((widget.property?.amount ?? 0.0).toString());

    final paidFormatter = intl.NumberFormat('#,##0.00', 'AR');
    String amount = paidFormatter.format(am);
    amount = AppMetaLabels().aed + amount;

    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              iconSize: 2.0.h,
              onPressed: () {
                Get.back();
              },
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(
                    AppImagesPath.appbarimg,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            title: Text(
              AppMetaLabels().bookingRequest,
              style: AppTextStyle.semiBoldWhite14,
            ),
          ),
          body: KeyboardActions(
            config: _buildConfig(context),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 3.0.w, vertical: 3.0.h),
                    child: Container(
                      width: 94.0.w,
                      padding:
                          EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(1.0.h),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300] ?? Colors.grey,
                            blurRadius: 1.0.h,
                            spreadRadius: 0.6.h,
                            offset: Offset(0.1.h, 0.7.h),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 18.w,
                            height: 11.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(1.0.h),
                              child: StreamBuilder<Uint8List>(
                                stream: sPRController
                                    .getUnitImage(widget.index ?? 0),
                                builder: (
                                  BuildContext context,
                                  AsyncSnapshot<Uint8List> snapshot,
                                ) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(2.0.h),
                                        topRight: Radius.circular(2.0.h),
                                      ),
                                      child: SizedBox(
                                        height: 36.0.h,
                                        width: 100.0.w,
                                        child: Shimmer.fromColors(
                                          baseColor:
                                              Colors.grey.withOpacity(0.1),
                                          highlightColor:
                                              Colors.grey.withOpacity(0.5),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(2.0.h),
                                              topRight: Radius.circular(2.0.h),
                                            ),
                                            child: Image.asset(
                                                AppImagesPath.thumbnail,
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  if (snapshot.hasData) {
                                    return Image.memory(snapshot.data!,
                                        fit: BoxFit.cover);
                                  } else {
                                    return Center(child: Icon(Icons.ac_unit));
                                  }
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 1.0.h, right: 1.0.h),
                            child: Container(
                              width: 62.0.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.property?.propertyName ?? "",
                                    style: AppTextStyle.semiBoldBlack11,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 1.0.h,
                                  ),
                                  Text(
                                    "${AppMetaLabels().unit}: ${widget.property?.unitRefNo}",
                                    style: AppTextStyle.semiBoldGrey10,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(
                                    height: 1.0.h,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: AppColors.greyColor,
                                        size: 2.5.h,
                                      ),
                                      Container(
                                        width: 55.0.w,
                                        child: Text(
                                          widget.property?.address ?? "",
                                          style: AppTextStyle.normalGrey10,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.2.h,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      widget.property?.bedRooms == '0' ||
                                              widget.property?.bedRooms == 0 ||
                                              widget.property?.bedRooms == null
                                          ? SizedBox()
                                          : columnList(AppMetaLabels().beds,
                                              "${widget.property?.bedRooms ?? ""}"),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      widget.property?.noofWashrooms == '0' ||
                                              widget.property?.noofWashrooms ==
                                                  0 ||
                                              widget.property?.noofWashrooms ==
                                                  null
                                          ? SizedBox()
                                          : columnList(AppMetaLabels().bath,
                                              "${widget.property?.noofWashrooms ?? ""}"),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      columnList(AppMetaLabels().sqFt,
                                          "${widget.property?.areaSize ?? ""}"),
                                      // columnList(AppMetaLabels().sqFt,
                                      //     "${widget.property?.areaSize ?? ""}"),
                                      // columnList(
                                      //     AppMetaLabels().amount + '', amount),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      columnList(
                                          AppMetaLabels().amount + '', amount),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Container(
                        width: 100.0.w,
                        padding: EdgeInsets.all(2.0.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2.0.h),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[300] ?? Colors.grey,
                              blurRadius: 1.0.h,
                              spreadRadius: 0.6.h,
                              offset: Offset(0.0.h, 0.7.h),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppMetaLabels().contactPersonDetails,
                              style: AppTextStyle.semiBoldGrey12,
                            ),
                            SizedBox(
                              height: 2.0.h,
                            ),
                            Text(
                              '${AppMetaLabels().fullName} *',
                              style: AppTextStyle.normalGrey10,
                            ),
                            SizedBox(
                              height: 1.0.h,
                            ),
                            TextFormField(
                              controller: otherPersonNameController,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return AppMetaLabels().requiredField;
                                else if (!nameValidator.hasMatch(value)) {
                                  return AppMetaLabels().invalidName;
                                } else
                                  return null;
                              },
                              decoration: textFieldDecoration.copyWith(
                                  hintText: AppMetaLabels().pleaseEnter),
                              keyboardType: TextInputType.name,
                              style: AppTextStyle.normalGrey10,
                              maxLines: 1,
                              onChanged: (value) {},
                            ),
                            SizedBox(
                              height: 2.0.h,
                            ),
                            Text(
                              '${AppMetaLabels().phoneNumber} ',
                              style: AppTextStyle.normalGrey10,
                            ),
                            SizedBox(
                              height: 1.0.h,
                            ),
                            TextFormField(
                              controller: otherPersonPnoController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (value) {
                                if (value!.isEmpty)
                                  return AppMetaLabels().requiredField;
                                else if (!phoneValidator.hasMatch(value)) {
                                  return AppMetaLabels().invalidPhone;
                                } else
                                  return null;
                              },
                              decoration: textFieldDecoration.copyWith(
                                  hintText: AppMetaLabels().pleaseEnter),
                              keyboardType: TextInputType.phone,
                              style: AppTextStyle.normalGrey10,
                              maxLines: 1,
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                      )),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 3.0.h, horizontal: 3.w),
                    child: Container(
                      width: 100.0.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2.0.h),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300] ?? Colors.grey,
                            blurRadius: 1.0.h,
                            spreadRadius: 0.6.h,
                            offset: Offset(0.0.h, 0.7.h),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(2.0.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppMetaLabels().requestDetails,
                              style: AppTextStyle.semiBoldGrey12,
                            ),
                            SizedBox(
                              height: 2.0.h,
                            ),
                            Text(
                              '${AppMetaLabels().describeTheService} *',
                              style: AppTextStyle.normalGrey10,
                            ),
                            SizedBox(
                              height: 1.0.h,
                            ),
                            TextFormField(
                              focusNode: _nodeTextReqDetails,
                              controller: remarksController,
                              validator: (value) {
                                if (value!.isEmpty)
                                  return AppMetaLabels().requiredField;
                                else if (!textValidator
                                    .hasMatch(value.replaceAll('\n', ' '))) {
                                  return AppMetaLabels().invalidText;
                                } else
                                  return null;
                              },
                              decoration: textFieldDecoration.copyWith(
                                  hintText: AppMetaLabels().enterRemarks),
                              keyboardType: TextInputType.multiline,
                              style: AppTextStyle.normalGrey10,
                              maxLines: 5,
                              minLines: 5,
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.w),
                      child: Container(
                          width: 100.0.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2.0.h),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[300] ?? Colors.grey,
                                blurRadius: 1.0.h,
                                spreadRadius: 0.6.h,
                                offset: Offset(0.0.h, 0.7.h),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2.0.h),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppMetaLabels().agentDetails,
                                  style: AppTextStyle.semiBoldGrey12,
                                ),
                                SizedBox(
                                  height: 2.0.h,
                                ),
                                Text(
                                  AppMetaLabels().selectAgent,
                                  style: AppTextStyle.normalGrey10,
                                ),
                                SizedBox(
                                  height: 1.0.h,
                                ),

                                ////////////////////////////////////////////
                                InkWell(
                                  onTap: () async {
                                    FocusScope.of(context).unfocus();
                                    var agent = await Get.to(
                                        () => PublicBookingAgentList());
                                    if (agent != null) {
                                      bookingRequestController.agentId.value =
                                          agent[1];
                                      bookingRequestController.agentName.value =
                                          agent[0];
                                    }
                                  },
                                  //////////////////////////////////////
                                  child: Container(
                                    width: 100.0.w,
                                    height: 5.0.h,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(246, 248, 249, 1),
                                      borderRadius:
                                          BorderRadius.circular(0.5.h),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 1.5.h, right: 1.5.h),
                                      child: Row(
                                        children: [
                                          Obx(() {
                                            return Text(
                                              bookingRequestController
                                                  .agentName.value,
                                              style: AppTextStyle.normalGrey10,
                                            );
                                          }),
                                          Spacer(),
                                          ClearButton(
                                            clear: () {
                                              bookingRequestController
                                                  .agentId('');
                                              bookingRequestController
                                                      .agentName.value =
                                                  AppMetaLabels().pleaseSelect;
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))),
                  Obx(() {
                    return bookingRequestController.loadingSaveBooking.value
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.all(3.5.h),
                              child: CircularProgressIndicator(
                                color: AppColors.blueColor,
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.all(3.5.h),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(1.3.h),
                                ),
                                backgroundColor: Color.fromRGBO(0, 61, 166, 1),
                              ),
                              onPressed: () async {
                                if (formKey.currentState?.validate() == false) {
                                  return;
                                }
                                FocusScope.of(context).unfocus();
                                var resp = await bookingRequestController
                                    .saveBookingRequestData(
                                        widget.property?.propertyID,
                                        remarksController.text,
                                        widget.property?.unitID,
                                        otherPersonNameController.text,
                                        otherPersonPnoController.text);
                                if (resp != null) {
                                  bookingRequestController.agentName.value =
                                      AppMetaLabels().pleaseSelect;
                                  otherPersonPnoController.clear();
                                  otherPersonNameController.clear();
                                  remarksController.clear();
                                  Get.to(
                                    () => PublicServiceRequestTab(
                                      requestNo: resp ?? 0,
                                      unitId: 123, // not using any where
                                      backToSearch: true,
                                      canCommunicate: true,
                                    ),
                                  );
                                }
                              },
                              child: SizedBox(
                                width: 80.w,
                                height: 6.h,
                                child: Center(
                                  child: Text(
                                    AppMetaLabels().submitRequest,
                                    style: AppTextStyle.semiBoldWhite12,
                                  ),
                                ),
                              ),
                            ),
                          );
                  })
                ],
              ),
            ),
          )),
    );
  }

  Column columnList(String t1, String t2) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t1,
          style: AppTextStyle.normalGrey10,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          height: 0.5.h,
        ),
        // 1122
        Text(
          t2,
          style: AppTextStyle.semiBoldBlack10,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
