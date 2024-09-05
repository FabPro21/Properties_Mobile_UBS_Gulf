// import 'package:fap_properties/utils/constants/assets_path.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/utils/styles/text_styles.dart';
// import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// class YourContracts extends StatelessWidget {
//   const YourContracts({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 0.0.h, vertical: 1.0.h),
//       child: Container(
//         // height: 31.0.h,
//         width: 94.0.w,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(1.0.h),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 0.5.h,
//               spreadRadius: 0.3.h,
//               offset: Offset(0.1.h, 0.1.h),
//             ),
//           ],
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 2.0.h, vertical: 2.0.h),
//               child: Row(
//                 children: [
//                   Text(
//                     AppMetaLabels().yourContracts,
//                     style: AppTextStyle.semiBoldBlack13,
//                   ),
//                   const Spacer(),
//                   Text(
//                     AppMetaLabels().manage,
//                     style: AppTextStyle.semiBoldBlue10,
//                   ),
//                 ],
//               ),
//             ),
//             AppDivider(),
//             ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: 2,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 1.0.h, vertical: 1.0.h),
//                         child: Row(
//                           children: [
//                             SizedBox(
//                               width: 25.0.w,
//                               height: 13.0.h,
//                               child: Image.asset(
//                                 AppImagesPath.building1,
//                                 fit: BoxFit.fill,
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 1.0.h, vertical: 0.0.h),
//                               child: SizedBox(
//                                 // color: Colors.red,
//                                 height: 12.0.h,
//                                 child: Column(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceAround,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         SizedBox(
//                                           width: 40.0.w,
//                                           // color: Colors.green,
//                                           child: Text(
//                                             "Discovery Gardens",
//                                             style: AppTextStyle.semiBoldBlack11,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ),
//                                         // const Spacer(),
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 7.0.w),
//                                           child: Text(
//                                             "Unit #12",
//                                             style: AppTextStyle.normalBlack9,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     Text(
//                                       "02 Jan 2021 -> 01 Jan 2022",
//                                       style: AppTextStyle.normalBlack9,
//                                     ),
//                                     Container(
//                                       color: Colors.grey.withOpacity(0.2),
//                                       child: Padding(
//                                         padding: EdgeInsets.symmetric(
//                                             horizontal: 1.0.h, vertical: 1.0.h),
//                                         child: Text(
//                                           "#1234G09876",
//                                           style: AppTextStyle.semiBoldBlack8,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                       index == 2 - 1 ? Container() : AppDivider(),
//                     ],
//                   );
//                 }),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 0.7.h),
//               child: TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   AppMetaLabels().viewAllContracts,
//                   style: AppTextStyle.semiBoldBlue10,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
