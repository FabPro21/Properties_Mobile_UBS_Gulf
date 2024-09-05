import 'dart:typed_data';
import 'package:fap_properties/data/helpers/base_client.dart';
import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/chart_data.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_dashboard_getdata_model.dart';
import 'package:fap_properties/data/models/landlord_models/landlord_properties_model.dart';
import 'package:fap_properties/data/repository/landlord_repository.dart';
import 'package:fap_properties/utils/constants/meta_labels.dart';
import 'package:fap_properties/utils/styles/colors.dart';
import 'package:fap_properties/views/common/no_internet_screen.dart';
import 'package:get/get.dart';

class LandlordPropsWidgetController extends GetxController {
  var dashboardData = LandlordDashboardGetDataModel().obs;

  @override
  void onInit() {
    // getProperties();
    super.onInit();
  }

  RxString nameAr = "".obs;
  RxString name = "".obs;
  getDashboardData() async {
    String mystring1 = SessionController().getUserName() ?? "";
    var a1 = mystring1.trim();
    if (a1.isEmpty == false) {
      name.value = a1[0];
    } else {
      name.value = '-';
    }
    getData();
    getProperties();
  }

  var loadingData = false.obs;
  RxString error = "".obs;
  RxString openCases = "".obs;
  RxString closeCases = "".obs;
  var activeContract = 0.0.obs;
  var occupiedUnits = 0.0.obs;
  var vacantUnit = 0.0.obs;
  int toBePaidIn30DaysLength = 0;
  RxString totalUnits = "0.0".obs;
  RxString paidCurrency = "0.0".obs;
  RxInt lengthNotiification = 0.obs;
  getData() async {
    bool _isInternetConnected = await BaseClientClass.isInternetConnected();
    if (!_isInternetConnected) {
      await Get.to(NoInternetScreen());
    }
    loadingData.value = true;
    error.value = '';
    var result = await LandlordRepository.landlordDashboardGetData();
    loadingData.value = false;
    if (result == 'No internet connection') {
      await Get.to(NoInternetScreen());
    } else if (result is LandlordDashboardGetDataModel) {
      if (dashboardData.value.status == AppMetaLabels().notFound) {
        error.value = AppMetaLabels().noDatafound;
      } else {
        dashboardData.value = result;
        openCases.value = dashboardData
            .value.dashboard!.first.openCases
            .toString();
        closeCases.value = dashboardData
            .value.dashboard!.first.closeCases
            .toString();

        occupiedUnits.value =
            dashboardData.value.dashboard!.first.occupiedUnits!.toDouble();
        activeContract.value =
            dashboardData.value.dashboard!.first.activeContracts!.toDouble();
        vacantUnit.value =
            dashboardData.value.dashboard!.first.vacantUnits!.toDouble();
        totalUnits.value =
            dashboardData.value.dashboard!.first.totalUnits.toString();

        // no of notification on badge
        lengthNotiification.value = int.parse(result.unreadNotifications!);

        setData();
        update();
      }
    } else {
      error.value = AppMetaLabels().noDatafound;
    }
    loadingData.value = false;
  }

  List<ChartData> chartData = [];
  void setData() {
    double val1 = 15.0;
    double val2 = 10.0;
    if (val1 == 0 && val2 == 0) {
      val1 = 1;
      val2 = 1;
    }
    chartData = [
      ChartData(
          AppMetaLabels().occupiedUnits,
          dashboardData.value.dashboard!.first.occupiedUnits!
              .toDouble(), //val1 - val2,
          AppColors.chartDarkBlueColor),
      ChartData(
          AppMetaLabels().vacantUnits,
          dashboardData.value.dashboard!.first.vacantUnits!.toDouble(),
          AppColors.amber.withOpacity(0.2)),
    ];
  }

  LandlordPropertiesModel? propsModel;
  RxBool loadingProperties = false.obs;
  String errorLoadingProperties = '';
  int length = 0;
  void getProperties() async {
    loadingProperties.value = true;
    errorLoadingProperties = '';
    final response = await LandlordRepository.getProperties();
    print(response);
    if (response is LandlordPropertiesModel) {
      propsModel = response;
      if (propsModel!.serviceRequests!.length < 1) {
        errorLoadingProperties = AppMetaLabels().noDatafound;
      }
      if (propsModel!.serviceRequests!.length <= 3)
        length = propsModel!.serviceRequests!.length;
      else
        length = 3;
    } else
      errorLoadingProperties = response;
    loadingProperties.value = false;
  }

  Stream<Uint8List> getImage(int index) async* {
    var resp = await LandlordRepository.getImages(
        propsModel!.serviceRequests![index].buildingRefNo);
    if (resp is Uint8List) {
      yield resp;
    } else {}
  }
}
