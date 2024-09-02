// import 'dart:async';
// import 'dart:io';
// import 'package:fap_properties/data/helpers/session_controller.dart';
// import 'package:fap_properties/utils/constants/assets_path.dart';
// import 'package:fap_properties/utils/constants/meta_labels.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:intl/intl.dart';
// import 'package:sizer/sizer.dart';

// import '../../../data/models/tenant_models/card_model.dart';

// class CardScanner extends StatefulWidget {
//   final File file;
//   const CardScanner({Key key, @required this.file}) : super(key: key);

//   @override
//   _CardScannerState createState() => _CardScannerState();
// }

// class _CardScannerState extends State<CardScanner>
//     with SingleTickerProviderStateMixin {
//   AnimationController _animationController;
//   bool reverse = true;
//   bool front = false;
//   bool back = false;
//   bool isScanning = false;

//   @override
//   void initState() {
//     _animationController = new AnimationController(
//         duration: new Duration(seconds: 1), vsync: this);
//     startAnimation();
//     scanImage();
//     super.initState();
//   }

//   void startAnimation() async {
//     try {
//       animateScanAnimation();
//     } catch (e) {}
//     await Future.delayed(Duration(seconds: 1));
//     startAnimation();
//   }

//   void animateScanAnimation() {
//     if (reverse) {
//       _animationController.reverse(from: 1.0);
//     } else {
//       _animationController.forward(from: 0.0);
//     }
//     reverse = !reverse;
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final image = Image.file(
//       widget.file,
//       width: 100.w,
//       height: 30.h,
//       fit: BoxFit.fitHeight,
//     );
//     return WillPopScope(
//       onWillPop: () => Future.value(false),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: Text(AppMetaLabels().scanningCard),
//           flexibleSpace: Image.asset(
//             AppImagesPath.appbarimg,
//             width: double.infinity,
//             fit: BoxFit.fill,
//           ),
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back_ios),
//             onPressed: () {
//               if (isScanning) {
//               } else {
//                 Get.back();
//               }
//             },
//             tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
//           ),
//         ),
//         body: Center(
//           child: Container(
//             height: 30.h,
//             child: Stack(
//               children: [
//                 Center(child: image),
//                 ImageScannerAnimation(
//                   image.width,
//                   animation: _animationController,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void scanImage() async {
//     print('Scan image+++++++++=====>');
//     setState(() {
//       isScanning = true;
//     });
//     final inputImage = InputImage.fromFilePath(widget.file.path);
//     final textRecognizer = TextRecognizer();
//     final RecognizedText recognizedText =
//         await textRecognizer.processImage(inputImage);

//     String? idNumber;
//     String? name;
//     String? nationality;
//     String? gender;
//     List<DateTime> dates = [];
//     String? cardNumber;
//     for (TextBlock block in recognizedText.blocks) {
//       // block.recognizedLanguages.add('ar');
//       for (TextLine line in block.lines) {
//         print(line.text);
//         if (line.text.length == 18 && line.text.contains('-')) {
//           idNumber = line.text;
//         } else if (line.text.contains('Name')) {
//           name = line.text.split(':').last.trim();
//         } else if (line.text.contains('Nationality')) {
//           nationality = line.text.split(':').last.trim();
//         } else if (line.text.contains('Sex')) {
//           gender = line.text.split(':').last.trim();
//         } else if (line.text.length == 9) {
//           cardNumber = line.text;
//         } else if (line.text.length == 10 && line.text.contains('/')) {
//           try {
//             dates.add(DateFormat('dd/MM/yyyy').parse(line.text));
//           } catch (e) {}
//         } else {
//           for (TextElement element in line.elements) {
//             if (element.text.length == 10 && element.text.contains('/')) {
//               try {
//                 dates.add(DateFormat('dd/MM/yyyy').parse(element.text));
//               } catch (e) {}
//             }
//           }
//         }
//       }
//     }

//     final cardScanModel = CardScanModel();
//     cardScanModel.idNumber = idNumber;
//     SessionController().idNumber = idNumber;
//     cardScanModel.name = name;
//     cardScanModel.nationality = nationality;
//     cardScanModel.gender = gender;
//     cardScanModel.cardNumber = cardNumber;
//     if (front == false) {
//       setState(() {
//         front = true;
//       });
//     } else {
//       setState(() {
//         back = true;
//       });
//     }

//     if (dates.length >= 2) {
//       dates.sort((a, b) => a.compareTo(b));
//       cardScanModel.dob = dates.first;
//       cardScanModel.expiry = dates.last;
//       if (dates.length == 3) {
//         cardScanModel.issuingDate = dates[1];
//       }
//     }

//     print('"""""::::::::::::::::::::::::::::::::""""""');
//     print('ID NUMBER ::::     ${cardScanModel.idNumber}');
//     print('Name      ::::     ${cardScanModel.name}');
//     print('Nationality ::::     ${cardScanModel.nationality}');
//     print('Gender    ::::     ${cardScanModel.gender}');
//     print('Card NUMBER  ::::     ${cardScanModel.cardNumber}');
//     print('DOB          ::::     ${cardScanModel.dob}');
//     print('Issuing Date ::::     ${cardScanModel.issuingDate}');
//     print('Expiry       ::::     ${cardScanModel.expiry}');
//     print('"""""::::::::::::::::::::::::::::::::""""""');

//     // await Future.delayed(Duration(seconds: 6));
//     await Future.delayed(Duration(seconds: 3));
//     setState(() {
//       isScanning = false;
//     });
//     Get.back(result: cardScanModel);
//   }
// }

// class ImageScannerAnimation extends AnimatedWidget {
//   final double width;

//   ImageScannerAnimation(this.width, {Key key, Animation<double> animation})
//       : super(key: key, listenable: animation);

//   Widget build(BuildContext context) {
//     final Animation<double> animation = listenable;
//     final scorePosition = (animation.value * 24.h);

//     Color color1 = Color(0x5532CD32);
//     Color color2 = Color(0x0032CD32);

//     if (animation.status == AnimationStatus.reverse) {
//       color1 = Color(0x0032CD32);
//       color2 = Color(0x5532CD32);
//     }

//     return new Positioned(
//         bottom: scorePosition,
//         child: new Opacity(
//             opacity: 1.0,
//             child: Container(
//               height: 60.0,
//               width: width,
//               decoration: new BoxDecoration(
//                   gradient: new LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 stops: [0.1, 0.9],
//                 colors: [color1, color2],
//               )),
//             )));
//   }
// }

// ignore_for_file: deprecated_member_use

// // with all validations
import 'dart:async';
import 'dart:io';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/utils/constants/assets_path.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/utils/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../../../data/models/tenant_models/card_model.dart';

class CardScanner extends StatefulWidget {
  final File? file;
  const CardScanner({Key? key, @required this.file}) : super(key: key);

  @override
  _CardScannerState createState() => _CardScannerState();
}

class _CardScannerState extends State<CardScanner>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  bool reverse = true;
  bool front = false;
  bool back = false;
  bool isScanning = false;

  @override
  void initState() {
    _animationController = new AnimationController(
        duration: new Duration(seconds: 1), vsync: this);
    startAnimation();
    scanImage();
    super.initState();
  }

  void startAnimation() async {
    try {
      animateScanAnimation();
    } catch (e) {}
    await Future.delayed(Duration(seconds: 1));
    startAnimation();
  }

  void animateScanAnimation() {
    if (reverse) {
      _animationController!.reverse(from: 1.0);
    } else {
      _animationController!.forward(from: 0.0);
    }
    reverse = !reverse;
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = Image.file(
      widget.file!,
      width: 100.w,
      height: 30.h,
      fit: BoxFit.fitHeight,
    );
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            AppMetaLabels().scanningCard,
            style: AppTextStyle.semiBoldWhite14,
          ),
          flexibleSpace: Image.asset(
            AppImagesPath.appbarimg,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.white54,
            ),
            onPressed: () {
              if (isScanning) {
              } else {
                Get.back();
              }
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
        body: Center(
          child: Container(
            height: 30.h,
            child: Stack(
              children: [
                Center(child: image),
                ImageScannerAnimation(
                  image.width!,
                  animation: _animationController!,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void scanImage() async {
    print('Scan image+++++++++=====>');
    setState(() {
      isScanning = true;
    });
    final inputImage = InputImage.fromFilePath(widget.file!.path);
    final textRecognizer = TextRecognizer();
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    String? idNumber;
    String? name;
    String? nationality;
    String? gender;
    List<DateTime> dates = [];
    String? cardNumber;
    var regExpForDigit = RegExp('[0-9]');
    var regExpForDash = RegExp('-');

    for (TextBlock block in recognizedText.blocks) {
      // block.recognizedLanguages.add('ar');
      for (TextLine line in block.lines) {
        print(line.text);

        // if (line.text.length == 18 && line.text.contains('-')) {
        //   idNumber = line.text;
        // }

        // *
        // for front side
        // regExpForDigit.allMatches(line.text).length > 10 &&
        // regExpForDash.allMatches(line.text).length > 1
        //  above condition implemented because system was taking some name as an ID
        if (line.text.length > 11 && line.text.contains('-')) {
          if (SessionController().idNumber == null &&
              regExpForDigit.allMatches(line.text).length > 10 &&
              regExpForDash.allMatches(line.text).length > 1) {
            idNumber = line.text;
          } else {
            print('++++++++++++++++');
          }
        } else if (line.text.contains('Name')) {
          name = line.text.split(':').last.trim();
        } else if (line.text.contains('Nationality')) {
          nationality = line.text.split(':').last.trim();
        } else if (line.text.contains('Sex')) {
          gender = line.text.split(':').last.trim();
        }
        // *
        // for back side
        else if (line.text.length == 9 &&
            line.text.contains('/') == false &&
            line.text.contains('-') == false &&
            line.text.contains(':') == false &&
            line.text.contains(',') == false &&
            regExpForDigit.allMatches(line.text).length > 6 == true) {
          cardNumber = line.text;
        }
        // else if (line.text.length == 9) {
        //   cardNumber = line.text;
        // }
        else if (line.text.length == 10 && line.text.contains('/')) {
          try {
            dates.add(DateFormat('dd/MM/yyyy').parse(line.text));
          } catch (e) {}
        } else {
          for (TextElement element in line.elements) {
            if (element.text.length == 10 && element.text.contains('/')) {
              try {
                dates.add(DateFormat('dd/MM/yyyy').parse(element.text));
              } catch (e) {}
            }
          }
        }
      }
    }

    final cardScanModel = CardScanModel();
    cardScanModel.idNumber = idNumber;
    SessionController().idNumber = idNumber;
    cardScanModel.name = name;
    cardScanModel.nationality = nationality;
    cardScanModel.gender = gender;
    cardScanModel.cardNumber = cardNumber;
    if (front == false) {
      setState(() {
        front = true;
      });
    } else {
      setState(() {
        back = true;
      });
    }

    if (dates.length >= 2) {
      dates.sort((a, b) => a.compareTo(b));
      cardScanModel.dob = dates.first;
      cardScanModel.expiry = dates.last;
      if (dates.length == 3) {
        cardScanModel.issuingDate = dates[1];
      }
    }

    print('"""""::::::::::::::::::::::::::::::::""""""');
    print('ID NUMBER ::::     ${cardScanModel.idNumber}');
    print('Name      ::::     ${cardScanModel.name}');
    print('Nationality ::::     ${cardScanModel.nationality}');
    print('Gender    ::::     ${cardScanModel.gender}');
    print('Card NUMBER  ::::     ${cardScanModel.cardNumber}');
    print('DOB          ::::     ${cardScanModel.dob}');
    print('Issuing Date ::::     ${cardScanModel.issuingDate}');
    print('Expiry       ::::     ${cardScanModel.expiry}');
    print('"""""::::::::::::::::::::::::::::::::""""""');

    // await Future.delayed(Duration(seconds: 6));
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      isScanning = false;
    });
    Get.back(result: cardScanModel);
  }
}

class ImageScannerAnimation extends AnimatedWidget {
  final double width;

  ImageScannerAnimation(this.width, {Key? key, Animation<double>? animation})
      : super(key: key, listenable: animation!);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable as Animation<double>;
    final scorePosition = (animation.value * 24.h);

    Color color1 = Color(0x5532CD32);
    Color color2 = Color(0x0032CD32);

    if (animation.status == AnimationStatus.reverse) {
      color1 = Color(0x0032CD32);
      color2 = Color(0x5532CD32);
    }

    return new Positioned(
        bottom: scorePosition,
        child: new Opacity(
            opacity: 1.0,
            child: Container(
              height: 60.0,
              width: width,
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.9],
                colors: [color1, color2],
              )),
            )));
  }
}
