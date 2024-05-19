// class GetMetaDataModel {
//   GetMetaDataModel({
//     this.statusCode,
//     this.status,
//     this.version,
//     this.language,
//     this.metadata,
//     this.message,
//   });

//   String statusCode;
//   String status;
//   String version;
//   String language;
//   List<Metadatum> metadata;
//   String message;

//   factory GetMetaDataModel.fromJson(Map<String, dynamic> json) =>
//       GetMetaDataModel(
//         statusCode: json["statusCode"],
//         status: json["status"],
//         version: json["version"],
//         language: json["language"],
//         metadata: List<Metadatum>.from(
//             json["metadata"].map((x) => Metadatum.fromJson(x))),
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "statusCode": statusCode,
//         "status": status,
//         "version": version,
//         "language": language,
//         "metadata": List<dynamic>.from(metadata!.map((x) => x.toJson())),
//         "message": message,
//       };
// }

// class Metadatum {
//   Metadatum({
//     this.dashboard,
//     this.loginScreen,
//     this.contracts,
//   });

//   Dashboard dashboard;
//   LoginScreen loginScreen;
//   Contracts contracts;

//   factory Metadatum.fromJson(Map<String, dynamic> json) => Metadatum(
//         dashboard: json["Dashboard"] == null
//              null
//             : Dashboard.fromJson(json["Dashboard"]),
//         loginScreen: json["Login Screen"] == null
//              null
//             : LoginScreen.fromJson(json["Login Screen"]),
//         contracts: json["Contracts"] == null
//              null
//             : Contracts.fromJson(json["Contracts"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "Dashboard": dashboard == null  null : dashboard!.toJson(),
//         "Login Screen": loginScreen == null  null : loginScreen!.toJson(),
//         "Contracts": contracts == null  null : contracts!.toJson(),
//       };
// }

// class Contracts {
//   Contracts({
//     this.contractList,
//     this.contractDetails,
//   });

//   String contractList;
//   String contractDetails;

//   factory Contracts.fromJson(Map<String, dynamic> json) => Contracts(
//         contractList: json["ContractList"],
//         contractDetails: json["ContractDetails"],
//       );

//   Map<String, dynamic> toJson() => {
//         "ContractList": contractList,
//         "ContractDetails": contractDetails,
//       };
// }

// class Dashboard {
//   Dashboard({
//     this.next30Days,
//     this.paymentbalance,
//     this.welcome,
//     this.balance,
//     this.tobepaid,
//     this.paid,
//     this.contractexpiring,
//     this.chequesdue,
//     this.aed,
//     this.yourcontracts,
//     this.dashboard,
//     this.managecontracts,
//     this.managepayments,
//     this.unit,
//     this.startdate,
//     this.enddate,
//     this.servicerequests,
//     this.addrequest,
//     this.payments,
//     this.services,
//     this.contracts,
//     this.profile,
//   });

//   String next30Days;
//   String paymentbalance;
//   String welcome;
//   String balance;
//   String tobepaid;
//   String paid;
//   String contractexpiring;
//   String chequesdue;
//   String aed;
//   String yourcontracts;
//   String dashboard;
//   String managecontracts;
//   String managepayments;
//   String unit;
//   String startdate;
//   String enddate;
//   String servicerequests;
//   String addrequest;
//   String payments;
//   String services;
//   String contracts;
//   String profile;

//   factory Dashboard.fromJson(Map<String, dynamic> json) => Dashboard(
//         next30Days: json["next30days"],
//         paymentbalance: json["paymentbalance"],
//         welcome: json["welcome"],
//         balance: json["balance"],
//         tobepaid: json["tobepaid"],
//         paid: json["paid"],
//         contractexpiring: json["contractexpiring"],
//         chequesdue: json["chequesdue"],
//         aed: json["aed"],
//         yourcontracts: json["yourcontracts"],
//         dashboard: json["dashboard"],
//         managecontracts: json["managecontracts"],
//         managepayments: json["managepayments"],
//         unit: json["unit"],
//         startdate: json["startdate"],
//         enddate: json["enddate"],
//         servicerequests: json["servicerequests"],
//         addrequest: json["addrequest"],
//         payments: json["payments"],
//         services: json["services"],
//         contracts: json["contracts"],
//         profile: json["profile"],
//       );

//   Map<String, dynamic> toJson() => {
//         "next30days": next30Days,
//         "paymentbalance": paymentbalance,
//         "welcome": welcome,
//         "balance": balance,
//         "tobepaid": tobepaid,
//         "paid": paid,
//         "contractexpiring": contractexpiring,
//         "chequesdue": chequesdue,
//         "aed": aed,
//         "yourcontracts": yourcontracts,
//         "dashboard": dashboard,
//         "managecontracts": managecontracts,
//         "managepayments": managepayments,
//         "unit": unit,
//         "startdate": startdate,
//         "enddate": enddate,
//         "servicerequests": servicerequests,
//         "addrequest": addrequest,
//         "payments": payments,
//         "services": services,
//         "contracts": contracts,
//         "profile": profile,
//       };
// }

// class LoginScreen {
//   LoginScreen({
//     this.otpText,
//     this.mobileNo,
//   });

//   String otpText;
//   String mobileNo;

//   factory LoginScreen.fromJson(Map<String, dynamic> json) => LoginScreen(
//         otpText: json["OtpText"],
//         mobileNo: json["MobileNo"],
//       );

//   Map<String, dynamic> toJson() => {
//         "OtpText": otpText,
//         "MobileNo": mobileNo,
//       };
// }
