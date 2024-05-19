// // To parse this JSON data, do
// //
// //     final addPublicUserModel = addPublicUserModelFromJson(jsonString);

// import 'dart:convert';

// AddPublicUserModel addPublicUserModelFromJson(String str) =>
//     AddPublicUserModel.fromJson(json.decode(str));

// String addPublicUserModelToJson(AddPublicUserModel data) =>
//     json.encode(data.toJson());

// class AddPublicUserModel {
//   AddPublicUserModel({
//     this.token,
//     this.user,
//     this.message,
//     this.status,
//     this.statusCode,
//   });

//   String token;
//   User user;
//   String message;
//   String status;
//   String statusCode;

//   factory AddPublicUserModel.fromJson(Map<String, dynamic> json) =>
//       AddPublicUserModel(
//         token: json["token"],
//         user: User.fromJson(json["user"]),
//         message: json["message"],
//         status: json["status"],
//         statusCode: json["statusCode"],
//       );

//   Map<String, dynamic> toJson() => {
//         "token": token,
//         "user": user.toJson(),
//         "message": message,
//         "status": status,
//         "statusCode": statusCode,
//       };
// }

// class User {
//   User({
//     this.userId,
//     this.name,
//     this.mobile,
//     this.email,
//     this.roles,
//   });

//   int userId;
//   String name;
//   String mobile;
//   String email;
//   List<Role> roles;

//   factory User.fromJson(Map<String, dynamic> json) => User(
//         userId: json["userId"],
//         name: json["name"],
//         mobile: json["mobile"],
//         email: json["email"],
//         roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "name": name,
//         "mobile": mobile,
//         "email": email,
//         "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
//       };
// }

// class Role {
//   Role({
//     this.roleId,
//     this.role,
//   });

//   int roleId;
//   String role;

//   factory Role.fromJson(Map<String, dynamic> json) => Role(
//         roleId: json["roleId"],
//         role: json["role"],
//       );

//   Map<String, dynamic> toJson() => {
//         "roleId": roleId,
//         "role": role,
//       };
// }
