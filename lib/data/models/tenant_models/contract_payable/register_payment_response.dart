// To parse this JSON data, do
//
//     final registerPaymentResponse = registerPaymentResponseFromJson(jsonString);

import 'dart:convert';

RegisterPaymentResponse registerPaymentResponseFromJson(String? str) =>
    RegisterPaymentResponse.fromJson(json.decode(str!));

String? registerPaymentResponseToJson(RegisterPaymentResponse data) =>
    json.encode(data.toJson());

class RegisterPaymentResponse {
  RegisterPaymentResponse({
    this.orderId,
    this.transactionId,
    this.url,
    this.status,
  });

  int? orderId;
  String? transactionId;
  String? url;
  String? status;

  factory RegisterPaymentResponse.fromJson(Map<String?, dynamic> json) =>
      RegisterPaymentResponse(
        orderId: json["orderId"],
        transactionId: json["transactionID"],
        url: json["url"],
        status: json["status"],
      );

  Map<String?, dynamic> toJson() => {
        "orderId": orderId,
        "transactionID": transactionId,
        "url": url,
        "status": status,
      };
}
