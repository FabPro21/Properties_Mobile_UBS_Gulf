import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomNavBar extends StatelessWidget {
  final List<Widget> items;
  CustomNavBar({
    Key key,
    @required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.only(top: 1.0.h, bottom: 1.0.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1.0.h,
            spreadRadius: 0.1.h,
            offset: Offset(0, -10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: items,
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  final Function(int) onTap;
  final int position;
  final String title;
  final String icon;
  const NavBarItem({
    Key key,
    @required this.onTap,
    @required this.position,
    @required this.title,
    @required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(position);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon == "IconBlue"
              ? SizedBox(
                  height: 5.h,
                  width: 5.h,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.blueColor.withOpacity(0.45),
                    child: Icon(
                      Icons.tag,
                      size: 3.2.h,
                      color: AppColors.whiteColor,
                    ),
                  ),
                )
              : icon == "IconGrey"
                  ? SizedBox(
                      height: 5.h,
                      width: 5.h,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.tag,
                          size: 3.2.h,
                          color: AppColors.grey1,
                        ),
                      ),
                    )
                  : Image.asset(
                      icon,
                      height: 5.h,
                      width: 5.h,
                      fit: BoxFit.contain,
                    ),
          SizedBox(
            height: 1.h,
          ),
          Text(title, style: AppTextStyle.normalBlack10)
        ],
      ),
    );
  }
}
