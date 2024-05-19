// To parse this JSON data, do
//
//     final getUserRoleModel = getUserRoleModelFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../utils/constants/assets_path.dart';
import 'package:sizer/sizer.dart';

GetUserRoleModel getUserRoleModelFromJson(String str) =>
    GetUserRoleModel.fromJson(json.decode(str));

class GetUserRoleModel {
  GetUserRoleModel({
    this.data,
  });

  List<Role> data;

  factory GetUserRoleModel.fromJson(Map<String, dynamic> json) =>
      GetUserRoleModel(
        data: List<Role>.from(json["data"].map((x) => Role.fromJson(x))),
      );
}

class Role {
  Role({this.roleId, this.role, this.roleAr, this.userType, this.icon});

  int roleId;
  String role;
  String roleAr;
  String userType;
  Widget icon;

  factory Role.fromJson(Map<String, dynamic> json) {
    Widget icon;
    switch (json["roleId"]) {
      case 1:
        icon = Image.asset(
          AppImagesPath.tenant,
          width: 3.0.h,
          fit: BoxFit.contain,
        );
        break;
      case 3:
        icon = Image.asset(
          AppImagesPath.vendor,
          width: 3.0.h,
          fit: BoxFit.contain,
        );
        break;
      case 2:
        icon = Image.asset(
          AppImagesPath.landlord,
          width: 3.0.h,
          fit: BoxFit.contain,
        );
        break;
      case 4:
        icon = Image.asset(
          AppImagesPath.searchProperties,
          width: 3.0.h,
          fit: BoxFit.contain,
        );
        break;
    }
    return Role(
        roleId: json["roleId"],
        role: json["role"],
        roleAr: json['roleAR'],
        userType: json['userType'],
        icon: icon);
  }
}
