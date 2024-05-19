import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/landlord_models/property_filter.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_contracts_filter/filter_data.dart';
import 'package:fap_properties/data/services/landlord_services/download_report_file.dart';
import 'package:fap_properties/data/services/landlord_services/get_contract_cheque.dart';
import 'package:fap_properties/data/services/landlord_services/get_landlord_charges_recipt.dart';
import 'package:fap_properties/data/services/landlord_services/get_landlord_charges_screen.dart';
import 'package:fap_properties/data/services/landlord_services/invoice_service.dart';
import 'package:fap_properties/data/services/landlord_services/landLord_faqs.dart';
import 'package:fap_properties/data/services/landlord_services/landlord_contract_status_service.dart';
import 'package:fap_properties/data/services/landlord_services/landlord_db_getdata.dart';
import 'package:fap_properties/data/services/landlord_services/landlord_emirate_service.dart';
import 'package:fap_properties/data/services/landlord_services/landlord_get_contract_details_service.dart';
import 'package:fap_properties/data/services/landlord_services/landlord_get_contract_payment.dart';
import 'package:fap_properties/data/services/landlord_services/landlord_get_contracts_service.dart';
import 'package:fap_properties/data/services/landlord_services/landlord_get_image.dart';
import 'package:fap_properties/data/services/landlord_services/landlord_notification/landlord_archieve_notification.dart';
import 'package:fap_properties/data/services/landlord_services/landlord_notification/landlord_download_notification.dart';
import 'package:fap_properties/data/services/landlord_services/landlord_notification/landlord_notification_detail.dart';
import 'package:fap_properties/data/services/landlord_services/landlord_notification/landlord_notification_get.dart';
import 'package:fap_properties/data/services/landlord_services/landlord_notification/landlord_notification_get_file.dart';
import 'package:fap_properties/data/services/landlord_services/landlord_notification/landlord_read_notification.dart';
import 'package:fap_properties/data/services/landlord_services/landlord_property_category_service.dart';
import 'package:fap_properties/data/services/landlord_services/landlord_property_filter.dart';
import 'package:fap_properties/data/services/landlord_services/landlord_property_service.dart';
import 'package:fap_properties/data/services/landlord_services/landlord_service/landlord_profile.dart';
import 'package:fap_properties/data/services/landlord_services/payment_download_receipt.dart';
import 'package:fap_properties/data/services/tenant_services/unverfied_contract_payment_service.dart';
import '../services/landlord_services/landlord_get_contract_charges_service.dart';
import '../services/landlord_services/landlord_get_contract_units_service.dart';
import '../services/landlord_services/landlord_get_properties_service.dart';
import '../services/landlord_services/landlord_get_property_units_service.dart';

class LandlordRepository {
  // Contracts
  static Future<dynamic> getContracts(String pageNoP, searchText) =>
      LandlordGetContractsServices.getContracts(pageNoP, searchText);
  static Future<dynamic> getContractsWithFilter(
          FilterData filterData, String pageNoP) =>
      LandlordGetContractsServices.getContractsWithFilter(filterData, pageNoP);
  static Future<dynamic> getContractStatus() =>
      GetLandLordContractsStatusService.getContractStatus();
  static Future<dynamic> getPropertyTypes() =>
      GetLandlordPropertyTypesService.getPropertyTypes();
  static Future<dynamic> getEmirate() => GetLandlordEmirateService.getEmirate();
  static Future<dynamic> getPropertyCategory() =>
      GetLandlordCategoryService.getPropertyCategory();
  static Future<dynamic> getPropertyWithFilter(
          PFilterData pFilterData, String pageNoP) =>
      GetLandlordPropertyWithFilterService.getPropertyWithFilter(
          pFilterData, pageNoP);
  static Future<dynamic> getContractDetails(int contractID) =>
      LandlordGetContractDetailsServices.getContractDetails(contractID);
  static Future<dynamic> getContractPayable(int contractId) =>
      LandlordGetContractDetailsServices.getContractPayable(contractId);
  static Future<dynamic> getContractUnits(int contractID) =>
      LandlordGetContractUnitsServices.getContractUnits(contractID);
  static Future<dynamic> getContractCharges(int contractID) =>
      LandlordGetContractChargesServices.getContractCharges(contractID);

// GetData Dashboard
  static Future<dynamic> landlordDashboardGetData() =>
      LandlordDashboardGetDataServices.getData();
  // Properties
  static Future<dynamic> getProperties() =>
      LandlordGetPropertiesServices.getProperties();
  static Future<dynamic> getPropertiespagination(String pageNoP, searchtext) =>
      LandlordGetPropertiesServices.getPropertiespagination(
          pageNoP, searchtext);

  static Future<dynamic> getImages(int unitId) =>
      LandLordGetImagesServices.getImages(unitId);
  static Future<dynamic> getPropertyUnits(String propertyId) =>
      LandlordGetPropertyUnitsServices.getPropertyUnits(propertyId);
  static Future<dynamic> getPropertyDetail(String propertyId) =>
      LandlordGetPropertyUnitsServices.getPropertyDetail(propertyId);
  static Future<dynamic> getPropertyUnitDetail(String propertyId) =>
      LandlordGetPropertyUnitsServices.getPropertyUnitDetail(propertyId);

  // Notification
  static Future<dynamic> getNotifications(String status) =>
      GetLandLordtNotificationsServices.getNotifications(status);
  static Future<dynamic> getNotificationsPagination(String status, pageSize) =>
      GetLandLordtNotificationsServices.getNotificationsPagination(
          status, pageSize);
  static Future<dynamic> readNotification() =>
      LandLordReadNotificationsServices.readNotification();
  static Future<dynamic> archiveNotification() =>
      LandlordArchiveNotificationsServices.archiveNotification();
  static Future<dynamic> notificationDetails() =>
      LandLordNotificationsDetailServices.notificationDetails(
          SessionController().getNotificationId());
  static Future<dynamic> downloadNotificationFiles(int id) =>
      DownloadLandLordNotificationsFiles.downloadNotificationFiles(id);
  static Future<dynamic> getNotificationFiles(int id) =>
      GetLandLordNotificationsFiles.getNotificationFiles(id);

  // Profile
  static Future<dynamic> landLordProfile() =>
      LandLordProfileServices.landLordProfile();
  static Future<dynamic> canEditProfile() =>
      LandLordProfileServices.canEditProfile();
  static Future<dynamic> updateProfile(
          String name, String mobileNo, String email, String address) =>
      LandLordProfileServices.updateProfile(name, mobileNo, email, address);

  // Faqs
  static Future<dynamic> getFaqs() => LandLordFaqsSerice.getFaqs();
  static Future<dynamic> getFaqsQuestions(int categoryId) =>
      LandLordFaqsSerice.getFaqsQuestions(categoryId);

  static Future<dynamic> contractPayments() =>
      LandlordContractPaymentsServices.getData();
  static Future<dynamic> getUnverifiedPayments() =>
      UnverfiedContractPaymentServices.getData();
  static Future<dynamic> getCheque(String transId) =>
      GetContractChequesServicesLandLord.getData(transId);
  static Future<dynamic> paymentsDownloadReceipt() =>
      PaymentDownloadReceiptServiceLandlord.getData();

  static Future<dynamic> getCharges() => GetLandlordCChargesServices.getData();
  static Future<dynamic> getContractChargeReceipts(int chargesTypeId) =>
      LandlordCChargeReceiptsService.getData(chargesTypeId);

  // Reports
  static Future<dynamic> downloadReportFile(String fileName, Map data) =>
      LandlordDownloadReportServices.downloadReportFile(fileName, data);
  static Future<dynamic> downloadTicketFileBase64(String fileName, Map data) =>
      LandlordDownloadReportServices.downloadReportFileBase64(fileName, data);
  static Future<dynamic> getDropDownType(String type) =>
      LandlordDownloadReportServices.getDropDownType(type);
  static Future<dynamic> getAMCreportSummary(Map data) =>
      LandlordDownloadReportServices.getAMCreportSummary(data);
  static Future<dynamic> getreportSummary(Map data,String reportName) =>
      LandlordDownloadReportServices.getreportSummary(data,reportName);
  static Future<dynamic> getLPOSummary(Map data) =>
      LandlordDownloadReportServices.getLPOSummary(data);

  // Invoice
  static Future<dynamic> getAllInvoicesPagination(String pageNoP, searchtext) =>
      LandlordInvoiceServices.getDataPagination(pageNoP, searchtext);
}
