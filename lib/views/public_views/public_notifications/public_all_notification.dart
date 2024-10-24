import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/fonts.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/public_views/public_notifications/public_notification_controller.dart';
import 'package:fap_properties/views/public_views/public_notifications/public_notification_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PublicAllNotifications extends StatefulWidget {
  const PublicAllNotifications({Key? key}) : super(key: key);

  @override
  _PublicAllNotificationsState createState() => _PublicAllNotificationsState();
}

class _PublicAllNotificationsState extends State<PublicAllNotifications> {
  var _controller = Get.find<PublicNotificationsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: _controller.loadingData.value
          ? LoadingIndicatorBlue()
          : _controller.error.value != '' || _controller.allLength == 0
              ? CustomErrorWidget(
                  errorImage: AppImagesPath.noServicesFound,
                  errorText: _controller.error.value,
                )
              : Padding(
                  padding: EdgeInsets.all(2.0.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(1.0.h),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 0.5.h,
                          spreadRadius: 0.3.h,
                          offset: Offset(0.1.h, 0.1.h),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              // shrinkWrap: true,
                              itemCount: _controller.allLength,
                              itemBuilder: (context, int index) {
                                return InkWell(
                                  onTap: () async {
                                    SessionController().setNotificationId(
                                        _controller.notifications![index]
                                            .notificationId
                                            .toString());
                                    if (_controller
                                            .notifications![index].isRead !=
                                        true) {
                                      _controller.loadingData.value = true;
                                      var res =
                                          await _controller.readNotifications();
                                      if (res) {
                                        _controller.notifications![index]
                                            .isRead = true;
                                      }
                                      _controller.loadingData.value = false;
                                    }
                                    Get.to(() => PublicNotificationDetails());
                                  },
                                  child: Row(
                                    children: [
                                      _controller.editTap.value == true
                                          ? Expanded(
                                              child: Container(
                                                width: 10.0.w,
                                                height: 5.0.h,
                                                child: CheckboxListTile(
                                                  selectedTileColor:
                                                      Color.fromRGBO(
                                                          0, 98, 255, 1),
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  value: _controller
                                                      .isChecked![index],
                                                  onChanged: (val) {
                                                    setState(
                                                      () {
                                                        _controller.isChecked![
                                                            index] = val!;
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      slideable(index),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        Center(
                          child: Obx(() {
                            return _controller.noMoreDataPageAll.value != ''
                                ? Text(
                                    AppMetaLabels().noMoreData,
                                    style: AppTextStyle.semiBoldBlue14,
                                  )
                                : _controller.isLoadingAllNotification.value
                                    ? SizedBox(
                                        width: 75.w,
                                        height: 5.h,
                                        child: Center(
                                          child: LoadingIndicatorBlue(),
                                        ),
                                      )
                                    : InkWell(
                                        onTap: () async {
                                          int pageSize =
                                              int.parse(_controller.pagaNoPAll);
                                          int naePageNo = pageSize + 1;
                                          _controller.pagaNoPAll =
                                              naePageNo.toString();
                                          await _controller.getNotifications1(
                                              _controller.pagaNoPAll
                                                  .toString());
                                          setState(() {});
                                        },
                                        child: SizedBox(
                                            width: 75.w,
                                            height: 3.h,
                                            child: RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: AppMetaLabels()
                                                        .loadMoreData,
                                                    style:
                                                        AppTextStyle.boldBlue,
                                                  ),
                                                  WidgetSpan(
                                                    child: Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 15,
                                                      color:
                                                          AppColors.blueColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      );
                          }),
                        ),
                        SizedBox(
                          height: 1.0.h,
                        ),
                      ],
                    ),
                  ),
                  //             );
                  // }
                ),
    );
  }

  Slidable slideable(int index) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(), // Use DrawerMotion for the sliding effect
        children: [
          SlidableAction(
            backgroundColor: Colors.grey[200] ?? Colors.grey,
            foregroundColor: Colors.black,
            icon: Icons.check_circle_outline,
            // color: Colors.blue,
            onPressed: (context) async {
              SessionController().setNotificationId(
                  _controller.notifications![index].notificationId.toString());

              if (_controller.notifications![index].isRead != true) {
                _controller.loadingData.value = true;
                var res = await _controller.readNotifications();
                if (res) {
                  _controller.notifications![index].isRead = true;
                }
                _controller.loadingData.value = false;
              }
            },
            borderRadius: BorderRadius.circular(8.0),
            spacing: 8.0,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(), // Use DrawerMotion for the sliding effect
        children: [
          SlidableAction(
            backgroundColor: Colors.grey[200] ?? Colors.grey,
            foregroundColor: Colors.black,
            icon: Icons.archive,
            // color: Color.fromRGBO(255, 179, 0, 1),
            onPressed: (context) async {
              SessionController().setNotificationId(
                  _controller.notifications![index].notificationId.toString());

              await _controller.archiveNotifications();
              // Update state to reflect changes
              setState(() {
                _controller.allLength = _controller.allLength - 1;
                _controller.notifications!.removeAt(index);
              });
            },
            borderRadius: BorderRadius.circular(8.0),
            spacing: 8.0,
          ),
        ],
      ),
      child: Container(
        width: _controller.editTap.value == true ? 80.0.w : 90.0.w,
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _controller.notifications![index].isRead == true
                      ? Container()
                      : Container(
                          height: 1.0.h,
                          width: 2.0.w,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.only(left: 1.0.h),
                    child: Container(
                      width:
                          _controller.editTap.value == true ? 30.0.w : 60.0.w,
                      child: Text(
                        SessionController().getLanguage() == 1
                            ? _controller.notifications![index].title.toString()
                            : _controller.notifications![index].titleAR
                                .toString(),
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.semiBoldBlack11,
                      ),
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.more_horiz),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.6.w),
                child: Html(
                  data: SessionController().getLanguage() == 1
                      ? _controller.notifications![index].description.toString()
                      : _controller.notifications![index].descriptionAR
                          .toString(),
                  style: {
                    'html': Style(
                      textAlign: SessionController().getLanguage() == 1
                          ? TextAlign.left
                          : TextAlign.right,
                      color: Colors.black,
                      fontFamily: AppFonts.graphikRegular,
                      fontSize: FontSize(10.0),
                    ),
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 1.8.h, top: 1.0.h),
                child: Container(
                  child: Text(
                    _controller.notifications![index].createdOn ?? "",
                    style: AppTextStyle.normalBlack10,
                  ),
                ),
              ),
              SizedBox(
                height: 2.0.h,
              ),
              index == _controller.allLength - 1 ? Container() : AppDivider(),
            ],
          ),
        ),
      ),
    );
    // Slidable(
    //   actions: <Widget>[
    //     SlideAction(
    //       color: Colors.grey[200],
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         children: [
    //           Container(
    //             decoration: BoxDecoration(
    //               color: Colors.blue,
    //               shape: BoxShape.circle,
    //             ),
    //             child: Padding(
    //               padding: EdgeInsets.all(1.0.h),
    //               child: Icon(
    //                 Icons.check_circle_outline,
    //                 color: Colors.white,
    //                 size: 3.0.h,
    //               ),
    //             ),
    //           ),
    //           Text(
    //             AppMetaLabels().markAsRead,
    //             style: AppTextStyle.semiBoldBlue8,
    //           )
    //         ],
    //       ),
    //       //not defined closeOnTap so list will get closed when clicked
    //       onTap: () async {
    //         SessionController().setNotificationId(
    //             _controller.notifications![index].notificationId.toString());

    //         if (_controller.notifications![index].isRead != true) {
    //           _controller.loadingData.value = true;
    //           var res = await _controller.readNotifications();
    //           if (res) {
    //             _controller.notifications![index].isRead = true;
    //           }
    //           _controller.loadingData.value = false;
    //         }
    //       },
    //     ),
    //   ],
    //   secondaryActions: <Widget>[
    //     SlideAction(
    //         color: Colors.grey[200],
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             Container(
    //               decoration: BoxDecoration(
    //                 color: Color.fromRGBO(255, 179, 0, 1),
    //                 shape: BoxShape.circle,
    //               ),
    //               child: Padding(
    //                 padding: EdgeInsets.all(1.0.h),
    //                 child: Icon(
    //                   Icons.archive,
    //                   color: Colors.white,
    //                   size: 3.0.h,
    //                 ),
    //               ),
    //             ),
    //             Text(
    //               AppMetaLabels().archive,
    //               style: AppTextStyle.semiBoldBlue8
    //                   .copyWith(color: Color.fromRGBO(255, 179, 0, 1)),
    //             )
    //           ],
    //         ),
    //         //not defined closeOnTap so list will get closed when clicked
    //         onTap: () async {
    //           SessionController().setNotificationId(
    //               _controller.notifications![index].notificationId.toString());

    //           await _controller.archiveNotifications();
    //           setState(() {
    //             _controller.allLength = _controller.allLength - 1;
    //             _controller.notifications!.removeAt(index);
    //           });
    //         }),
    //   ],
    //   child: Container(
    //     width: _controller.editTap.value == true ? 80.0.w : 90.0.w,
    //     child: ListTile(
    //       title: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Row(
    //             children: [
    //               _controller.notifications![index].isRead == true
    //                   ? Container()
    //                   : Container(
    //                       height: 1.0.h,
    //                       width: 2.0.w,
    //                       decoration: BoxDecoration(
    //                         color: Colors.red,
    //                         shape: BoxShape.circle,
    //                       ),
    //                     ),
    //               Padding(
    //                 padding: EdgeInsets.only(left: 1.0.h),
    //                 child: Container(
    //                   // color: Colors.green,
    //                   width:
    //                       _controller.editTap.value == true ? 30.0.w : 60.0.w,
    //                   child: Text(
    //                     SessionController().getLanguage() == 1
    //                         ? _controller.notifications![index].title
    //                                 .toString()
    //                         : _controller.notifications![index].titleAR
    //                                 .toString(),
    //                     overflow: TextOverflow.ellipsis,
    //                     style: AppTextStyle.semiBoldBlack11,
    //                   ),
    //                 ),
    //               ),
    //               Spacer(),
    //               Icon(Icons.more_horiz),
    //             ],
    //           ),
    //           // public notification description
    //           Padding(
    //             padding: EdgeInsets.symmetric(horizontal: 1.6.w),
    //             child: Html(
    //               data: SessionController().getLanguage() == 1
    //                   ? _controller.notifications![index].description
    //                           .toString()
    //                   : _controller.notifications![index].descriptionAR
    //                       .toString(),
    //               style: {
    //                 'html': Style(
    //                   textAlign: SessionController().getLanguage() == 1
    //                       ? TextAlign.left
    //                       : TextAlign.right,
    //                   color: Colors.black,
    //                   fontFamily: AppFonts.graphikRegular,
    //                   fontSize: FontSize(10.0),
    //                 ),
    //               },
    //             ),
    //           ),
    //           Padding(
    //             padding: EdgeInsets.only(left: 1.8.h, top: 1.0.h),
    //             child: Container(
    //               child: Text(
    //                 _controller.notifications![index].createdOn ?? "",
    //                 style: AppTextStyle.normalBlack10,
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 2.0.h,
    //           ),
    //           index == _controller.allLength - 1 ? Container() : AppDivider(),
    //         ],
    //       ),
    //     ),
    //   ),
    //   actionPane: SlidableDrawerActionPane(),
    // );
  }
}
