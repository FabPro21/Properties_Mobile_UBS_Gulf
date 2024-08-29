import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchField extends StatefulWidget {
  final TextEditingController? searchController;
  final Function(String)? onChanged;
  final VoidCallback? onPressed;
  final String? hint;
  const SearchField({
    Key? key,
    this.searchController,
    this.onChanged,
    this.onPressed,
    this.hint = '',
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1.0.h),
      ),
      child: Padding(
        padding: EdgeInsets.all(0.3.h),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: widget.searchController,
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.withOpacity(0.1),
                  prefixIcon: Icon(
                    Icons.search,
                    size: 2.0.h,
                    color: Colors.grey,
                  ),
                  contentPadding: EdgeInsets.only(left: 5.0.w),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.5.h),
                    borderSide:
                        BorderSide(color: AppColors.whiteColor, width: 0.1.h),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.5.h),
                    borderSide:
                        BorderSide(color: AppColors.whiteColor, width: 0.1.h),
                  ),
                  hintText: widget.hint,
                  hintStyle:
                      AppTextStyle.normalBlack10.copyWith(color: Colors.grey),
                ),
              ),
            ),
            IconButton(
              onPressed: widget.onPressed,
              icon: Icon(
                Icons.refresh,
              ),
            )
          ],
        ),
      ),
    );
  }
}
