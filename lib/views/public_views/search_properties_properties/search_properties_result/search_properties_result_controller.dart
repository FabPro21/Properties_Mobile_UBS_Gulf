import 'dart:typed_data';
import 'package:fap_properties/data/helpers/base_client.dart';

import 'package:fap_properties/data/repository/public_repository.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';
import '../../../../data/models/public_models/get_properties_model.dart';
import '../../../../data/models/public_models/public_booking_request/public_bookingreq_get_images_model.dart';

class SearchPropertiesResultController extends GetxController {
  var data = GetPropertiesModel();
  var getBRImages = PublicBookingReqGetImageModel();
  var loadingData = true.obs;
  RxString error = "".obs;
  List<Property> properties = [];
  List<PropertyImage> propertiesImages = [];
  List<Property> propertiesLoadMore = [];

  String sortedBy = '';

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getData(String propName, minRentAmount, maxRentAmount, areaType,
      minAreaSize, maxAreaSize, minRoom, maxRoom, pagenum) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {
    loadingData.value = true;
    var result = await PublicRepositoryDrop2.getProperties(
        propName,
        minRentAmount,
        maxRentAmount,
        areaType,
        minAreaSize,
        maxAreaSize,
        minRoom,
        maxRoom,
        pagenum);
    loadingData.value = false;
    if (result is GetPropertiesModel) {
      data = result;
      properties = data.property!.toList();
      update();
    } else {
      error.value = result;
    }
  }

  List<Stream<Uint8List>>? propertiesImageU8;
  Future<void> getDataPagination(String propName, minRentAmount, maxRentAmount,
      areaType, minAreaSize, maxAreaSize, minRoom, maxRoom, pageNo) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    // try {
    loadingData.value = true;
    var result = await PublicRepositoryDrop2.getPropertiesPagination(
        propName,
        minRentAmount,
        maxRentAmount,
        areaType,
        minAreaSize,
        maxAreaSize,
        minRoom,
        maxRoom,
        pageNo);
    loadingData.value = false;
    if (result is GetPropertiesModel) {
      data = result;
      properties = data.property!.toList();
      update();
    } else {
      error.value = result;
    }
  }

  RxString noMoreDataError = ''.obs;
  RxBool isLoadingMore = false.obs;
  String pageNo = '1';
  Future<void> getDataPaginationLoadMore(
    String propName,
    minRentAmount,
    maxRentAmount,
    areaType,
    minAreaSize,
    maxAreaSize,
    minRoom,
    maxRoom,
    pageNo,
  ) async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(() => NoInternetScreen());
    }
    try {
      // because when we click on sorting
      // we sort  the properties list and after that we set the label sortedBy oppsite
      // means if sortedBy = 'asc' then will set sorted = 'des' and is 'des' then will set 'asc'
      // => so for load more we opposit the above situation
      if (sortedBy == 'des') {
        sortedBy = 'asc';
      } else {
        sortedBy = 'des';
      }
      propertiesLoadMore.clear();
      isLoadingMore.value = true;
      var result = await PublicRepositoryDrop2.getPropertiesPagination(
          propName,
          minRentAmount,
          maxRentAmount,
          areaType,
          minAreaSize,
          maxAreaSize,
          minRoom,
          maxRoom,
          pageNo);

      if (result is GetPropertiesModel) {
        data = result;
        for (int i = 0; i < data.property!.length; i++) {
          properties.add(data.property![i]);
          propertiesLoadMore.add(data.property![i]);
        }

        await sortListLoadMore();
        await Future.delayed(Duration(seconds: 2));
        isLoadingMore.value = false;
        update();
      } else {
        noMoreDataError.value = result;
        await Future.delayed(Duration(seconds: 2));
        isLoadingMore.value = false;
      }
    } catch (e) {
      print('Exception :::: $e');
    }
  }
  // RxString noMoreDataError = ''.obs;
  // RxBool isLoadingMore = false.obs;
  // String pageNo = '1';
  // Future<void> getDataPaginationLoadMore(
  //   String propName,
  //   minRentAmount,
  //   maxRentAmount,
  //   areaType,
  //   minAreaSize,
  //   maxAreaSize,
  //   minRoom,
  //   maxRoom,
  //   pageNo,
  // ) async {
  //   bool _isInternetConnected = await BaseClientClass.isInternetConnected();
  //   if (!_isInternetConnected) {
  //     await Get.to(() => NoInternetScreen());
  //   }
  //   // try {
  //   propertiesLoadMore.clear();
  //   isLoadingMore.value = true;
  //   var result = await PublicRepositoryDrop2.getPropertiesPagination(
  //       propName,
  //       minRentAmount,
  //       maxRentAmount,
  //       areaType,
  //       minAreaSize,
  //       maxAreaSize,
  //       minRoom,
  //       maxRoom,
  //       pageNo);
  //   isLoadingMore.value = false;
  //   if (result is GetPropertiesModel) {
  //     data = result;
  //     for (int i = 0; i < data.property!.length; i++) {
  //       properties.add(data.property![i]);
  //       propertiesLoadMore.add(data.property![i]);
  //     }
  //     update();
  //   } else {
  //     noMoreDataError.value = result;

  //   }
  // }

  void sortList() {
    loadingData.value = true;
    if (sortedBy == 'asc') {
      properties.sort((a, b) => a.rentPerAnnumMin!.compareTo(b.rentPerAnnumMin!));
      sortedBy = 'des';
    } else {
      properties.sort((a, b) => b.rentPerAnnumMin!.compareTo(a.rentPerAnnumMin!));
      sortedBy = 'asc';
    }
    loadingData.value = false;
  }

  Future sortListLoadMore() async {
    loadingData.value = true;
    if (sortedBy == 'asc') {
      properties.sort((a, b) => a.rentPerAnnumMin!.compareTo(b.rentPerAnnumMin!));
      propertiesLoadMore
          .sort((a, b) => a.rentPerAnnumMin!.compareTo(b.rentPerAnnumMin!));
      sortedBy = 'des';
    } else {
      properties.sort((a, b) => b.rentPerAnnumMin!.compareTo(a.rentPerAnnumMin!));
      propertiesLoadMore
          .sort((a, b) => b.rentPerAnnumMin!.compareTo(a.rentPerAnnumMin!));
      sortedBy = 'asc';
    }
    loadingData.value = false;
  }

  Stream<Uint8List> getPropertyImage(int index) async* {
    var resp = await PublicRepositoryDrop2.getBookingreqImagesProperty(
        properties[index].propertyId);
    // var resp = await PublicRepositoryDrop2.getBookingreqImagesProperty(
    //     data.property![index].propertyId);
    if (resp is Uint8List) {
      yield resp;
    } else {}
  }

  Stream<Uint8List> getUnitImage(int index) async* {
    var resp = await PublicRepositoryDrop2.getBookingreqImages(
        data.property![index].unitID??0);
    if (resp is Uint8List) {
      yield resp;
    } else {}
  }

  // Future<Uint8List> getPropertyImageN(int propertyId) async {
  //   if (propertiesImages.isEmpty) {
  //     var resp =
  //         await PublicRepositoryDrop2.getBookingreqImagesProperty(propertyId);
  //     if (resp is Uint8List) {
  //       propertiesImages.add(PropertyImage(propertyId.toString(), resp));
  //       return resp;
  //     } else {
  //       propertiesImages.add(PropertyImage(propertyId.toString(), null));
  //     }
  //   } else {
  //     bool isApiCall = true;
  //     Uint8List propertyImage;
  //     for (int i = 0; i < propertiesImages.length; i++) {
  //       if ((propertiesImages[i].propertyID == propertyId.toString())) {
  //         isApiCall = false;
  //         propertyImage = propertiesImages[i].propertyImage;
  //         update();
  //       }
  //     }
  //     if (isApiCall == false) {
  //       return propertyImage;
  //     } else {
  //       var resp =
  //           await PublicRepositoryDrop2.getBookingreqImagesProperty(propertyId);
  //       if (resp is Uint8List) {
  //         propertiesImages.add(PropertyImage(propertyId.toString(), resp));
  //         return resp;
  //       } else {
  //         propertiesImages.add(PropertyImage(propertyId.toString(), null));
  //       }
  //     }
  //   }
  // }
  Stream<Uint8List> getPropertyImageN(int propertyId) async* {
    if (propertiesImages.isEmpty) {
      var resp =
          await PublicRepositoryDrop2.getBookingreqImagesProperty(propertyId);
      if (resp is Uint8List) {
        propertiesImages.add(PropertyImage(propertyId.toString(), resp));

        yield resp;
      } else {
        propertiesImages.add(PropertyImage(propertyId.toString(), Uint8List(0)));
      }
    } else {
      bool isApiCall = true;
      Uint8List? propertyImage;
      for (int i = 0; i < propertiesImages.length; i++) {
        if ((propertiesImages[i].propertyID == propertyId.toString())) {
          isApiCall = false;
          propertyImage = propertiesImages[i].propertyImage;
          update();
        }
      }
      if (isApiCall == false) {
        yield propertyImage!;
        return;
      } else {
        var resp =
            await PublicRepositoryDrop2.getBookingreqImagesProperty(propertyId);
        if (resp is Uint8List) {
          propertiesImages.add(PropertyImage(propertyId.toString(), resp));
          yield resp;
        } else {
          propertiesImages.add(PropertyImage(propertyId.toString(), Uint8List(0)));
        }
      }
    }
  }

  Stream<Uint8List> getPropertyImageN1(int propertyId) async* {
    if (propertiesImages.isEmpty) {
      var resp =
          await PublicRepositoryDrop2.getBookingreqImagesProperty(propertyId);
      if (resp is Uint8List) {
        propertiesImages.add(PropertyImage(propertyId.toString(), resp));
        yield resp;
      } else {
        propertiesImages.add(PropertyImage(propertyId.toString(), Uint8List(0)));
        // propertiesImages.add(PropertyImage(propertyId.toString(), null));
      }
    } else {
      bool isApiCall = true;
      Uint8List? propertyImage;
      for (int i = 0; i < propertiesImages.length; i++) {
        if ((propertiesImages[i].propertyID == propertyId.toString())) {
          isApiCall = false;
          propertyImage = propertiesImages[i].propertyImage;
          update();
        }
      }
      if (isApiCall == false) {
        yield propertyImage!;
        return;
      } else {
        var resp =
            await PublicRepositoryDrop2.getBookingreqImagesProperty(propertyId);
        if (resp is Uint8List) {
          propertiesImages.add(PropertyImage(propertyId.toString(), resp));
          yield resp;
        } else {
          propertiesImages.add(PropertyImage(propertyId.toString(), Uint8List(0)));
        }
      }
    }
  }
}

class PropertyImage {
  PropertyImage(
    this.propertyID,
    this.propertyImage,
  );

  String propertyID;
  Uint8List propertyImage;
}
