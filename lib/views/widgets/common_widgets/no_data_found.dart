import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:flutter/material.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            AppMetaLabels().noDatafound,
          ),
        ],
      ),
    );
  }
}
