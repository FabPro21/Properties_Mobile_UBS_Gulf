// To parse this JSON data, do
//
//     final vendorDashboardAllInvoicesModel = vendorDashboardAllInvoicesModelFromJson(jsonString);

import 'dart:convert';

VendorDashboardAllInvoicesModel vendorDashboardAllInvoicesModelFromJson(String str) => VendorDashboardAllInvoicesModel.fromJson(json.decode(str));

String vendorDashboardAllInvoicesModelToJson(VendorDashboardAllInvoicesModel data) => json.encode(data.toJson());

class VendorDashboardAllInvoicesModel {
    VendorDashboardAllInvoicesModel({
        this.status,
        this.statusNameAR,
        this.statusCode,
        this.invoice,
        this.message,
    });

    String status;
    String statusNameAR;
    String statusCode;
    List<Invoice> invoice;
    String message;

    factory VendorDashboardAllInvoicesModel.fromJson(Map<String, dynamic> json) => VendorDashboardAllInvoicesModel(
        status: json["status"],
        statusNameAR: json["statusNameAR"],
        statusCode: json["statusCode"],
        invoice: List<Invoice>.from(json["invoice"].map((x) => Invoice.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "statusNameAR": statusNameAR,
        "statusCode": statusCode,
        "invoice": List<dynamic>.from(invoice.map((x) => x.toJson())),
        "message": message,
    };
}

class Invoice {
    Invoice({
        this.contractNo,
        this.supplierRefNo,
        this.requestDate,
        this.invoiceNumber,
        this.invoiceDate,
        this.invoiceAmount,
        this.statusName,
        this.statusNameAR,
    });

    dynamic contractNo;
    dynamic supplierRefNo;
    dynamic requestDate;
    String invoiceNumber;
    String invoiceDate;
    double invoiceAmount;
    String statusName;
    String statusNameAR;

    factory Invoice.fromJson(Map<String, dynamic> json) => Invoice(
        contractNo: json["contractNO"],
        supplierRefNo: json["supplierRefNo"],
        requestDate: json["requestDate"],
        invoiceNumber: json["invoiceNumber"],
        invoiceDate: json["invoiceDate"],
        invoiceAmount: json["invoiceAmount"].toDouble(),
        statusName: json["statusName"],
        statusNameAR: json["statusNameAR"],
    );

    Map<String, dynamic> toJson() => {
        "contractNO": contractNo,
        "supplierRefNo": supplierRefNo,
        "requestDate": requestDate,
        "invoiceNumber": invoiceNumber,
        "invoiceDate": invoiceDateValues.reverse[invoiceDate],
        "invoiceAmount": invoiceAmount,
        "statusName": statusNameValues.reverse[statusName],
        "statusNameAR": statusNameValues.reverse[statusName],
    };
}

enum InvoiceDate { THE_22032016, THE_31012016, THE_29022016 }

final invoiceDateValues = EnumValues({
    "22-03-2016": InvoiceDate.THE_22032016,
    "29-02-2016": InvoiceDate.THE_29022016,
    "31-01-2016": InvoiceDate.THE_31012016
});

enum StatusName { UNDER_REVIEW, UNDER_APPROVAL, DRAFT }

final statusNameValues = EnumValues({
    "Draft": StatusName.DRAFT,
    "Under Approval": StatusName.UNDER_APPROVAL,
    "Under Review": StatusName.UNDER_REVIEW
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
