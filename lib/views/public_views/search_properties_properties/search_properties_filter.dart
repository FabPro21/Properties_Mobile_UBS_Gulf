// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/utils/styles/text_styles.dart';
// import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';

// class SearchPropertiesFilter extends StatefulWidget {
//   const SearchPropertiesFilter({Key key}) : super(key: key);

//   @override
//   _SearchPropertiesFilterState createState() => _SearchPropertiesFilterState();
// }

// class _SearchPropertiesFilterState extends State<SearchPropertiesFilter> {
//   @override
//   Widget build(BuildContext context) {
//     
//       return Scaffold(
//         body: SafeArea(
//           child: Container(
//             width: 100.0.w,
//             height: 100.0.h,
//             child: Stack(
//               children: [
//                 SingleChildScrollView(
//                   child: Padding(
//                     padding: EdgeInsets.all(2.0.h),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 2.0.h,
//                         ),
//                         Row(
//                           children: [
//                             Text(
//                               "Properties (148)",
//                               style: AppTextStyle.semiBoldBlack16,
//                             ),
//                             Spacer(),
//                             IconButton(
//                               onPressed: () {
//                                 Get.back();
//                               },
//                               icon: Icon(
//                                 Icons.cancel_outlined,
//                                 color: Colors.grey,
//                                 size: 3.5.h,
//                               ),
//                             ),
//                           ],
//                         ),
//                         AppDivider(),
//                         SizedBox(
//                           height: 2.0.h,
//                         ),
//                         Text(
//                           AppMetaLabels().category,
//                           style: AppTextStyle.semiBoldBlack11,
//                         ),
//                         SizedBox(
//                           height: 1.0.h,
//                         ),
//                         InkWell(
//                           onTap: () {
//                             // Get.to(() => TenantServiceType());
//                           },
//                           child: Container(
//                             width: 100.0.w,
//                             height: 5.0.h,
//                             decoration: BoxDecoration(
//                               color: Color.fromRGBO(246, 248, 249, 1),
//                               borderRadius: BorderRadius.circular(0.5.h),
//                             ),
//                             child: Padding(
//                               padding:
//                                   EdgeInsets.only(left: 1.5.h, right: 1.5.h),
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     AppMetaLabels().rent,
//                                     style: AppTextStyle.normalGrey10,
//                                   ),
//                                   Spacer(),
//                                   Icon(
//                                     Icons.arrow_drop_down,
//                                     size: 3.0.h,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 2.0.h,
//                         ),
//                         Text(
//                           AppMetaLabels().invoiceType,
//                           style: AppTextStyle.semiBoldBlack11,
//                         ),
//                         SizedBox(
//                           height: 1.0.h,
//                         ),
//                         InkWell(
//                           onTap: () {
//                             // Get.to(() => TenantServiceType());
//                           },
//                           child: Container(
//                             width: 100.0.w,
//                             height: 5.0.h,
//                             decoration: BoxDecoration(
//                               color: Color.fromRGBO(246, 248, 249, 1),
//                               borderRadius: BorderRadius.circular(0.5.h),
//                             ),
//                             child: Padding(
//                               padding:
//                                   EdgeInsets.only(left: 1.5.h, right: 1.5.h),
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     AppMetaLabels().allTypes,
//                                     style: AppTextStyle.normalGrey10,
//                                   ),
//                                   Spacer(),
//                                   Icon(
//                                     Icons.arrow_drop_down,
//                                     size: 3.0.h,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 2.0.h,
//                         ),
//                         Text(
//                           "Price range (AED)",
//                           style: AppTextStyle.semiBoldBlack11,
//                         ),
//                         SizedBox(
//                           height: 2.0.h,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   AppMetaLabels().from,
//                                   style: AppTextStyle.normalGrey10,
//                                 ),
//                                 SizedBox(
//                                   height: 1.0.h,
//                                 ),
//                                 Container(
//                                   width: 40.0.w,
//                                   height: 5.0.h,
//                                   decoration: BoxDecoration(
//                                     color: Color.fromRGBO(246, 248, 249, 1),
//                                     borderRadius: BorderRadius.circular(0.5.h),
//                                   ),
//                                   child: TextField(
//                                     decoration: new InputDecoration(
//                                         border: InputBorder.none,
//                                         focusedBorder: InputBorder.none,
//                                         enabledBorder: InputBorder.none,
//                                         errorBorder: InputBorder.none,
//                                         disabledBorder: InputBorder.none,
//                                         contentPadding: EdgeInsets.zero),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   AppMetaLabels().to,
//                                   style: AppTextStyle.normalGrey10,
//                                 ),
//                                 SizedBox(
//                                   height: 1.0.h,
//                                 ),
//                                 Container(
//                                   width: 40.0.w,
//                                   height: 5.0.h,
//                                   decoration: BoxDecoration(
//                                     color: Color.fromRGBO(246, 248, 249, 1),
//                                     borderRadius: BorderRadius.circular(0.5.h),
//                                   ),
//                                   child: TextField(
//                                     decoration: new InputDecoration(
//                                         border: InputBorder.none,
//                                         focusedBorder: InputBorder.none,
//                                         enabledBorder: InputBorder.none,
//                                         errorBorder: InputBorder.none,
//                                         disabledBorder: InputBorder.none,
//                                         contentPadding: EdgeInsets.zero),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 2.0.h,
//                         ),
//                         Text(
//                           AppMetaLabels().propertyType,
//                           style: AppTextStyle.semiBoldBlack11,
//                         ),
//                         SizedBox(
//                           height: 1.0.h,
//                         ),
//                         InkWell(
//                           onTap: () {
//                             // Get.to(() => TenantServiceType());
//                           },
//                           child: Container(
//                             width: 100.0.w,
//                             height: 5.0.h,
//                             decoration: BoxDecoration(
//                               color: Color.fromRGBO(246, 248, 249, 1),
//                               borderRadius: BorderRadius.circular(0.5.h),
//                             ),
//                             child: Padding(
//                               padding:
//                                   EdgeInsets.only(left: 1.5.h, right: 1.5.h),
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     AppMetaLabels().villa,
//                                     style: AppTextStyle.normalGrey10,
//                                   ),
//                                   Spacer(),
//                                   Icon(
//                                     Icons.arrow_drop_down,
//                                     size: 3.0.h,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 2.0.h,
//                         ),
//                         Text(
//                           AppMetaLabels().bedRooms,
//                           style: AppTextStyle.semiBoldBlack11,
//                         ),
//                         SizedBox(
//                           height: 1.0.h,
//                         ),
//                         InkWell(
//                           onTap: () {
//                             // Get.to(() => TenantServiceType());
//                           },
//                           child: Container(
//                             width: 100.0.w,
//                             height: 5.0.h,
//                             decoration: BoxDecoration(
//                               color: Color.fromRGBO(246, 248, 249, 1),
//                               borderRadius: BorderRadius.circular(0.5.h),
//                             ),
//                             child: Padding(
//                               padding:
//                                   EdgeInsets.only(left: 1.5.h, right: 1.5.h),
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     "4",
//                                     style: AppTextStyle.normalGrey10,
//                                   ),
//                                   Spacer(),
//                                   Icon(
//                                     Icons.arrow_drop_down,
//                                     size: 3.0.h,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 2.0.h,
//                         ),
//                         Text(
//                           "Area range (Sqft)",
//                           style: AppTextStyle.semiBoldBlack11,
//                         ),
//                         SizedBox(
//                           height: 2.0.h,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   AppMetaLabels().from,
//                                   style: AppTextStyle.normalGrey10,
//                                 ),
//                                 SizedBox(
//                                   height: 1.0.h,
//                                 ),
//                                 Container(
//                                   width: 40.0.w,
//                                   height: 5.0.h,
//                                   decoration: BoxDecoration(
//                                     color: Color.fromRGBO(246, 248, 249, 1),
//                                     borderRadius: BorderRadius.circular(0.5.h),
//                                   ),
//                                   child: TextField(
//                                     decoration: new InputDecoration(
//                                         border: InputBorder.none,
//                                         focusedBorder: InputBorder.none,
//                                         enabledBorder: InputBorder.none,
//                                         errorBorder: InputBorder.none,
//                                         disabledBorder: InputBorder.none,
//                                         contentPadding: EdgeInsets.zero),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   AppMetaLabels().to,
//                                   style: AppTextStyle.normalGrey10,
//                                 ),
//                                 SizedBox(
//                                   height: 1.0.h,
//                                 ),
//                                 Container(
//                                   width: 40.0.w,
//                                   height: 5.0.h,
//                                   decoration: BoxDecoration(
//                                     color: Color.fromRGBO(246, 248, 249, 1),
//                                     borderRadius: BorderRadius.circular(0.5.h),
//                                   ),
//                                   child: TextField(
//                                     decoration: new InputDecoration(
//                                         border: InputBorder.none,
//                                         focusedBorder: InputBorder.none,
//                                         enabledBorder: InputBorder.none,
//                                         errorBorder: InputBorder.none,
//                                         disabledBorder: InputBorder.none,
//                                         contentPadding: EdgeInsets.zero),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 2.0.h,
//                         ),
//                         Text(
//                           AppMetaLabels().payments,
//                           style: AppTextStyle.semiBoldBlack11,
//                         ),
//                         SizedBox(
//                           height: 1.0.h,
//                         ),
//                         InkWell(
//                           onTap: () {
//                             // Get.to(() => TenantServiceType());
//                           },
//                           child: Container(
//                             width: 100.0.w,
//                             height: 5.0.h,
//                             decoration: BoxDecoration(
//                               color: Color.fromRGBO(246, 248, 249, 1),
//                               borderRadius: BorderRadius.circular(0.5.h),
//                             ),
//                             child: Padding(
//                               padding:
//                                   EdgeInsets.only(left: 1.5.h, right: 1.5.h),
//                               child: Row(
//                                 children: [
//                                   Text(
//                                     AppMetaLabels().monthly,
//                                     style: AppTextStyle.normalGrey10,
//                                   ),
//                                   Spacer(),
//                                   Icon(
//                                     Icons.arrow_drop_down,
//                                     size: 3.0.h,
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           height: 2.0.h,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: InkWell(
//                     onTap: () {
//                       // Get.to(() => SearchPropertiesMaps());
//                       Get.back();
//                     },
//                     child: Container(
//                       height: 6.0.h,
//                       width: 30.0.w,
//                       decoration: BoxDecoration(
//                           color: Color.fromRGBO(0, 98, 255, 1),
//                           borderRadius: BorderRadius.circular(100.0.h)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.format_align_center,
//                             size: 2.5.h,
//                             color: Colors.white,
//                           ),
//                           Text(
//                             AppMetaLabels().apply,
//                             style: AppTextStyle.normalWhite12,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
