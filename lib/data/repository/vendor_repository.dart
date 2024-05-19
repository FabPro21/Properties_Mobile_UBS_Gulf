import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/vendor_models/get_all_lpos_model.dart';
import 'package:fap_properties/data/models/vendor_models/get_vendor_contracts_status_model.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_contracts_filter/get_contracts_status_service.dart';
import 'package:fap_properties/data/services/vendor_services/lpo_invoices_services.dart';
import 'package:fap_properties/data/services/vendor_services/contract_invoices_services.dart';
import 'package:fap_properties/data/services/vendor_services/get_all_lpos_services.dart';
import 'package:fap_properties/data/services/vendor_services/get_lpo_data_svc.dart';
import 'package:fap_properties/data/services/vendor_services/get_lpo_details_svc.dart';
import 'package:fap_properties/data/services/vendor_services/get_lpo_properties_services.dart';
import 'package:fap_properties/data/services/vendor_services/get_lpo_services.dart';
import 'package:fap_properties/data/services/vendor_services/get_lpo_status_service.dart';
import 'package:fap_properties/data/services/vendor_services/get_lpo_terms_svc.dart';
import 'package:fap_properties/data/services/vendor_services/get_lpos_with_filter_service.dart';
import 'package:fap_properties/data/services/vendor_services/get_vendor_accounts_service.dart';
import 'package:fap_properties/data/services/vendor_services/get_vendor_profile_cvs.dart';
import 'package:fap_properties/data/services/vendor_services/profile/update_profile_request_service.dart';
import 'package:fap_properties/data/services/vendor_services/service_req_chat/add_ticket_service.dart';
import 'package:fap_properties/data/services/vendor_services/service_req_chat/download_ticket_files.dart';
import 'package:fap_properties/data/services/vendor_services/service_req_chat/get_tickets_service.dart';
import 'package:fap_properties/data/services/vendor_services/service_requests/close_svc_req.dart';
import 'package:fap_properties/data/services/vendor_services/service_requests/contractor_rejected_case.dart';
import 'package:fap_properties/data/services/vendor_services/service_requests/download_doc.dart';
import 'package:fap_properties/data/services/vendor_services/service_requests/get_docs_by_type.dart';
import 'package:fap_properties/data/services/vendor_services/service_requests/get_req_photos.dart';
import 'package:fap_properties/data/services/vendor_services/service_requests/get_req_docs.dart';
import 'package:fap_properties/data/services/vendor_services/service_requests/remove_photo.dart';
import 'package:fap_properties/data/services/vendor_services/service_requests/upload_svc_req_file.dart';
import 'package:fap_properties/data/services/vendor_services/service_requests/upload_tenant_sign.dart';
import 'package:fap_properties/data/services/vendor_services/service_requests/upload_vendor_sign.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_contract_status.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_dashboard_all_invoices/contract_dashboard_all_invoices_services.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_faqs/vendor_faqs_categories_service.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_faqs/vendor_faqs_quesion_and_description_service.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_financial_terms_sercives.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_get_contact_persons_model.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_get_contract_details_services.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_get_contracts_prop.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_get_contracts_services.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_get_contracts_with_filter_services.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_get_data_svc.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_get_propertyimage.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_notifications/get_vendor_notifications_services.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_notifications/vendor_archive_notifications_services.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_notifications/vendor_notifications_detail_services.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_notifications/vendor_read_notifications_services.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_offers/vendor_offer_details_service.dart';
import 'package:fap_properties/data/services/vendor_services/vendor_offers/vendor_offers_service.dart';

import '../services/vendor_services/create_invoice_sr.dart';
import '../services/vendor_services/get_vendor_service_request_details_services.dart';
import '../services/vendor_services/get_vendor_service_requests_services.dart';
import '../services/vendor_services/service_requests/acknowledge_case.dart';
import '../services/vendor_services/service_requests/update_svc_req_file.dart';

class VendorRepository {
  static Future<dynamic> getData() => VendorGetDataSvc.getData();
  static Future<dynamic> getLpoData() => GetLpoDataSvc.getData();
  static Future<dynamic> getLpoDetails(String lpoId) =>
      VendorGetLpoDetailsSvc.getData(lpoId);
  static Future<dynamic> getLpoTerms() => VendorGetLpoTermsSvc.getData();

  static Future<dynamic> getContracts() => VendorGetContractsServices.getData();
  static Future<dynamic> getContractsPagination(String pageNo, searchtext) =>
      VendorGetContractsServices.getDataPagination(pageNo, searchtext);

  static Future<dynamic> getContractsWithFilter(
          VendorContractFilterData filterData) =>
      VendorGetContractsWithFilterServices.getData(filterData);
  static Future<dynamic> getContractsWithFilterPagination(
          VendorContractFilterData filterData, String pageNo) =>
      VendorGetContractsWithFilterServices.getDataPagination(
          filterData, pageNo);

  static Future<dynamic> getContractDetails() =>
      VendorGetContractDetailsServices.getData();
  static Future<dynamic> getContractProps() =>
      VendorGetContractPropsSvc.getData();
  static Future<dynamic> getPropertyImage(int propId) =>
      GetPropertyImageServiceVendor.getData(propId);
  static Future<dynamic> getProfile() => GetVendorProfileSvc.getData();

  static Future<dynamic> getAllLpos() => GetAllLpoServices.getData();
  static Future<dynamic> getAllLposPagination(String pageNoP, searchtext) =>
      GetAllLpoServices.getDataPagination(pageNoP, searchtext);

  static Future<dynamic> getLpoWithFilter(LpoFilterData filterData) =>
      GetLposwithFilterService.getData(filterData);
  static Future<dynamic> getLpoWithFilterPagnination(
          LpoFilterData filterData, String pageNo) =>
      GetLposwithFilterService.getDataPagnination(filterData, pageNo);

  static Future<dynamic> getLposProperties() =>
      GetLpoPropertiesServices.getData();
  static Future<dynamic> getLposService() => GetLpoServices.getData();
  static Future<dynamic> financialTerms() =>
      GetContractFinancialTermsServices.getData();
  static Future<dynamic> getLpoStatus() => GetLpoStatusService.getData();

  static Future<dynamic> getContractsStatus() =>
      GetContractsStatusService.getData();
  static Future<dynamic> getContractsStatusVendor() =>
      GetContractsStatusServiceVendor.getData();
  static Future<dynamic> getVendorAccounts() =>
      GetVendorAccountsService.getData();
  static Future<dynamic> getContactPersons() =>
      VendorGetContactPersonsSvc.getData();
  static Future<dynamic> lpoInvoices() => LpoInvoicesServices.getData();
  static Future<dynamic> contractInvoices() =>
      ContractInvoicesServices.getData();
  ///////////
  static Future<dynamic> getLpoDropDownForInvoice() =>
      SaveServiceRequestServices.getLpoDropDownForInvoice();
  static Future<dynamic> getAMCropDownForInvoice() =>
      SaveServiceRequestServices.getAMCropDownForInvoice();
  static Future<dynamic> getAMCInstDropDownForInvoice(String contractRefNo,contractID) =>
      SaveServiceRequestServices.getAMCInstDropDownForInvoice(contractRefNo,contractID);
  static Future<dynamic> saveInvoiceServiceRequest(
          paymenFor,
          srNo,
          instNo,
          invoiceAmount,
          trn,
          workCompletion,
          remrks,
          invoiceNo,
          invoiceDate,
          paymentTermID) =>
      SaveServiceRequestServices.saveData(
          paymenFor,
          srNo,
          instNo,
          invoiceAmount,
          trn,
          workCompletion,
          remrks,
          invoiceNo,
          invoiceDate,
          paymentTermID);
  static Future<dynamic> getInvoiceServiceRequest(String caseNo) =>
      SaveServiceRequestServices.getData(caseNo);
  ///////////
  static Future<dynamic> getVendorFaqsCatg() =>
      VendorFaqsCategoriesSerice.getVendorFaqsCatg();
  static Future<dynamic> getVendorFaqsQuestionAndDescription(int categoryId) =>
      VendorFaqsQuestionsAndDescriptionSerice.getFaqsQuestion(categoryId);
  static Future<dynamic> uploadFile(int caseNo, String fileName,
          String fileType, String exp, int docTypeId) =>
      VendorUploadSvcReqFile.uploadFile(
          caseNo, fileName, fileType, exp, docTypeId);
  static Future<dynamic> uploadFileInvoiceSR(int caseNo, String fileName,
          String fileType, String exp, int docTypeId, String reqID) =>
      VendorUploadSvcReqFile.uploadFileInvoiceSR(
          caseNo, fileName, fileType, exp, docTypeId, reqID);
  static Future<dynamic> updateFile(
          int attachmentId, String filePath, String exp) =>
      VendorUpdateSvcReqFile.updateFile(attachmentId, filePath, exp);
  static Future<dynamic> getReqPhotos(int caseNo, int roleId) =>
      VendorGetReqPhotos.getPhotos(caseNo, roleId);
  static Future<dynamic> getReqDocs(String caseNo, int roleId) =>
      VendorGetReqDocs.getDocs(caseNo, roleId);
  static Future<dynamic> getDocsByType(int caseNo, int roleId, int code) =>
      VendorGetDocsByType.getDocs(caseNo, roleId, code);
  static Future<dynamic> downloadDoc(int caseNo, int roleId, int docId) =>
      VendorDownloadDoc.downloadDoc(caseNo, roleId, docId);
  static Future<dynamic> removeReqPhoto(String photoId) =>
      RemoveSvcReqPhoto.removePhoto(photoId);
  static Future<dynamic> closeSvcReq(
          caseId, String fabCorrectiveAction, remedy, description) =>
      CloseSvcReq.closeSvcReq(caseId, fabCorrectiveAction, remedy, description);
  // static Future<dynamic> closeSvcReq(caseId) => CloseSvcReq.closeSvcReq(caseId);

  static Future<dynamic> acknowledgeCase(int caseId) =>
      VendorAcknowledgeCase.acknowledgeCase(caseId);
  static Future<dynamic> rejectCase(int caseId) =>
      ContractorRejectedCase.rejectCase(caseId);
  static Future<dynamic> updateProfileRequest() =>
      UpdateProfileRequestService.updateProfileRequest();

  static Future<dynamic> getNotifications(String status) =>
      VendorGetNotificationsServices.getData(status);
  static Future<dynamic> getNotificationsPagination(String status, pageNo) =>
      VendorGetNotificationsServices.getDataPagination(status, pageNo);

  static Future<dynamic> getNotificationDetails() =>
      VendorNotificationsDetailServices.getNotificationDetails(
          SessionController().getNotificationId());
  static Future<dynamic> getReadNotification() =>
      VendorReadNotificationsServices.getReadNotification();
  static Future<dynamic> getArchiveNotification() =>
      VendorArchiveNotificationsServices.getData();

  static Future<dynamic> getVendorAllInvoices() =>
      VendorDashboardAllInvoicesServices.getData();
  static Future<dynamic> getVendorAllInvoicesPagination(
          String pageNoP, searchtext) =>
      VendorDashboardAllInvoicesServices.getDataPagination(pageNoP, searchtext);

  static Future<dynamic> getOffers() => VendorOffersSerice.getOffers();
  static Future<dynamic> getOffersDetails(String offerId) =>
      VendorOffersDetailsService.getOffersDetails(offerId);

  static Future<dynamic> getVendorServiceRequestsServicesPagination(
          String pageNoP, searchtext) =>
      GetVendorServiceRequestsServices.getDataPagination(pageNoP, searchtext);
  static Future<dynamic> getVendorServiceRequestsServices() =>
      GetVendorServiceRequestsServices.getData();

  static Future<dynamic> getVendorDetailsServiceRequestsServices() =>
      GetVendorDetailsServiceRequestsServices.getData();
  static Future<dynamic> getVendorSRReportDetail() =>
      GetVendorDetailsServiceRequestsServices.getVendorSRReportDetail();
  static Future<dynamic> uploadTenantSing(String reqNo, String filePath) =>
      UploadTenantSign.uploadFile(reqNo, filePath);
  static Future<dynamic> uploadVendorSing(String reqNo, String filePath) =>
      UploadVendorSign.uploadFile(reqNo, filePath);

  static Future<dynamic> getTicketReplies(String caseNo) =>
      VendorGetTicketsService.getData(caseNo);
  static Future<dynamic> addTicketReply(
          String caseNo, String message, String filePath) =>
      VendorAddTicketService.addTicket(caseNo, message, filePath);
  static Future<dynamic> downloadTicketFile(int caseNo) =>
      VendorDownloadTenantTicketFiles.getData(caseNo);
}
