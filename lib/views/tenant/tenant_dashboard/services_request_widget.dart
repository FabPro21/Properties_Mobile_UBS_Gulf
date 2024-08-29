// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:fap_properties/utils/styles/text_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// class ServicesRequestWidget extends StatelessWidget {
//   const ServicesRequestWidget({Key? key}) : super(key: key);

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
//                     AppMetaLabels.serviceRequest,
//                     style: AppTextStyle.semiBoldBlack13,
//                   ),
//                   const Spacer(),
//                   Text(
//                     AppMetaLabels.newRequest,
//                     style: AppTextStyle.semiBoldBlue10,
//                   ),
//                 ],
//               ),
//             ),
//            AppDivider(),
//             Padding(
//               padding: EdgeInsets.only(top: 2.0.h, left: 2.0.h, right: 2.0.h),
//               child: Row(
//                 children: [
//                   Text(
//                     AppMetaLabels.newRequestSmall,
//                     style: AppTextStyle.semiBoldBlack10,
//                   ),
//                   const Spacer(),
//                   Text(
//                     "#FG123456",
//                     // AppMetaLabels.newRequestSmall,
//                     style: AppTextStyle.normalBlack9,
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                   top: 1.0.h, left: 2.0.h, right: 2.0.h, bottom: 2.0.h),
//               child: Row(
//                 children: [
//                   Text(
//                     AppMetaLabels.newRequestSmall,
//                     style: AppTextStyle.semiBoldBlack10,
//                   ),
//                   const Spacer(),
//                   Text(
//                     "27 Aug 2021",
//                     // AppMetaLabels.newRequestSmall,
//                     style: AppTextStyle.normalBlack9,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
