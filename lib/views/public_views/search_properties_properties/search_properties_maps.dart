import 'dart:async';
import 'package:apple_maps_flutter/apple_maps_flutter.dart' as Am;
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as Gm;
import 'package:sizer/sizer.dart';
import 'dart:io' as io;
import 'carousel_search_map.dart';

class SearchPropertiesMaps extends StatefulWidget {
  const SearchPropertiesMaps({Key key}) : super(key: key);

  @override
  _SearchPropertiesMapsState createState() => _SearchPropertiesMapsState();
}

class _SearchPropertiesMapsState extends State<SearchPropertiesMaps> {
  Completer<Gm.GoogleMapController> _mapsController = Completer();
  Completer<Am.AppleMapController> _mapsAppleController = Completer();

  Gm.CameraPosition _kGooglePlex = Gm.CameraPosition(
    target: Gm.LatLng(23.4241, 53.8478),
    zoom: 11.4746,
  );
  Am.CameraPosition _kApplePlex = Am.CameraPosition(
    target: Am.LatLng(23.4241, 53.8478),
    zoom: 11.4746,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          iconSize: 2.0.h,
          onPressed: () {
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
          AppMetaLabels().location,
          style: AppTextStyle.semiBoldWhite14,
        ),
      ),
      body: Stack(
        children: [
          io.Platform.isAndroid
              ? Gm.GoogleMap(
                  initialCameraPosition: _kGooglePlex,
                  myLocationButtonEnabled: false,
                  onMapCreated: (Gm.GoogleMapController controller) {
                    _mapsController.complete(controller);
                  },
                )
              : Am.AppleMap(
                  initialCameraPosition: _kApplePlex,
                  myLocationButtonEnabled: false,
                  onMapCreated: (Am.AppleMapController controller) {
                    _mapsAppleController.complete(controller);
                  },
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CarouselSearchMap(),
                SizedBox(
                  height: 4.0.h,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2.0.h),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 6.0.h,
                          width: 30.0.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () async {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.format_align_center,
                                  size: 2.0.h,
                                  color: Colors.black,
                                ),
                                Text(
                                  AppMetaLabels().filter,
                                  style: AppTextStyle.semiBoldBlack11,
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 6.0.h,
                            width: 23.0.w,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(0, 98, 255, 1),
                                borderRadius: BorderRadius.circular(100.0.h)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.list,
                                  size: 3.0.h,
                                  color: Colors.white,
                                ),
                                Text(
                                  AppMetaLabels().list,
                                  style: AppTextStyle.normalWhite12,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.0.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
