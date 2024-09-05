import 'package:fap_properties/views/widgets/srno_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../utils/styles/colors.dart';

class StepNoWidget extends StatelessWidget {
  final String? label;
  final String? tooltip;
  final Color? color;
  final Color? textColor;
  StepNoWidget({
    Key? key,
    this.label,
    this.tooltip,
    this.color = Colors.black12,
    this.textColor,
  }) : super(key: key);

  final GlobalKey _toolTipKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      key: _toolTipKey,
      message: tooltip,
      showDuration: Duration(seconds: 3),
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
          color: AppColors.chartBlueColor,
          borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: () {
          final dynamic _toolTip = _toolTipKey.currentState;
          _toolTip.ensureTooltipVisible();
        },
        child: SrNoWidget(
          size: 20.sp,
          text: label,
          background: color,
          textColor: textColor,
        ),
      ),
    );
  }
}
