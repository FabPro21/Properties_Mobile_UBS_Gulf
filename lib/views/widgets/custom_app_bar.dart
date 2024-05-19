import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  final String searchHint;
  final TextEditingController searchTextController;
  final Function(String) onSearchTextChanged;
  final Function onRefreshPressed;
  const CustomAppBar({
    Key key,
    @required this.title,
    this.searchHint,
    this.onSearchTextChanged,
    this.onRefreshPressed,
    this.searchTextController,
  }) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Image.asset(
            AppImagesPath.concave,
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(3.w, 8.h, 3.w, 4.h),
                child: Text(widget.title, style: AppTextStyle.semiBoldWhite12),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: SearchField(
                  hint: widget.searchHint,
                  searchController: widget.searchTextController,
                  onChanged: widget.onSearchTextChanged,
                  onPressed: widget.onRefreshPressed,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
