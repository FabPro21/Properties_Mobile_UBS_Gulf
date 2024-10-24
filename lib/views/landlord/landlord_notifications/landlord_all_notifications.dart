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

class LandLordAllNotifications extends StatefulWidget {
  final int? index;
  const LandLordAllNotifications({Key? key, this.index}) : super(key: key);

  @override
  _LandLordAllNotificationsState createState() =>
      _LandLordAllNotificationsState();
}

class _LandLordAllNotificationsState extends State<LandLordAllNotifications> {
  final getLandLController = Get.put(LandlordNotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: getLandLController.loadingData.value
          ? LoadingIndicatorBlue()
          : getLandLController.error.value != ''
              ? AppErrorWidget(
                  errorText: getLandLController.error.value,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (getLandLController.editTap.value)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                        child: Row(
                          children: [
                            Checkbox(
                              onChanged: (bool? value) {
                                getLandLController.allCheckbox.toggleMarkAll();
                              },
                              value:
                                  getLandLController.allCheckbox.markAll.value,
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
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: getLandLController.allLength,
                                  padding: EdgeInsets.only(top: 2.h),
                                  itemBuilder: (context, int index) {
                                    return ListTile(
                                      onTap: () async {
                                        SessionController().setNotificationId(
                                            getLandLController
                                                .getNotifications
                                                .value
                                                .notifications![index]
                                                .notificationId
                                                .toString());
                                        if (!getLandLController
                                            .getNotifications
                                            .value
                                            .notifications![index]
                                            .isRead!)
                                          await getLandLController
                                              .readNotifications(index, 'all');
                                        Get.to(() =>
                                            LandlordNotificationDetails());
                                      },
                                      contentPadding: EdgeInsets.zero,
                                      horizontalTitleGap: 0,
                                      leading: getLandLController.editTap.value
                                          ? Checkbox(
                                              value: getLandLController
                                                  .allCheckbox
                                                  .marked[index]
                                                  .value,
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    getLandLController
                                                        .allCheckbox
                                                        .markItem(index, val!);
                                                  },
                                                );
                                              },
                                            )
                                          : null,
                                      title: getLandLController.editTap.value
                                          ? notification(index)
                                          : slideable(index),
                                    );
                                  }),
                            ),
                            SizedBox(
                              height: 1.0.h,
                            ),
                            getLandLController.allLength < 20
                                ? SizedBox()
                                : Center(
                                    child: Obx(() {
                                      return getLandLController
                                                  .noMoreDataPageAll.value !=
                                              ''
                                          ? Text(
                                              AppMetaLabels().noMoreData,
                                              style: AppTextStyle.boldBlue,
                                            )
                                          : getLandLController
                                                  .isLoadingAllNotification
                                                  .value
                                              ? SizedBox(
                                                  width: 75.w,
                                                  height: 5.h,
                                                  child: Center(
                                                    child:
                                                        LoadingIndicatorBlue(),
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () async {
                                                    int pageSize = int.parse(
                                                        getLandLController
                                                            .pagaNoPAll);
                                                    int naePageNo =
                                                        pageSize + 1;
                                                    getLandLController
                                                            .pagaNoPAll =
                                                        naePageNo.toString();
                                                    await getLandLController
                                                        .getData1(
                                                            getLandLController
                                                                .pagaNoPAll
                                                                .toString());
                                                    setState(() {});
                                                  },
                                                  child: SizedBox(
                                                      width: 75.w,
                                                      height: 3.h,
                                                      child: RichText(
                                                        textAlign:
                                                            TextAlign.center,
                                                        text: TextSpan(
                                                          children: [
                                                            TextSpan(
                                                                text: AppMetaLabels()
                                                                    .loadMoreData,
                                                                style: AppTextStyle
                                                                    .boldBlue),
                                                            WidgetSpan(
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                size: 15,
                                                                color: AppColors
                                                                    .blueColor,
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
                ),
    );
  }

  Slidable slideable(int index) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.grey[200] ?? Colors.grey,
            foregroundColor: Colors.black,
            icon: Icons.check_circle_outline,
            // color: Colors.blue,
            onPressed: (context) async {
              SessionController().setNotificationId(
                getLandLController
                    .getNotifications.value.notifications![index].notificationId
                    .toString(),
              );
              await getLandLController.readNotifications(index, 'all');
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
              SessionController().setNotificationId(
                getLandLController
                    .getNotifications.value.notifications![index].notificationId
                    .toString(),
              );
              await getLandLController.archiveNotifications();
              setState(() {
                getLandLController.allLength = getLandLController.allLength - 1;
                getLandLController.getNotifications.value.notifications!
                    .removeAt(index);
              });
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
    //         SessionController().setNotificationId(getLandLController
    //             .getNotifications.value.notifications![index].notificationId
    //             .toString());
    //         await getLandLController.readNotifications(index, 'all');
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
    //               .getNotifications.value.notifications![index].notificationId
    //               .toString());

    //           await getLandLController.archiveNotifications();
    //           setState(() {
    //             getLandLController.allLength = getLandLController.allLength - 1;
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: SizedBox(
            width: 85.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (!getLandLController
                        .getNotifications.value.notifications![index].isRead!)
                      Container(
                        height: 1.0.h,
                        width: 2.0.w,
                        margin: EdgeInsets.symmetric(horizontal: 1.w),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.6.w),
                      width: getLandLController.editTap.value == true
                          ? 25.0.w
                          : 75.0.w,
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
                  padding: EdgeInsets.symmetric(horizontal: 1.6.w),
                  child: Html(
                    data: SessionController().getLanguage() == 1
                        ? getLandLController.getNotifications.value
                                .notifications![index].description ??
                            ""
                        : getLandLController.getNotifications.value
                                .notifications![index].descriptionAR ??
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
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text(
                    getLandLController.getNotifications.value
                            .notifications![index].createdOn ??
                        "",
                    style: AppTextStyle.normalBlack10,
                  ),
                ),
                SizedBox(
                  height: 2.0.h,
                ),
                index == getLandLController.allLength - 1
                    ? Container()
                    : AppDivider(),
              ],
            ),
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
