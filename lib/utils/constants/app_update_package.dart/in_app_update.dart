import 'dart:async';
import 'package:fap_properties/views/auth/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_update/in_app_update.dart';

class InAppUpdateClass extends StatefulWidget {
  @override
  _InAppUpdateClassState createState() => _InAppUpdateClassState();
}

class _InAppUpdateClassState extends State<InAppUpdateClass> {
  AppUpdateInfo? _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool _flexibleUpdateAvailable = false;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
    }).catchError((e) {
      showSnack(e.toString());
    });
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('In App Update Example App'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Center(
                child: Text('Update info: $_updateInfo'),
              ),
              ElevatedButton(
                child: Text('Check for Update'),
                onPressed: () => checkForUpdate(),
              ),
              ElevatedButton(
                child: Text('Perform immediate update'),
                onPressed: _updateInfo?.updateAvailability ==
                        UpdateAvailability.updateAvailable
                    ? () {
                        InAppUpdate.performImmediateUpdate()
                            // ignore: invalid_return_type_for_catch_error
                            .catchError((e) => showSnack(e.toString()));
                        Get.to(()=>SplashScreen());
                      }
                    : null,
              ),
              ElevatedButton(
                child: Text('Start flexible update'),
                onPressed: _updateInfo?.updateAvailability ==
                        UpdateAvailability.updateAvailable
                    ? () {
                        InAppUpdate.startFlexibleUpdate().then((_) {
                          setState(() {
                            _flexibleUpdateAvailable = true;
                          });
                        }).catchError((e) {
                          showSnack(e.toString());
                        });
                      }
                    : null,
              ),
              ElevatedButton(
                child: Text('Complete flexible update'),
                onPressed: !_flexibleUpdateAvailable
                    ? null
                    : () {
                        InAppUpdate.completeFlexibleUpdate().then((_) {
                          showSnack("Success!");
                        }).catchError((e) {
                          showSnack(e.toString());
                        });
                      },
              )
            ],
          ),
        ),
      ),
    );
  }
}