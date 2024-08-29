import 'dart:typed_data';

class CardScanModel {
  String? name;
  String? idNumber;
  String? nationality;
  // String? issuingDate;
  // String? dob;
  // String? expiry;
  DateTime? issuingDate;
  DateTime? dob;
  DateTime? expiry;
  String? gender;
  String? cardNumber;
  Uint8List? frontImage;
  Uint8List? backImage;


  CardScanModel({
    this.name,
    this.idNumber,
    this.nationality,
    this.issuingDate,
    this.gender,
    this.dob,
    this.expiry,
    this.cardNumber,
    this.frontImage,
    this.backImage,
  });

  // bool scanFront() {
  //   if(idNumber == null && name == null && nationality == null){
  //     return true;
  //   }else{
  //     return false;
  //   }
  // }

  bool scanFront() {
    return idNumber == null;
  }

  bool scanBack() {
    return cardNumber == null;
  }

  bool bothSidesScannedSuccessfully() {
    return name != null &&
        expiry != null &&
        dob != null &&
        frontImage != null &&
        backImage != null;
  }
}
