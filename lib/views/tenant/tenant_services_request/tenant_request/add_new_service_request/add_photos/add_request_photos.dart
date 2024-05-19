import 'dart:typed_data';

import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request/tenant_request_list/tenant_request_list_controller.dart';
import 'package:fap_properties/views/tenant/tenant_services_request/tenant_request_details/tenant_service_request_tab/tenant_service_request_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:zoom_pinch_overlay/zoom_pinch_overlay.dart';
import 'add_request_photos_controller.dart';
import 'dart:ui' as ui;

class AddRequestPhotos extends StatefulWidget {
  final String caseNo;
  AddRequestPhotos({Key key, this.caseNo}) : super(key: key);

  @override
  State<AddRequestPhotos> createState() => _AddRequestPhotosState();
}

class _AddRequestPhotosState extends State<AddRequestPhotos> {
  final controller = Get.put(AddRequestPhotosController());

  @override
  initState() {
    controller.caseNo = widget.caseNo;
    print('Case No :::::: ${widget.caseNo}');
    print('Case No :::::: ${controller.caseNo}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: SessionController().getLanguage() == 1
          ? ui.TextDirection.ltr
          : ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            iconSize: 2.0.h,
            onPressed: () {
              var reqListController =
                  Get.find<GetTenantServiceRequestsController>();
              reqListController.getData();
              Get.back();
            },
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(
                  AppImagesPath.appbarimg,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          backgroundColor: Colors.white,
          title: Text(
            AppMetaLabels().newRequestSmall,
            style: AppTextStyle.semiBoldWhite14,
          ),
        ),
        // 112233 upload service request file from tenant Add service
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(2.0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                    AppMetaLabels().uploadPhotos,
                    style: AppTextStyle.semiBoldGrey12,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 2.h),
                    padding: EdgeInsets.all(2.0.h),
                    width: 100.0.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(2.0.h),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 0.5.h,
                          spreadRadius: 0.1.h,
                          offset: Offset(0.1.h, 0.1.h),
                        ),
                      ],
                    ),
                    child: Obx(() {
                      return controller.addingPhoto.value
                          ? Container(
                              height: 9.h,
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(0.5.h),
                              child: LoadingIndicatorBlue(),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 25.w,
                                      childAspectRatio: 3 / 2,
                                      crossAxisSpacing: 1.w,
                                      mainAxisSpacing: 1.w),
                              itemCount: controller.photos.length,
                              itemBuilder: (BuildContext ctx, index) {
                                return showImage(context, index);
                              });
                    }),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: 100.0.w,
              height: 13.0.h,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 0.5.h,
                    spreadRadius: 0.5.h,
                    offset: Offset(0.1.h, 0.1.h),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(3.5.h),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1.3.h),
                    ),
                    backgroundColor: Color.fromRGBO(0, 61, 166, 1),
                  ),
                  onPressed: () {
                    Get.snackbar(
                      AppMetaLabels().success,
                      AppMetaLabels().reqScuccesful,
                      backgroundColor: AppColors.white54,
                    );
                    Get.off(() => TenantServiceRequestTabs(
                          caller: 'newReq',
                          requestNo: widget.caseNo,
                        ));
                  },
                  child: Text(
                    AppMetaLabels().submitRequest,
                    style: AppTextStyle.semiBoldWhite12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPicker(context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Directionality(
              textDirection: SessionController().getLanguage() == 1
                  ? ui.TextDirection.ltr
                  : ui.TextDirection.rtl,
              child: Container(
                color: Colors.white,
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: new Text(AppMetaLabels().photoLibrary),
                        onTap: () {
                          controller.pickPhoto(ImageSource.gallery);
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                      leading: new Icon(Icons.photo_camera),
                      title: new Text(AppMetaLabels().camera),
                      onTap: () {
                        controller.pickPhoto(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  InkWell showImage(BuildContext context, int index) {
    return InkWell(
      onTap: controller.photos[index] == null
          ? () {
              _showPicker(context, index);
            }
          : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(1.h),
        child: Container(
          color: Color.fromRGBO(246, 248, 249, 1),
          child: controller.photos[index] != null
              ? Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        showBigImage(context, controller.photos[index].file);
                      },
                      child: Image.memory(
                        controller.photos[index].file,
                        width: 20.0.w,
                        height: 9.0.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Obx(() {
                      return controller.photos[index].uploading.value ||
                              controller.photos[index].errorUploading
                          ? Container(
                              color: Color.fromRGBO(255, 255, 255, 0.5),
                              alignment: Alignment.center,
                              child: controller.photos[index].uploading.value
                                  ? LoadingIndicatorBlue(
                                      size: 20,
                                    )
                                  : controller.photos[index].errorUploading
                                      ? IconButton(
                                          onPressed: () {
                                            controller.uploadPhoto(index);
                                          },
                                          icon: Icon(
                                            Icons.refresh_outlined,
                                            color: Colors.red,
                                          ),
                                        )
                                      : null)
                          : InkWell(
                              onTap: () {
                                _showDeletePhotoOptions(context, index);
                              },
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(255, 255, 255, 0.5),
                                    borderRadius: BorderRadius.circular(24)),
                                padding: EdgeInsets.all(2),
                                child: controller.photos[index].removing.value
                                    ? LoadingIndicatorBlue()
                                    : Icon(
                                        controller.photos[index].errorRemoving
                                            ? Icons.refresh_outlined
                                            : Icons.cancel_outlined,
                                        color: Colors.red),
                              ),
                            );
                    }),
                  ],
                )
              : Center(
                  child: Text(
                    "+",
                    style: AppTextStyle.semiBoldWhite16
                        .copyWith(color: Color.fromRGBO(180, 180, 180, 1)),
                  ),
                ),
        ),
      ),
    );
  }

  void _showDeletePhotoOptions(context, index) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(12),
              child: Wrap(
                children: <Widget>[
                  Text(
                    AppMetaLabels().wantremovephoto,
                    // 'Do you want to remove photo?',
                    style: AppTextStyle.normalBlack12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 3.h, horizontal: 2.5.w),
                        height: 5.h,
                        width: 40.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1.3.h),
                            ),
                            backgroundColor: Color.fromRGBO(255, 36, 27, 1),
                          ),
                          onPressed: () {
                            controller.removePhoto(index);
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppMetaLabels().remove,
                            // 'Remove',
                            style: AppTextStyle.semiBoldWhite10,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 3.h, horizontal: 2.5.w),
                        height: 5.h,
                        width: 40.w,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1.3.h),
                            ),
                            backgroundColor: AppColors.blueColor,
                          ),
                          child: Text(
                            AppMetaLabels().cancel,
                            style: AppTextStyle.semiBoldWhite10,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  showBigImage(BuildContext context, Uint8List image) {
    showDialog(
        context: context,
        builder: (context) {
          return Material(
            child: Center(
              child: Stack(
                children: [
                  ZoomOverlay(
                      minScale: 0.5, // Optional
                      maxScale: 3.0, // Optional
                      twoTouchOnly: true, // Defaults to false
                      child: Image.memory(image)),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.cancel))
                ],
              ),
            ),
          );
        });
  }
}
