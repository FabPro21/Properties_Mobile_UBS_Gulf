// To parse this JSON data, do
//
//     final paymentMethods = paymentMethodsFromJson(jsonString);

import 'dart:convert';

PaymentMethods paymentMethodsFromJson(String? str) =>
    PaymentMethods.fromJson(json.decode(str!));

String? paymentMethodsToJson(PaymentMethods data) => json.encode(data.toJson());

class PaymentMethods {
  PaymentMethods({
    this.status,
    this.statusCode,
    this.payments,
    this.message,
  });

  String? status;
  String? statusCode;
  List<Payment>? payments;
  String? message;

  factory PaymentMethods.fromJson(Map<String?, dynamic> json) => PaymentMethods(
        status: json["status"],
        statusCode: json["statusCode"],
        payments: List<Payment>.from(
            json["payments"].map((x) => Payment.fromJson(x))),
        message: json["message"],
      );

  Map<String?, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "payments": List<dynamic>.from(payments!.map((x) => x.toJson())),
        "message": message,
      };
}

class Payment {
  Payment({
    this.paymentMethodId,
    this.name,
  });

  int? paymentMethodId;
  String? name;

  factory Payment.fromJson(Map<String?, dynamic> json) => Payment(
        paymentMethodId: json["paymentMethodId"],
        name: json["name"],
      );

  Map<String?, dynamic> toJson() => {
        "paymentMethodId": paymentMethodId,
        "name": name,
      };
}
