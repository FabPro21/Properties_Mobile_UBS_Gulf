import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerClass {
  // if (!await Permission.storage.request().isGranted) {
  //   print('Else');
  //   await permissions(
  //     'Storage',
  //     context,
  //   );
  //   return;
  // }

  // show fron and back side of image
  permissions(String source, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Directionality(
            textDirection: SessionController().getLanguage() == 1
                ? ui.TextDirection.ltr
                : ui.TextDirection.rtl,
            child: AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                contentPadding:
                    const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 15),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Text(
                          '${AppMetaLabels().colliersPropertiesSource} $source',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.semiBoldBlack11),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const AppDivider(),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: ElevatedButton(
                        child: const Text('Allow access'),
                        onPressed: () => openAppSettings(),
                      ),
                    ),
                  ],
                )),
          );
        });
  }
}
