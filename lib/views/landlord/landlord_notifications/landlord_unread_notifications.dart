import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/fonts.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/landlord/landlord_notifications/landlord_notification_details.dart';
import 'package:fap_properties/views/landlord/landlord_notifications/landlord_notifications_controller.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class LandLordUnReadNotifications extends StatefulWidget {
  final int? index;
  const LandLordUnReadNotifications({Key? key, this.index}) : super(key: key);

  @override
  _LandLordUnReadNotificationsState createState() =>
      _LandLordUnReadNotificationsState();
}

class _LandLordUnReadNotificationsState
    extends State<LandLordUnReadNotifications> {
  final getLandLController = Get.put(LandlordNotificationsController());
  _getUnreadNotifications() async {
    await getLandLController
        .unReadNotifications(getLandLController.pagaNoPURead);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (getLandLController.noMoreDataUnRead.value == '') {
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
        return getLandLController.unreadNotificationsLoading.value
            ? LoadingIndicatorBlue()
            : getLandLController.errorUnread.value != ''
                ? AppErrorWidget(
                    errorText: getLandLController.errorUnread.value,
                  )
                : Column(
                    children: [
                      if (getLandLController.editTap.value)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                          child: Row(
                            children: [
                              Checkbox(
                                onChanged: (bool? value) {
                                  getLandLController.unreadCheckbox
                                      .toggleMarkAll();
                                },
                                value: getLandLController
                                    .unreadCheckbox.markAll.value,
                                tristate: true,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(AppMetaLabels().markAsRead),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(AppMetaLabels().archive),
                              )
                            ],
                          ),
                        ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.fromLTRB(
                              4.w,
                              getLandLController.editTap.value ? 0 : 2.h,
                              4.w,
                              2.h),
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
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: getLandLController.unreadLength,
                              padding: EdgeInsets.only(top: 2.h),
                              itemBuilder: (context, int index) {
                                return ListTile(
                                  onTap: () async {
                                    SessionController().setNotificationId(
                                        getLandLController
                                            .unreadNotifications
                                            .value
                                            .notifications![index]
                                            .notificationId
                                            .toString());
                                    if (!getLandLController.unreadNotifications
                                        .value.notifications![index].isRead!)
                                      getLandLController
                                          .unreadNotificationsLoading
                                          .value = true;
                                    bool res = await getLandLController
                                        .readNotifications(index, 'unread');
                                    print('Result ::::: $res');
                                    if (res) {
                                      setState(() {
                                        getLandLController.notificationsUnRead!
                                            .removeAt(index);
                                        getLandLController.unreadLength =
                                            getLandLController.unreadLength - 1;
                                      });
                                    }
                                    Get.to(() => LandlordNotificationDetails());
                                  },
                                  contentPadding: EdgeInsets.zero,
                                  horizontalTitleGap: 0,
                                  leading: getLandLController.editTap.value
                                      ? Checkbox(
                                          value: getLandLController
                                              .unreadCheckbox
                                              .marked[index]
                                              .value,
                                          onChanged: (val) {
                                            getLandLController.unreadCheckbox
                                                .markItem(index, val!);
                                          },
                                        )
                                      : null,
                                  title: getLandLController.editTap.value
                                      ? notification(index)
                                      : slideable(index),
                                );
                              }),
                        ),
                      ),
                    ],
                  );
      }),
    );
  }

  Slidable slideable(int index) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(), // Use DrawerMotion for the slide effect
        children: [
          SlidableAction(
            backgroundColor: Colors.grey[200] ?? Colors.grey,
            foregroundColor: Colors.black,
            icon: Icons.check_circle_outline,
            // color: Colors.blue,
            onPressed: (context) async {
              SessionController().setNotificationId(
                getLandLController.unreadNotifications.value
                    .notifications![index].notificationId
                    .toString(),
              );
              getLandLController.unreadNotificationsLoading.value = true;
              bool res =
                  await getLandLController.readNotifications(index, 'unread');
              print('Result ::::: $res');
              if (res) {
                // Update state to reflect changes
                getLandLController.unreadNotifications.value.notifications!
                    .removeAt(index);
                getLandLController.unreadLength =
                    getLandLController.unreadLength - 1;
              }
              getLandLController.unreadNotificationsLoading.value = false;
            },
            borderRadius: BorderRadius.circular(8.0),
            spacing: 8.0,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(), // Use DrawerMotion for the slide effect
        children: [
          SlidableAction(
            backgroundColor: Colors.grey[200] ?? Colors.grey,
            foregroundColor: Colors.black,
            icon: Icons.archive,
            // color: Color.fromRGBO(255, 179, 0, 1),
            onPressed: (context) async {
              SessionController().setNotificationId(
                getLandLController.unreadNotifications.value
                    .notifications![index].notificationId
                    .toString(),
              );
              await getLandLController.archiveNotifications();
              // Update state to reflect changes
              getLandLController.unreadLength =
                  getLandLController.unreadLength - 1;
              getLandLController.unreadNotifications.value.notifications!
                  .removeAt(index);
            },
            borderRadius: BorderRadius.circular(8.0),
            spacing: 8.0,
          ),
        ],
      ),
      child: notification(index),
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
    //         SessionController().setNotificationId(getLandLController
    //             .unreadNotifications.value.notifications![index].notificationId
    //             .toString());
    //         getLandLController.unreadNotificationsLoading.value = true;
    //         bool res =
    //             await getLandLController.readNotifications(index, 'unread');
    //         print('Result ::::: $res');
    //         if (res) {
    //           setState(() {
    //             getLandLController.notificationsUnRead!.removeAt(index);
    //             getLandLController.unreadLength =
    //                 getLandLController.unreadLength - 1;
    //           });
    //         }
    //         getLandLController.unreadNotificationsLoading.value = false;
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
    //           SessionController().setNotificationId(getLandLController
    //               .unreadNotifications
    //               .value
    //               .notifications![index]
    //               .notificationId
    //               .toString());

    //           await getLandLController.archiveNotifications();
    //           setState(() {
    //             getLandLController.unreadLength =
    //                 getLandLController.unreadLength - 1;
    //             getLandLController.getNotifications.value.notifications!
    //                 .removeAt(index);
    //           });
    //         }),
    //   ],
    //   child: notification(index),
    //   actionPane: SlidableDrawerActionPane(),
    // );
  }

  Widget notification(int index) {
    return Row(
      children: [
        SizedBox(
          width: 85.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (!getLandLController
                      .unreadNotifications.value.notifications![index].isRead!)
                    Container(
                      height: 1.0.h,
                      width: 2.0.w,
                      margin: EdgeInsets.symmetric(horizontal: 1.6.w),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  SizedBox(
                    // color: Colors.green,
                    width: getLandLController.editTap.value == true
                        ? 25.0.w
                        : 55.0.w,
                    child: Text(
                      SessionController().getLanguage() == 1
                          ? getLandLController.getNotifications.value
                                  .notifications![index].title ??
                              ""
                          : getLandLController.getNotifications.value
                                  .notifications![index].titleAR ??
                              "",
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyle.semiBoldBlack11,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 5.5.w, right: 5.5.w),
                child: Html(
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
                  data: SessionController().getLanguage() == 1
                      ? getLandLController.getNotifications.value
                              .notifications![index].description ??
                          ""
                      : getLandLController.getNotifications.value
                              .notifications![index].descriptionAR ??
                          "",
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 6.w,
                ),
                child: Text(
                  getLandLController.unreadNotifications.value
                          .notifications![index].createdOn ??
                      "",
                  style: AppTextStyle.normalBlack10,
                ),
              ),
              SizedBox(
                height: 1.0.h,
              ),
              index == getLandLController.unreadLength - 1
                  ? Container()
                  : AppDivider(),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 2.0.h, left: 0.0.h),
          child: SizedBox(
            width: 0.15.w,
            child: Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.grey1,
              size: 20,
            ),
          ),
        )
      ],
    );
  }
}
