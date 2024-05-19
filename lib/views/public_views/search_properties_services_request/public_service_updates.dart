import 'package:fap_properties/views/public_views/search_properties_services_request/public_service_updates_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:fap_properties/views/widgets/common_widgets/error_text_widget.dart';
import 'package:fap_properties/views/widgets/common_widgets/loading_indicator_blue.dart';
import 'package:fap_properties/views/widgets/bottom_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:open_file/open_file.dart';
import 'package:sizer/sizer.dart';

import '../../../data/helpers/session_controller.dart';
import '../../../data/models/tenant_models/service_request/doc_file.dart';
import '../../../utils/text_validator.dart';
import 'dart:ui' as ui;

class PublicServiceUpdates extends StatefulWidget {
  final int reqNo;
  final bool canCommunicate;
  const PublicServiceUpdates(
      {Key key, @required this.reqNo, @required this.canCommunicate})
      : super(key: key);

  @override
  _PublicServiceUpdatesState createState() => _PublicServiceUpdatesState();
}

class _PublicServiceUpdatesState extends State<PublicServiceUpdates> {
  final TextEditingController _messageTextController = TextEditingController();
  final ScrollController _chatListScrollController = ScrollController();
  FocusNode _focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  KeyboardActionsConfig _buildKeyboardConfig(BuildContext context) {
    return KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
        keyboardBarColor: Colors.grey[200],
        nextFocus: true,
        actions: [
          KeyboardActionsItem(
            focusNode: _focusNode,
          ),
        ]);
  }

  @override
  void initState() {
    _controller.getTicketReplies(widget.reqNo.toString());
    super.initState();
  }

  final _controller = Get.put(PublicServiceUpdatesController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Column(
              children: [
                _controller.typing.value
                    ? Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(2.h),
                          child: Form(
                            key: formKey,
                            child: KeyboardActions(
                              config: _buildKeyboardConfig(context),
                              child: TextFormField(
                                controller: _messageTextController,
                                focusNode: _focusNode,
                                textAlign: TextAlign.start,
                                style: AppTextStyle.normalGrey12,
                                maxLines: 8,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4.0.w),
                                  ),
                                  hintText: AppMetaLabels().yourMessage,
                                  hintStyle: AppTextStyle.normalGrey11,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return AppMetaLabels().requiredField;
                                  } else if (!textValidator
                                      .hasMatch(value.replaceAll('\n', ' '))) {
                                    return AppMetaLabels().invalidText;
                                  } else if (value.trim().isEmpty == true) {
                                    return AppMetaLabels().invalidText;
                                  } else
                                    return null;
                                },
                              ),
                            ),
                          ),
                        ),
                      )
                    : showChat(),
                if (_controller.typing.value)
                  Expanded(
                    child: Obx(() {
                      return Column(
                        children: [
                          _controller.fileToUpload.value.path == null
                              ? TextButton(
                                  onPressed: () {
                                    _controller.pickFile();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.attach_file),
                                      Text(
                                        AppMetaLabels().addFile,
                                        style: AppTextStyle.normalBlack12,
                                      ),
                                    ],
                                  ),
                                )
                              : Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        OpenFile.open(_controller
                                            .fileToUpload.value.path);
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.file_open),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.72,
                                            child: Text(
                                              _controller.fileToUpload.value
                                                      .name ??
                                                  '',
                                              style: AppTextStyle.normalBlue12,
                                              maxLines: null,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          _controller.fileToUpload.value =
                                              DocFile();
                                        },
                                        icon: Icon(Icons.cancel_outlined))
                                  ],
                                ),
                          SizedBox(
                            height: 2.h,
                          ),
                          _controller.addingReply.value
                              ? LoadingIndicatorBlue()
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        _controller.typing.value = false;
                                      },
                                      icon: Icon(
                                        Icons.cancel_outlined,
                                        size: 32,
                                        color: AppColors.grey1,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2.w,
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        _focusNode.unfocus();
                                        if (formKey.currentState.validate()) if (await _controller
                                            .addTicketReply(
                                                widget.reqNo.toString(),
                                                _messageTextController.text)) {
                                          _controller.typing.value = false;
                                          _messageTextController.clear();
                                          scrollToEndofChat();
                                        } else
                                          Get.snackbar(
                                            AppMetaLabels().error,
                                            _controller.errorReplying,
                                            backgroundColor: AppColors.white54,
                                          );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.blueColor,
                                            borderRadius:
                                                BorderRadius.circular(24)),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0),
                                              child: Text(
                                                AppMetaLabels().send,
                                                style: AppTextStyle
                                                    .semiBoldWhite12,
                                              ),
                                            ),
                                            // Image.asset(
                                            //   AppImagesPath.msgsentimg,
                                            //   height: 32,
                                            // ),
                                            SessionController().getLanguage() ==
                                                    1
                                                ? IconButton(
                                                    onPressed: null,
                                                    icon: Image.asset(
                                                      AppImagesPath.msgsentimg,
                                                      height: 7.0.h,
                                                    ),
                                                  )
                                                : CircleAvatar(
                                                    radius: 2.2.h,
                                                    backgroundColor:
                                                        Colors.blue[690],
                                                    child: IconButton(
                                                      onPressed: null,
                                                      icon: Icon(
                                                        Icons.send,
                                                        color: Colors.white,
                                                        size: 1.8.h,
                                                      ),
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      );
                    }),
                  ),
                if (!_controller.typing.value && widget.canCommunicate)
                  Container(
                      height: 8.0.h,
                      width: double.maxFinite,
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 0.9.h,
                          spreadRadius: 0.4.h,
                          offset: Offset(0.1.h, 0.1.h),
                        ),
                      ]),
                      child: Padding(
                          padding: EdgeInsets.only(left: 5.0.w, right: 5.0.w),
                          child: Directionality(
                            textDirection:
                                SessionController().getLanguage() == 1
                                    ? ui.TextDirection.ltr
                                    : ui.TextDirection.rtl,
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 76.0.w,
                                    child: Directionality(
                                      textDirection:
                                          SessionController().getLanguage() == 1
                                              ? ui.TextDirection.ltr
                                              : ui.TextDirection.rtl,
                                      child: TextFormField(
                                        textAlign: TextAlign.start,
                                        style: AppTextStyle.normalGrey12,
                                        readOnly: true,
                                        onTap: () {
                                          if (widget.canCommunicate) {
                                            _controller.typing.value = true;
                                            _focusNode.requestFocus();
                                          } else {
                                            Get.snackbar(AppMetaLabels().error,
                                                AppMetaLabels().reqCancelled,
                                                backgroundColor:
                                                    AppColors.white54);
                                          }
                                        },
                                        decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0.w),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 1.0,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0.w),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 1.0,
                                            ),
                                          ),
                                          fillColor: AppColors.greyBG,
                                          filled: true,
                                          hintText: AppMetaLabels().yourMessage,
                                          hintStyle: AppTextStyle.normalGrey11,
                                          errorStyle: TextStyle(fontSize: 0),
                                          contentPadding: EdgeInsets.only(
                                              top: 4.w,
                                              left: 4.0.w,
                                              right: 4.0.w),
                                        ),
                                      ),
                                    ),
                                  ),
                                  // IconButton(
                                  //   onPressed: null,
                                  //   icon: Image.asset(
                                  //     AppImagesPath.msgsentimg,
                                  //     height: 8.0.h,
                                  //   ),
                                  // )
                                  SessionController().getLanguage() == 1
                                      ? IconButton(
                                          onPressed: null,
                                          icon: Image.asset(
                                            AppImagesPath.msgsentimg,
                                            height: 7.0.h,
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 2.2.h,
                                          backgroundColor: Colors.blue[690],
                                          child: IconButton(
                                            onPressed: null,
                                            icon: Icon(
                                              Icons.send,
                                              color: Colors.white,
                                              size: 1.8.h,
                                            ),
                                          ),
                                        )
                                ]),
                          )))
              ],
            ),
            BottomShadow(),
          ],
        ),
      );
    });
  }

  Expanded showChat() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 0),
        child: Obx(() {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            scrollToEndofChat();
          });
          return _controller.gettingReplies.value
              ? Center(
                  child: LoadingIndicatorBlue(),
                )
              : _controller.errorGettingReplies != ''
                  ? Center(
                      child: AppErrorWidget(),
                    )
                  : ListView.builder(
                      controller: _chatListScrollController,
                      itemCount: _controller.ticketReplies.ticketReply.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      itemBuilder: (context, index) {
                        return Align(
                          alignment: (_controller.ticketReplies
                                      .ticketReply[index].userId2 ==
                                  null
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 80.w),
                            child: Container(
                              margin: EdgeInsets.only(top: 2.5.h),
                              decoration: _controller.ticketReplies
                                          .ticketReply[index].userId2 ==
                                      null
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(2.0.w),
                                          bottomLeft: Radius.circular(7.0.w),
                                          bottomRight: Radius.circular(2.0.w)),
                                      color: (AppColors.recivedchatclr),
                                    )
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(2.0.w),
                                        bottomLeft: Radius.circular(2.0.w),
                                        bottomRight: Radius.circular(7.0.w),
                                      ),
                                      color: (AppColors.sendchatclr),
                                    ),
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: _controller.ticketReplies
                                            .ticketReply[index].userId2 ==
                                        null
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  if (_controller.ticketReplies
                                              .ticketReply[index].fileName !=
                                          null &&
                                      _controller.ticketReplies
                                              .ticketReply[index].fileName !=
                                          "")
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            _controller.ticketReplies
                                                .ticketReply[index].fileName,
                                            style: AppTextStyle.semiBoldBlue10,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: Obx(() {
                                            return _controller
                                                    .ticketReplies
                                                    .ticketReply[index]
                                                    .downloadingFile
                                                    .value
                                                ? LoadingIndicatorBlue(
                                                    strokeWidth: 2,
                                                    size: 24,
                                                  )
                                                : _controller.isLoadingSelectedIndex
                                                                .value ==
                                                            index &&
                                                        _controller
                                                            .isLoadingDownload
                                                            .value
                                                    ? LoadingIndicatorBlue(
                                                        strokeWidth: 2,
                                                        size: 24,
                                                      )
                                                    : Center(
                                                        child: IconButton(
                                                            onPressed: () {
                                                              _controller
                                                                  .isLoadingSelectedIndex
                                                                  .value = index;
                                                              _controller
                                                                  .downloadFile(
                                                                      index);
                                                            },
                                                            icon: Icon(
                                                              Icons.download,
                                                              color: AppColors
                                                                  .blackColor,
                                                            )),
                                                      );
                                          }),
                                        )
                                      ],
                                    ),
                                  // Text(
                                  //   _controller
                                  //       .ticketReplies.ticketReply[index].reply,
                                  //   style: AppTextStyle.normalGrey12
                                  //       .copyWith(fontWeight: FontWeight.w600),
                                  // ),
                                  // Communication
                                  Html(
                                    customTextAlign: (_) =>
                                        SessionController().getLanguage() == 1
                                            ? TextAlign.left
                                            : TextAlign.right,
                                    data: _controller
                                        .ticketReplies.ticketReply[index].reply,
                                    defaultTextStyle: AppTextStyle.normalGrey12
                                        .copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text(
                                    _controller.ticketReplies.ticketReply[index]
                                        .dateTime,
                                    style: AppTextStyle.normalGrey8,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
        }),
      ),
    );
  }

  scrollToEndofChat() {
    if (_chatListScrollController.hasClients) {
      final position = _chatListScrollController.position.maxScrollExtent;
      _chatListScrollController.jumpTo(position);
    }
  }
}
