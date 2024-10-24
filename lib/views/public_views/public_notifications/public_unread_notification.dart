import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/fonts.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/custom_error_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'public_notification_controller.dart';
import 'public_notification_details.dart';

class PublicUnreadNotification extends StatefulWidget {
  const PublicUnreadNotification({Key? key}) : super(key: key);

  @override
  _PublicUnreadNotificationState createState() =>
      _PublicUnreadNotificationState();
}

class _PublicUnreadNotificationState extends State<PublicUnreadNotification> {
  var _controller = Get.find<PublicNotificationsController>();
  _getUnreadNotifications() async {
    await _controller.unReadNotifications(_controller.pagaNoPURead);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.noMoreDataUnRead.value == '') {
        _getUnreadNotifications();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Obx(() {
        return _controller.unreadNotificationsLoading.value
            ? LoadingIndicatorBlue()
            : _controller.errorUnread.value != '' ||
                    _controller.unreadLength == 0
                ? CustomErrorWidget(
                    errorImage: AppImagesPath.noServicesFound,
                    errorText: _controller.errorUnread.value,
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
                                itemCount: _controller.unreadLength,
                                itemBuilder: (context, int index) {
                                  return InkWell(
                                    onTap: () async {
                                      SessionController().setNotificationId(
                                          _controller
                                              .notificationsUnRead![index]
                                              .notificationId
                                              .toString());
                                      if (_controller
                                              .notificationsUnRead![index]
                                              .isRead !=
                                          true) {
                                        _controller.unreadNotificationsLoading
                                            .value = true;
                                        var res = await _controller
                                            .readNotifications();
                                        if (res) {
                                          setState(() {
                                            setState(() {
                                              _controller.notificationsUnRead!
                                                  .removeAt(index);
                                              _controller.unreadLength =
                                                  _controller.unreadLength - 1;
                                            });
                                          });
                                        }
                                      }
                                      Get.to(() => PublicNotificationDetails());
                                      _controller.unreadNotificationsLoading
                                          .value = false;
                                      _getUnreadNotifications();
                                    },
                                    child: Row(
                                      // getTNController.  editTap.value == true ? 80.0.w :
                                      children: [
                                        slideable(index),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          SizedBox(
                            height: 1.0.h,
                          ),
                          Center(
                            child: Obx(() {
                              return _controller.noMoreDataUnRead.value != ''
                                  ? Text(
                                      AppMetaLabels().noMoreData,
                                      style: AppTextStyle.boldBlue,
                                    )
                                  : _controller
                                          .isLoadingUnReadNotification.value
                                      ? SizedBox(
                                          width: 75.w,
                                          height: 5.h,
                                          child: Center(
                                            child: LoadingIndicatorBlue(),
                                          ),
                                        )
                                      : InkWell(
                                          onTap: () async {
                                            int pageSize = int.parse(
                                                _controller.pagaNoPURead);
                                            int naePageNo = pageSize + 1;
                                            _controller.pagaNoPURead =
                                                naePageNo.toString();
                                            await _controller
                                                .unReadNotifications1(
                                                    _controller.pagaNoPURead
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
                  );
      }),
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
            onPressed: (context) async {
              SessionController().setNotificationId(_controller
                  .notificationsUnRead![index].notificationId
                  .toString());

              if (_controller.notificationsUnRead![index].isRead != true) {
                _controller.unreadNotificationsLoading.value = true;
                var res = await _controller.readNotifications();
                if (res) {
                  setState(() {
                    _controller.notificationsUnRead!.removeAt(index);
                    _controller.unreadLength = _controller.unreadLength - 1;
                  });
                  if (_controller.notificationsUnRead!.isEmpty) {
                    _getUnreadNotifications();
                    print('Calling to fetch new notifications');
                  } else {
                    print('Not calling to fetch new notifications');
                  }
                }
                _controller.unreadNotificationsLoading.value = false;
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
            onPressed: (context) {
              setState(() {
                _controller.unreadLength = _controller.unreadLength - 1;
                _controller.notificationsUnRead!.removeAt(index);
              });
            },
            borderRadius: BorderRadius.circular(8.0),
            spacing: 8.0,
          ),
        ],
      ),
      child: Container(
        width: 90.0.w,
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _controller.notificationsUnRead![index].isRead == true
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
                            ? _controller.notificationsUnRead![index].title
                                .toString()
                            : _controller.notificationsUnRead![index].titleAR
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
                padding: EdgeInsets.symmetric(horizontal: 3.0.w),
                child: Html(
                  data: SessionController().getLanguage() == 1
                      ? _controller.notificationsUnRead![index].description
                          .toString()
                      : _controller.notificationsUnRead![index].descriptionAR
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
                    _controller.notificationsUnRead![index].createdOn ?? "",
                    style: AppTextStyle.normalBlack10,
                  ),
                ),
              ),
              SizedBox(
                height: 2.0.h,
              ),
              index == _controller.unreadLength - 1
                  ? Container()
                  : AppDivider(),
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
    //         SessionController().setNotificationId(_controller
    //             .notificationsUnRead![index].notificationId
    //             .toString());

    //         if (_controller.notificationsUnRead![index].isRead != true) {
    //           _controller.unreadNotificationsLoading.value = true;
    //           var res = await _controller.readNotifications();
    //           if (res) {
    //             setState(() {
    //               setState(() {
    //                 _controller.notificationsUnRead!.removeAt(index);
    //                 _controller.unreadLength = _controller.unreadLength - 1;
    //               });
    //             });
    //             if (_controller.notificationsUnRead!.length == 0) {
    //               _getUnreadNotifications();
    //               print(' calling');
    //             } else {
    //               print('Not calling');
    //             }
    //           }
    //           _controller.unreadNotificationsLoading.value = false;
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
    //         onTap: () {
    //           setState(() {
    //             _controller.unreadLength = _controller.unreadLength - 1;
    //             _controller.notificationsUnRead!.removeAt(index);
    //           });
    //         }),
    //   ],
    //   child: Container(
    //     width: 90.0.w,
    //     child: ListTile(
    //       title: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Row(
    //             children: [
    //               _controller.notificationsUnRead![index].isRead == true
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
    //                   width:
    //                       _controller.editTap.value == true ? 30.0.w : 60.0.w,
    //                   child: Text(
    //                     SessionController().getLanguage() == 1
    //                         ? _controller.notificationsUnRead![index].title
    //                             .toString()
    //                         : _controller.notificationsUnRead![index].titleAR
    //                             .toString(),
    //                     overflow: TextOverflow.ellipsis,
    //                     style: AppTextStyle.semiBoldBlack11,
    //                   ),
    //                 ),
    //               ),
    //               Spacer(),
    //               Icon(Icons.more_horiz),
    //             ],
    //           ),
    //           // public unread notification
    //           Padding(
    //             padding: EdgeInsets.symmetric(horizontal: 3.0.w),
    //             child: Html(
    //               data: SessionController().getLanguage() == 1
    //                   ? _controller.notificationsUnRead![index].description
    //                       .toString()
    //                   : _controller.notificationsUnRead![index].descriptionAR
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
    //                 _controller.notificationsUnRead![index].createdOn ?? "",
    //                 style: AppTextStyle.normalBlack10,
    //               ),
    //             ),
    //           ),
    //           SizedBox(
    //             height: 2.0.h,
    //           ),
    //           index == _controller.unreadLength - 1
    //               ? Container()
    //               : AppDivider(),
    //         ],
    //       ),
    //     ),
    //   ),
    //   actionPane: SlidableDrawerActionPane(),
    // );
  }
}
