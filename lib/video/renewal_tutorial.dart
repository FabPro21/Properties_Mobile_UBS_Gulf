import 'dart:convert';
import 'dart:io';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class RenewalTutorialVideo extends StatefulWidget {
  final String path;
  const RenewalTutorialVideo({Key key, this.path}) : super(key: key);

  @override
  State<RenewalTutorialVideo> createState() => _RenewalTutorialVideoState();
}

class _RenewalTutorialVideoState extends State<RenewalTutorialVideo> {
  // saving file in the cache
  Future<String> createFile(Uint8List data, String fileName) async {
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/$fileName");
    File("${output.path}/$fileName").exists();
    await file.writeAsBytes(data.buffer.asUint8List());
    return "${output.path}/$fileName";
  }

  // getting file from asset and convert it into bas64 and save it in cache and return path
  Future<String> getFile() async {
    ByteData bytes = await rootBundle.load('assets/video/FAB_8.mp4');
    var buffer = bytes.buffer;
    var base64String = base64.encode(Uint8List.view(buffer));
    var uint8List = base64Decode(base64String.replaceAll('\n', ''));
    String path = await createFile(uint8List, 'FABRenewalTutorail.mp4');
    return path;
  }

  base64VideoPlay() async {
    try {
      loading.value = true;
      String path = await getFile();
      print('path :::::: $path');
      controller = VideoPlayerController.network(path)
        ..initialize().then((_) {
          setState(() {});
        });
      loading.value = false;
    } catch (e) {
      loading.value = false;
      print('Exception :::::: $e');
    }
  }

  base64VideoPlayPathAvailable(String path) async {
    try {
      print('Calling else $path');
      loading.value = true;
      controller = VideoPlayerController.network(path.trim())
        ..initialize().then((_) {
          controller.play();
          setState(() {});
        });
      loading.value = false;
    } catch (e) {
      loading.value = false;
      print('Exception :::::: $e');
    }
  }

  loadAssetVideoPlayer() {
    String path = SessionController().videoPathFromAsset;
    print('Load From asset : $path');
    // String path = 'assets/video/FAB_8.mp4';
    controller = VideoPlayerController.asset(path);
    controller.addListener(() {
      setState(() {
        loading.value = false;
      });
    });
    controller.initialize().then((value) {
      setState(() {
        loading.value = false;
      });
    });
  }

  loadVideoFromURl() async {
    try {
      String path = SessionController().videoURl;
      print('Load From URL : $path');
      loading.value = true;
      controller = VideoPlayerController.network(path.trim())
        ..initialize().then((_) {
          controller.play();
          setState(() {});
        });
      loading.value = false;
    } catch (e) {
      loading.value = false;
      print('Exception :::::: $e');
    }
  }

  // video player controller
  VideoPlayerController controller;
  RxBool loading = true.obs;

  initState() {
    // **************
    print('widget.path : ${widget.path}');
    // directly load from asset
    loadAssetVideoPlayer();
    // **************
    // play video from URl
    // loadVideoFromURl();
    super.initState();
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.value.isPlaying == true) {
          setState(() {
            controller.pause();
          });
        }
        Get.back();
        return;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: AppColors.blueColor,
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                if (controller.value.isPlaying == true) {
                  setState(() {
                    controller.pause();
                  });
                }
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
              ),
            ),
            title: Text(
              // 'Contract Renwal Flow',
              AppMetaLabels().renewalFlow,
              style: AppTextStyle.semiBoldWhite12,
            )),
        body: Obx(() {
          return loading.value == true
              ? Center(child: const CircularProgressIndicator())
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.value.isPlaying
                            ? controller.pause()
                            : controller.play();
                        setState(() {});
                      },
                      child: AspectRatio(
                          aspectRatio: controller.value.aspectRatio,
                          child: VideoPlayer(controller)),
                    ),
                    // DURATION of VIDEO
                    // Container(
                    //   child: Text("Total Duration: " +
                    //       controller.value.duration.toString()),
                    // ),
                    Container(
                        child: VideoProgressIndicator(controller,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              backgroundColor: Colors.white24,
                              playedColor: Colors.blue,
                              bufferedColor: Colors.grey,
                            ))),
                    SizedBox(
                      height: 1.h,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // START/STOP THE VIDEO
                        SizedBox(
                          height: 6.h,
                          width: 6.h,
                          child: FloatingActionButton(
                            heroTag: "btn1",
                            onPressed: () {
                              setState(() {
                                controller.value.isPlaying
                                    ? controller.pause()
                                    : controller.play();
                              });
                            },
                            child: Icon(
                              controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        // RESTART THE VIDEO
                        SizedBox(
                          height: 6.h,
                          width: 6.h,
                          child: FloatingActionButton(
                            heroTag: "btn2",
                            onPressed: () {
                              setState(() {
                                controller.seekTo(Duration(seconds: 0));
                                setState(() {});
                              });
                            },
                            child: Icon(Icons.stop),
                          ),
                        ),
                      ],
                    )
                  ],
                );
        }),
      ),
    );
  }
}
