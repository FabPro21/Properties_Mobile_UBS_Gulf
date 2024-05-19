// import 'package:fap_properties/utils/styles/colors.dart';
// import 'package:fap_properties/utils/styles/text_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// class CustomNavBar2 extends StatelessWidget {
//   final Function(int) onTap;
//   final int selected;
//   const CustomNavBar2({
//     Key key, this.onTap, this.selected,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 8.8.h,
//       decoration: BoxDecoration(color: Colors.white,boxShadow: [BoxShadow(color: Colors.black26,spreadRadius: 3, blurRadius: 5, offset: Offset(0,3))]),
//       child: Stack(
//         children: [
//           Container(
//             color: AppColors.darkGreyColor,
//             height: 0.2.h,
//             width: double.infinity,
//             margin: EdgeInsets.only(top: 0.1.h),
//           ),
//           Row(
//             children: [
//               NavBarItem(title: 'UNIT INFO', position: 0, selected: selected,onTap: (pos){onTap(pos);},),
//               NavBarItem(title: "LPO'S SERVICES", position: 1, selected: selected,onTap: (pos){onTap(pos);},),
//               NavBarItem(title: "LPO'S TERMS", position: 2, selected: selected,onTap: (pos){onTap(pos);},)
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

// class NavBarItem extends StatelessWidget {
//   final int selected;
//   final int position;
//   final String title;
//   final Function(int) onTap;
//   const NavBarItem({
//     Key key, this.title, this.onTap, this.selected, this.position,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(child: Container(
//       child: InkWell(
//         onTap: (){onTap(position);},
//         child: Column(
//           children: [
//             selected==position?Container(
//               width: double.infinity,
//               height: 0.4.h,
//               color: AppColors.blueColor,
//             ):SizedBox(height: 0.4.h,),
//             Padding(
//               padding: EdgeInsets.symmetric(vertical: 3.h),
//               child: Text(title??'', style:selected==position?AppTextStyle.semiBoldBlue10:AppTextStyle.semiBoldBlack10),
//             )
//           ],
//         ),
//       ),
//     ));
//   }
// }