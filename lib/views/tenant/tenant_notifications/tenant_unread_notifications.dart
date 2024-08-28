import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/fonts.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/divider_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/tenant/tenant_notifications/tenant_notification_details.dart';
import 'package:fap_properties/views/tenant/tenant_notifications/tenant_notifications_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class TenantUnReadNotifications extends StatefulWidget {
  final int? index;
  const TenantUnReadNotifications({Key? key, this.index}) : super(key: key);

  @override
  _TenantUnReadNotificationsState createState() =>
      _TenantUnReadNotificationsState();
}

class _TenantUnReadNotificationsState extends State<TenantUnReadNotifications> {
  final getTNController = Get.put(GetTenantNotificationsController());

  _getUnreadNotifications() async {
    await getTNController.unReadNotifications(getTNController.pagaNoPURead);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (getTNController.noMoreDataUnRead.value == '') {
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
        return getTNController.unreadNotificationsLoading.value
            ? LoadingIndicatorBlue()
            : getTNController.errorUnread.value != ''
                ? AppErrorWidget(
                    errorText: getTNController.errorUnread.value,
                  )
                : Column(
                    children: [
                      if (getTNController.editTap.value)
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                          child: Row(
                            children: [
                              Checkbox(
                                onChanged: (bool? value) {
                                  getTNController.unreadCheckbox
                                      .toggleMarkAll();
                                },
                                value: getTNController
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
                              getTNController.editTap.value ? 0 : 2.h,
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
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: getTNController.unreadLength,
                                    padding: EdgeInsets.only(top: 2.h),
                                    itemBuilder: (context, int index) {
                                      return ListTile(
                                        onTap: () async {
                                          SessionController().setNotificationId(
                                              getTNController
                                                  .notificationsUnRead![index]
                                                  .notificationId
                                                  .toString());
                                          if (!getTNController
                                              .notificationsUnRead![index]
                                              .isRead!) {
                                            getTNController
                                                .unreadNotificationsLoading
                                                .value = true;
                                            bool res = await getTNController
                                                .readNotifications(
                                                    index, 'unread');
                                            print('Result ::::: $res');
                                            if (res) {
                                              setState(() {
                                                getTNController
                                                    .notificationsUnRead!
                                                    .removeAt(index);
                                                getTNController.unreadLength =
                                                    getTNController
                                                            .unreadLength -
                                                        1;
                                              });
                                            }
                                            await Get.to(() =>
                                                TenantNotificationDetails());
                                            setState(() {});
                                            setState(() {});
                                            getTNController
                                                .unreadNotificationsLoading
                                                .value = false;
                                          }
                                        },
                                        contentPadding: EdgeInsets.zero,
                                        horizontalTitleGap: 0,
                                        leading: getTNController.editTap.value
                                            ? Checkbox(
                                                value: getTNController
                                                    .unreadCheckbox
                                                    .marked[index]
                                                    .value,
                                                onChanged: (bool? val) {
                                                  getTNController.unreadCheckbox
                                                      .markItem(index, val!);
                                                },
                                              )
                                            : null,
                                        title: getTNController.editTap.value
                                            ? notification(index)
                                            : slideable(index),
                                      );
                                    }),
                              ),
                              SizedBox(
                                height: 1.0.h,
                              ),
                              Center(
                                child: Obx(() {
                                  return getTNController
                                              .noMoreDataUnRead.value !=
                                          ''
                                      ? Text(
                                          AppMetaLabels().noMoreData,
                                          style: TextStyle(
                                            color: Colors.blue,
                                          ).copyWith(
                                              fontWeight: FontWeight.bold),
                                        )
                                      : getTNController
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
                                                    getTNController
                                                        .pagaNoPURead);
                                                int naePageNo = pageSize + 1;
                                                getTNController.pagaNoPURead =
                                                    naePageNo.toString();
                                                await getTNController
                                                    .unReadNotifications1(
                                                        getTNController
                                                            .pagaNoPURead
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
                                                          style: TextStyle(
                                                            color: Colors.blue,
                                                          ).copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        WidgetSpan(
                                                          child: Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            size: 15,
                                                            color: Colors.blue,
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
                      ),
                    ],
                  );
      }),
    );
  }

  Slidable slideable(int index) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(), // For the sliding effect
        children: [
          SlidableAction(
            backgroundColor: Colors.grey[200]?? Colors.grey,
            foregroundColor: Colors.black,
            icon: Icons.check_circle_outline,
            // color: Colors.blue,
            onPressed: (context) async {
              SessionController().setNotificationId(getTNController
                  .notificationsUnRead![index].notificationId
                  .toString());
              if (getTNController.notificationsUnRead![index].isRead != true) {
                getTNController.unreadNotificationsLoading.value = true;
                bool res =
                    await getTNController.readNotifications(index, 'unread');
                print('Result ::::: $res');
                if (res) {
                  getTNController.notificationsUnRead!.removeAt(index);
                  getTNController.unreadLength =
                      getTNController.unreadLength - 1;
                  if (getTNController.notificationsUnRead!.isEmpty) {
                    _getUnreadNotifications();
                    print(' calling');
                  } else {
                    print('Not calling');
                  }
                }
                getTNController.unreadNotificationsLoading.value = false;
              }
            },
            borderRadius: BorderRadius.circular(8.0),
            spacing: 8.0,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.grey[200] ?? Colors.grey,
            foregroundColor: Colors.black,
            icon: Icons.archive,
            // color: Color.fromRGBO(255, 179, 0, 1),
            onPressed: (context) async {
              SessionController().setNotificationId(getTNController
                  .notificationsUnRead![index].notificationId
                  .toString());
              await getTNController.archiveNotifications();
              getTNController.notificationsUnRead!.removeAt(index);
              getTNController.unreadLength = getTNController.unreadLength - 1;
            },
            borderRadius: BorderRadius.circular(8.0),
            spacing: 8.0,
          ),
        ],
      ),
      child: notification(index),
    );

    //  Slidable(
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
    //         SessionController().setNotificationId(getTNController
    //             .notificationsUnRead![index].notificationId
    //             .toString());
    //         // await getTNController.readNotifications(index, 'unread');
    //         if (getTNController.notificationsUnRead![index].isRead != true) {
    //           getTNController.unreadNotificationsLoading.value = true;
    //           bool res =
    //               await getTNController.readNotifications(index, 'unread');
    //           print('Result ::::: $res');
    //           if (res) {
    //             setState(() {
    //               getTNController.notificationsUnRead!.removeAt(index);
    //               getTNController.unreadLength =
    //                   getTNController.unreadLength - 1;
    //             });
    //             if (getTNController.notificationsUnRead!.length == 0) {
    //               _getUnreadNotifications();
    //               print(' calling');
    //             } else {
    //               print('Not calling');
    //             }
    //           }
    //           getTNController.unreadNotificationsLoading.value = false;
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
    //           SessionController().setNotificationId(getTNController
    //               .notificationsUnRead![index].notificationId
    //               .toString());
    //           await getTNController.archiveNotifications();
    //           setState(() {
    //             getTNController.unreadLength = getTNController.unreadLength - 1;
    //             getTNController.notificationsUnRead!.removeAt(index);
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
                  // if (!getTNController.notificationsUnRead![index].isRead)
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
                    width:
                        getTNController.editTap.value == true ? 25.0.w : 55.0.w,
                    child: Text(
                      SessionController().getLanguage() == 1
                          ? getTNController.notificationsUnRead![index].title ??
                              ""
                          : getTNController
                                  .notificationsUnRead![index].titleAR ??
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
                  data: SessionController().getLanguage() == 1
                      ? getTNController
                              .notificationsUnRead![index].description ??
                          ""
                      : getTNController
                              .notificationsUnRead![index].descriptionAR ??
                          "",
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
                padding: EdgeInsets.symmetric(
                  horizontal: 6.w,
                ),
                child: Text(
                  getTNController.notificationsUnRead![index].createdOn ?? "",
                  style: AppTextStyle.normalBlack10,
                ),
              ),
              SizedBox(
                height: 2.0.h,
              ),
              index == getTNController.unreadLength - 1
                  ? Container()
                  : AppDivider(),
            ],
          ),
        ),
        Padding(
          padding: SessionController().getLanguage() == 1
              ? EdgeInsets.only(right: 2.0.h, left: 0.0.h)
              : EdgeInsets.only(right: 0.0.h, left: 2.0.h),
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
