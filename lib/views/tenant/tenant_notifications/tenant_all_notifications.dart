import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
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

class TenantAllNotifications extends StatefulWidget {
  final int index;
  const TenantAllNotifications({Key key, this.index}) : super(key: key);

  @override
  _TenantAllNotificationsState createState() => _TenantAllNotificationsState();
}

class _TenantAllNotificationsState extends State<TenantAllNotifications> {
  final getTNController = Get.put(GetTenantNotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: getTNController.loadingData.value
          ? LoadingIndicatorBlue()
          : getTNController.error.value != ''
              ? AppErrorWidget(
                  errorText: getTNController.error.value,
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (getTNController.editTap.value)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0.w),
                        child: Row(
                          children: [
                            Checkbox(
                              onChanged: (bool value) {
                                getTNController.allCheckbox.toggleMarkAll();
                              },
                              value: getTNController.allCheckbox.markAll.value,
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
                        margin: EdgeInsets.fromLTRB(4.w,
                            getTNController.editTap.value ? 0 : 2.h, 4.w, 2.h),
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
                                  itemCount: getTNController.allLength,
                                  padding: EdgeInsets.only(top: 2.h),
                                  itemBuilder: (context, int index) {
                                    return ListTile(
                                      onTap: () async {
                                        SessionController().setNotificationId(
                                            getTNController.notifications[index]
                                                .notificationId
                                                .toString());
                                        if (!getTNController
                                            .notifications[index].isRead)
                                          await getTNController
                                              .readNotifications(index, 'all');
                                        Get.to(
                                            () => TenantNotificationDetails());
                                      },
                                      contentPadding: EdgeInsets.zero,
                                      horizontalTitleGap: 0,
                                      leading: getTNController.editTap.value
                                          ? Checkbox(
                                              value: getTNController.allCheckbox
                                                  .marked[index].value,
                                              onChanged: (val) {
                                                setState(
                                                  () {
                                                    getTNController.allCheckbox
                                                        .markItem(index, val);
                                                  },
                                                );
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
                                            .noMoreDataPageAll.value !=
                                        ''
                                    ? Text(
                                        AppMetaLabels().noMoreData,
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ).copyWith(fontWeight: FontWeight.bold),
                                      )
                                    : getTNController
                                            .isLoadingAllNotification.value
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
                                                  getTNController.pagaNoPAll);
                                              int naePageNo = pageSize + 1;
                                              getTNController.pagaNoPAll =
                                                  naePageNo.toString();
                                              await getTNController.getData1(
                                                  getTNController.pagaNoPAll
                                                      .toString());
                                              setState(() {});
                                            },
                                            child: Container(
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
                ),
    );
  }

  Slidable slideable(int index) {
    return Slidable(
      actions: <Widget>[
        SlideAction(
          color: Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: EdgeInsets.all(1.0.h),
                  child: Icon(
                    Icons.check_circle_outline,
                    color: Colors.white,
                    size: 3.0.h,
                  ),
                ),
              ),
              Text(
                AppMetaLabels().markAsRead,
                style: AppTextStyle.semiBoldBlue8,
              )
            ],
          ),
          //not defined closeOnTap so list will get closed when clicked
          onTap: () async {
            SessionController().setNotificationId(
                getTNController.notifications[index].notificationId.toString());
            getTNController.loadingData.value = true;
            await getTNController.readNotifications(index, 'all');
            getTNController.loadingData.value = false;
          },
        ),
      ],
      secondaryActions: <Widget>[
        SlideAction(
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 179, 0, 1),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(1.0.h),
                    child: Icon(
                      Icons.archive,
                      color: Colors.white,
                      size: 3.0.h,
                    ),
                  ),
                ),
                Text(
                  AppMetaLabels().archive,
                  style: AppTextStyle.semiBoldBlue8
                      .copyWith(color: Color.fromRGBO(255, 179, 0, 1)),
                )
              ],
            ),
            //not defined closeOnTap so list will get closed when clicked
            onTap: () async {
              SessionController().setNotificationId(getTNController
                  .notifications[index].notificationId
                  .toString());

              await getTNController.archiveNotifications();
              setState(() {
                getTNController.allLength = getTNController.allLength - 1;
                getTNController.notifications.removeAt(index);
              });
            }),
      ],
      child: notification(index),
      actionPane: SlidableDrawerActionPane(),
    );
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
                    if (!getTNController.notifications[index].isRead)
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
                      width: getTNController.editTap.value == true
                          ? 25.0.w
                          : 75.0.w,
                      child: Text(
                        SessionController().getLanguage() == 1
                            ? getTNController.notifications[index].title ?? ""
                            : getTNController.notifications[index].titleAR ??
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
                    customTextAlign: (_) =>
                        SessionController().getLanguage() == 1
                            ? TextAlign.left
                            : TextAlign.right,
                    data: SessionController().getLanguage() == 1
                        ? getTNController.notifications[index].description ?? ""
                        : getTNController.notifications[index].descriptionAR ??
                            "",
                    defaultTextStyle: AppTextStyle.normalBlack10,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: Text(
                    getTNController.notifications[index].createdOn ?? "",
                    style: AppTextStyle.normalBlack10,
                  ),
                ),
                SizedBox(
                  height: 2.0.h,
                ),
                index == getTNController.allLength - 1
                    ? Container()
                    : AppDivider(),
              ],
            ),
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
