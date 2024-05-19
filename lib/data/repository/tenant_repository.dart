import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/models/tenant_models/tenant_contracts_filter/filter_data.dart';
import 'package:fap_properties/data/services/tenant_services/can_checkin_contract.dart';
import 'package:fap_properties/data/services/tenant_services/can_download_contract.dart';
import 'package:fap_properties/data/services/tenant_services/contract_charge_receipts_service.dart';
import 'package:fap_properties/data/services/tenant_services/contract_payment_cheque_services.dart';
import 'package:fap_properties/data/services/tenant_services/contract_payment_services.dart';
import 'package:fap_properties/data/services/tenant_services/contract_services/contract_requests/checkin_contract_service.dart';
import 'package:fap_properties/data/services/tenant_services/contract_services/contract_requests/create_signature_req.dart';
import 'package:fap_properties/data/services/tenant_services/contract_services/contract_requests/download_contract_terms.dart';
import 'package:fap_properties/data/services/tenant_services/contract_services/contract_requests/extend_contract_service.dart';
import 'package:fap_properties/data/services/tenant_services/contract_services/contract_requests/get_extension_periods.dart';
import 'package:fap_properties/data/services/tenant_services/contract_services/contract_requests/get_renewal_info.dart';
import 'package:fap_properties/data/services/tenant_services/contract_services/contract_requests/get_terminate_reasons.dart';
import 'package:fap_properties/data/services/tenant_services/contract_services/contract_requests/legal_settlement_req_service.dart';
import 'package:fap_properties/data/services/tenant_services/contract_services/contract_requests/renew_contract_service.dart';
import 'package:fap_properties/data/services/tenant_services/contract_services/contract_requests/terminate_contract_service.dart';
import 'package:fap_properties/data/services/tenant_services/download_offer_letter.dart';
import 'package:fap_properties/data/services/tenant_services/expiring_in_30days_service.dart';
import 'package:fap_properties/data/services/tenant_services/get_contract_unit_details_service.dart';
import 'package:fap_properties/data/services/tenant_services/get_contracts_services.dart';
import 'package:fap_properties/data/services/tenant_services/get_municipal_approval.dart';
import 'package:fap_properties/data/services/tenant_services/get_property_image.dart';
import 'package:fap_properties/data/services/tenant_services/get_unit_aditional_details_service.dart';
import 'package:fap_properties/data/services/tenant_services/get_unit_image.dart';
import 'package:fap_properties/data/services/tenant_services/payments/get_online_payments_service.dart';
import 'package:fap_properties/data/services/tenant_services/service_requests/download_cheque.dart';
import 'package:fap_properties/data/services/tenant_services/service_requests/download_doc.dart';
import 'package:fap_properties/data/services/tenant_services/service_requests/get_docs_by_type.dart';
import 'package:fap_properties/data/services/tenant_services/service_requests/get_req_docs.dart';
import 'package:fap_properties/data/services/tenant_services/service_requests/get_req_photos.dart';
import 'package:fap_properties/data/services/tenant_services/service_requests/get_survey_question_answers.dart';
import 'package:fap_properties/data/services/tenant_services/service_requests/get_survey_questions.dart';
import 'package:fap_properties/data/services/tenant_services/service_requests/remove_photo.dart';
import 'package:fap_properties/data/services/tenant_services/service_requests/reopen_tenant_service_request.dart';
import 'package:fap_properties/data/services/tenant_services/service_requests/save_survey_answer.dart';
import 'package:fap_properties/data/services/tenant_services/service_requests/service_req_chat/add_ticket_service.dart';
import 'package:fap_properties/data/services/tenant_services/service_requests/service_req_chat/download_ticket_files.dart';
import 'package:fap_properties/data/services/tenant_services/service_requests/service_req_chat/get_tickets_service.dart';
import 'package:fap_properties/data/services/tenant_services/service_requests/update_svc_req_file.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_add_request/case_category_services.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_add_request/case_sub_category_services.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_add_request/get_case_types_services.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_add_request/get_contact_timing_services.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_add_request/get_tenant_properties_services.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_add_request/save_services_request_services.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_contract_payable/get_outstanding_payments_service.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_contract_payable/online_payables_service.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_contract_payable/get_policy_data.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_contract_payable/tenant_register_payment_service.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_contract_payable/tenant_remove_cheque_service.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_contract_payable/update_payment_method_service.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_contracts_filter/get_contracts_status_service.dart';
import 'package:fap_properties/data/services/tenant_services/get_contracts_units_services.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_contracts_filter/get_contracts_with_filter_service.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_contracts_filter/get_property_types_services.dart';
import 'package:fap_properties/data/services/tenant_services/get_tenant_charges_services.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_dashboard_popup/tenant_dashboard_popup_service.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_downloads/download_signed_contract.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_downloads/tenant_contract_download_services.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_downloads/tenant_payment_download_receipt_services.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_faqs/tenant_faqs_questions_service.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_faqs/tenant_faqs_service.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_feedback/get_tenant_sr_feedback.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_feedback/tenant_save_feedback_service.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_notifications/get_notification_files.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_notifications/get_tenant_notifications_services.dart';
import 'package:fap_properties/data/services/tenant_services/payments_services.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_contracts_details_services.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_dashboard_get_data_services.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_notifications/tenant_archive_notifications_services.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_notifications/tenant_notifications_detail_services.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_notifications/tenant_read_notifications_services.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_profile/can_edit_profile.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_offers/tenant_offer_details_service.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_offers/tenant_offers_service.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_profile/tenant_profile_services.dart';
import 'package:fap_properties/data/services/tenant_services/tenant_profile/tenant_update_profile_service.dart';
import 'package:fap_properties/data/services/tenant_services/to_be_paid_in_30days_service.dart';
import 'package:fap_properties/data/services/tenant_services/service_requests/upload_svc_req_file.dart';
import 'package:fap_properties/data/services/tenant_services/unverfied_contract_payment_service.dart';

import '../services/tenant_services/case_checkin_contract_service.dart';
import '../services/tenant_services/get_renewal_actions.dart';
import '../services/tenant_services/service_requests/cancel_tenant_service_request.dart';
import '../services/tenant_services/service_requests/get_cities_services.dart';
import '../services/tenant_services/service_requests/get_service_request_details_services.dart';
import '../services/tenant_services/service_requests/get_tenant_service_requests_services.dart';
import '../services/tenant_services/service_requests/update_contract_document_stage.dart';
import '../services/tenant_services/service_requests/update_contract_stage.dart';
import '../services/tenant_services/tenant_contract_payable/add_aramex_address.dart';
import '../services/tenant_services/tenant_contract_payable/tenant_contract_payable_service.dart';
import '../services/tenant_services/tenant_notifications/download_notification_files.dart';

class TenantRepository {
  static Future<dynamic> getContracts() => GetContractsServices.getData();

  static Future<dynamic> getContractsPagination(pageNo, searchText) =>
      GetContractsServices.getDataPagination(pageNo, searchText);
  static Future<dynamic> getContractsDetails() =>
      GetContractsDetailsServices.getData();
  static Future<dynamic> getUnits() => GetContractsUnitsServices.getData();
  static Future<dynamic> getContractUnitDetails() =>
      GetContractUnitDetailsServices.getData();
  static Future<dynamic> payments() => PaymentsServices.getData();
  static Future<dynamic> paymentsPagination(pageNo) =>
      PaymentsServices.getDataPagination(pageNo);
  static Future<dynamic> paymentsSearch(pageNo, searchText) =>
      PaymentsServices.paymentsSearch(pageNo, searchText);
  static Future<dynamic> contractPayments() =>
      ContractPaymentsServices.getData();
  static Future<dynamic> tenantDashboardGetData() =>
      TenantDashboardGetDataServices.getData();
  static Future<dynamic> tenantProfile() => TenantProfileServices.getData();
  static Future<dynamic> getCharges() => GetContractsChargesServices.getData();
  static Future<dynamic> getCheque(String transId) =>
      GetContractChequesServices.getData(transId);

  static Future<dynamic> getNotifications(String status) =>
      GetTenantNotificationsServices.getData(status);
  static Future<dynamic> getNotificationsPagination(String status, pageSize) =>
      GetTenantNotificationsServices.getDataPagination(status, pageSize);

  static Future<dynamic> readNotification() =>
      TenantReadNotificationsServices.getData();
  static Future<dynamic> archiveNotification() =>
      TenantArchiveNotificationsServices.getData();
  static Future<dynamic> notificationDetails() =>
      TenantNotificationsDetailServices.getData(
          SessionController().getNotificationId());
  static Future<dynamic> getNotificationFiles(int id) =>
      GetTenantNotificationsFiles.getData(id);
  static Future<dynamic> downloadNotificationFiles(int id) =>
      DownloadTenantNotificationsFiles.getData(id);
  static Future<dynamic> toBePaidIn30Days() =>
      ToBePaidIn30DaysService.getData();
  static Future<dynamic> expiringIn30Days() =>
      ExpiringIn30DaysService.getData();
  static Future<dynamic> getPropertyTypes() =>
      GetPropertyTypesService.getData();
  static Future<dynamic> getContractStatus() =>
      GetContractsStatusService.getData();
  static Future<dynamic> getContractsWithFilter(FilterData filterData) =>
      GetContractswithFilterService.getData(filterData);
  static Future<dynamic> getContractsWithFilterPagination(
          FilterData filterData, pageNo, searchtext) =>
      GetContractswithFilterService.getDataPagination(
          filterData, pageNo, searchtext);
  static Future<dynamic> getUnitAditionalDetails() =>
      GetUnitAditionalDetailsService.getData();
  static Future<dynamic> getContractChargeReceipts(int chargesTypeId) =>
      ContractChargeReceiptsService.getData(chargesTypeId);

  static Future<dynamic> paymentsDownloadReceipt() =>
      PaymentDownloadReceiptService.getData();
  static Future<dynamic> contractDownload() =>
      ContractDownloadService.getData();
  static Future<dynamic> contractDownloadNew() =>
      ContractDownloadServiceNew.getDataNew();
  static Future<dynamic> downloadOfferLetter(int contractId) =>
      DownloadOfferLetter.getData(contractId);
  static Future<dynamic> getPropertyImage(int propId) =>
      GetPropertyImageService.getData(propId);
  static Future<dynamic> getUnitImage(int unitId) =>
      ///////////////////
      GetUnitImageService.getData(unitId);
  static Future<dynamic> getTicketReplies(String reqNo) =>
      GetTicketsService.getData(reqNo);
  static Future<dynamic> addTicketReply(
          String reqNo, String message, String filePath) =>
      AddTicketService.addTicket(reqNo, message, filePath);
  static Future<dynamic> downloadTicketFile(int id) =>
      DownloadTenantTicketFiles.getData(id);
  static Future<dynamic> uploadFile(String reqNo, String filePath,
          String fileType, String exp, String docTypeId) =>
      UploadSvcReqFile.uploadFile(reqNo, filePath, fileType, exp, docTypeId);
  static Future<dynamic> uploadFileNew(String reqNo, String filePath,
          String fileType, String exp, String docTypeId) =>
      UploadSvcReqFileNew.uploadFileNew(reqNo, filePath, fileType, exp, docTypeId);
  // uploadDocWithEIDParameter this func created because we want to send name,nationaity,ID after
  // scanne the emirate ID
  static Future<dynamic> uploadDocWithEIDParameter(
          String reqNo,
          String filePath,
          String fileType,
          String exp,
          String docTypeId,
          String emirateIdNumber,
          nationality,
          nameEng,
          nameAr,
          issueDate,
          String dOB
          // DateTime dOB
          ) =>
      UploadSvcReqFile.uploadDocWithEIDParameter(
          reqNo,
          filePath,
          fileType,
          exp,
          docTypeId,
          emirateIdNumber,
          nationality,
          nameEng,
          nameAr,
          issueDate,
          dOB);
  static Future<dynamic> updateFile(
          int attachmentId, String filePath, String exp) =>
      UpdateSvcReqFile.updateFile(attachmentId, filePath, exp);
  static Future<dynamic> updateContractDocumentStage(int dueActionId) =>
      UpdateContractDocumentStage.updateStage(dueActionId);
  static Future<dynamic> getReqDocs(String caseNo, int roleId) =>
      TenantGetReqDocs.getDocs(caseNo, roleId);
  static Future<dynamic> getReqThumbnails(int caseNo, int roleId) =>
      GetReqThumbnails.getThumbnails(caseNo, roleId);
  static Future<dynamic> removeReqPhoto(var photoId) =>
      RemoveSvcReqPhoto.removePhoto(photoId);
  static Future<dynamic> getFaqs() => TenantFaqsSerice.getFaqsCatg();
  static Future<dynamic> getFaqsQuestions(int categoryId) =>
      TenantFaqsQuestionsSerice.getFaqsQuestion(categoryId);
  static Future<dynamic> saveTenantSRFeedback(
          String caseId, String description, double rating) =>
      TenantSaveFeedbackServices.saveFeedbackData(caseId, description, rating);
  static Future<dynamic> getTenantSRFeedback(int caseId) =>
      GetTenantSRFeedback.getFeedback(caseId);
  static Future<dynamic> canEditProfile() => CanEditProfile.canEditProfile();
  static Future<dynamic> updateProfile(
          String name, String mobileNo, String email, String address) =>
      TenantUpdateProfileService.updateProfile(name, mobileNo, email, address);
  static Future<dynamic> getExtensionPeriods(int contractId) =>
      GetExtensionPeriodsService.getData(contractId);
  static Future<dynamic> extendContract(int contractId, String duration,
          String startDate, String endDate, int dueActionid) =>
      ExtendContractService.extendContract(
          contractId, duration, startDate, endDate, dueActionid);
  static Future<dynamic> getContractRenewalInfo(int contractId) =>
      GetRenewalInfoService.getData(contractId);
  static Future<dynamic> renewContract(
          int contractId, String startDate, String endDate, int dueActionid) =>
      RenewContractService.renewContract(
          contractId, startDate, endDate, dueActionid);
  static Future<dynamic> getTerminateReasons() =>
      GetTerminateReasonsService.getData();
  static Future<dynamic> terminateContract(int contractId, int vacatingId,
          String date, String desc, int dueActionid) =>
      TerminateContractService.terminateContract(
          contractId, vacatingId, date, desc, dueActionid);
  static Future<dynamic> checkinContract(int contractId) =>
      CheckinContractService.checkinContract(contractId);
  static Future<dynamic> submitLegalSettlementReq(
          int contractId, String desc) =>
      LegalSettlementReqService.submitReq(contractId, desc);
  static Future<dynamic> getOffers(String pageNo) =>
      TenantOffersSerice.getOffers(pageNo);
  static Future<dynamic> getOffersDetails(String offerId) =>
      TenantOffersDetailsSerice.getOffersDetails(offerId);

  static Future<dynamic> getDashboardPopup() =>
      TenantDashboardPopupService.getPopup();
      // using register payment 2024
  static Future<dynamic> registerPayment(var data) =>
      TenantRegisterPaymentService.registerPayment(data);
  static Future<dynamic> registerPaymentNew(var data) =>
      TenantRegisterPaymentServiceNew.registerPaymentNew(data);
  // 1122 1
  // registerPayment(data);
  static Future<dynamic> removeCheque(int paymentSettingId) =>
      TenantRemoveChequeService.removeCheque(paymentSettingId);
  static Future<dynamic> removeChequeNew(int paymentSettingId) =>
      TenantRemoveChequeServiceNew.removeChequeNew(paymentSettingId);
  static Future<dynamic> getPaymentPolicyData(String dataType) =>
      GetPolicyDataService.getPolicyData(dataType);
  static Future<dynamic> createSignatureReq(int contractId) =>
      CreateSignatureRequest.createReq(contractId);
  static Future<dynamic> getDocsByType(int caseNo, int roleId, int code) =>
      TenantGetDocsByType.getDocs(caseNo, roleId, code);
  static Future<dynamic> downloadDoc(int caseNo, int roleId, int docId) =>
      TenantDownloadDoc.downloadDoc(caseNo, roleId, docId);
  static Future<dynamic> downloadDocIsRejected(
          int caseNo, int roleId, int docId) =>
      TenantDownloadDoc.downloadDocIsRejected(caseNo, roleId, docId);
  static Future<dynamic> downloadContractTerms(int contractId) =>
      DownloadContractTerms.getData(contractId);
  static Future<dynamic> downloadContractTermsNew(int contractId) =>
      DownloadContractTermsNew.getDataNew(contractId);
  static Future<dynamic> downloadSignedContract(int contractId) =>
      DownloadSignedContract.getData(contractId);

  static Future<dynamic> getOnlinePayments() =>
      GetOnlinePaymentsService.getPayments();

  static Future<dynamic> getSurveyQuestions(int caseNo) =>
      GetSurveyQuestions.getData(caseNo);

  static Future<dynamic> getSurveyQuestionAnswers(int qId) =>
      GetSurveyQuestionAnswers.getData(qId);

  static Future<dynamic> saveSurveyAnswer(
          int customerChoice, int answerId, String desc, int isCompleted) =>
      SaveSurveyAnswer.saveAnswer(customerChoice, answerId, desc, isCompleted);

  static Future<dynamic> getTenantServiceRequests(
          String type, fromDate, toDate, search) =>
      GetTenantServiceRequestsServices.getData(type, fromDate, toDate, search);
  // static Future<dynamic> getTenantServiceRequests(String type) =>
  //     GetTenantServiceRequestsServices.getData(type);
  static Future<dynamic> getCaseTypes() => GetCaseTypesServices.getData();
  static Future<dynamic> getCaseCategory() => CaseCategoryServices.getData();
  static Future<dynamic> getSubCaseCategory() =>
      CaseSubCategoryServices.getData();
  static Future<dynamic> getTenantUnits() => GetTenantUnitsServices.getData();
  static Future<dynamic> getCities() => GetCitiesServices.getData();
  static Future<dynamic> getContactTiming() =>
      GetContactTimingServices.getData();
  // static Future<dynamic> getLanuage() =>
  //     GetPreferredLanguagesServices.getData();

  static Future<dynamic> getServiceRequestDetails() =>
      GetServiceRequestDetailsServices.getData();
  static Future<dynamic> saveServiceRequest(catId, subCatId, contractUnitId,
          desc, contactName, contactMobile, contactTimeId) =>
      SaveServiceRequestServices.getData(catId, subCatId, contractUnitId, desc,
          contactName, contactMobile, contactTimeId);
  static Future<String> cancelServiceRequest(var caseNo) =>
      CancelTenantServiceRequest.cancelServiceRequest(caseNo);
  static Future<String> reopenServiceRequest(var caseNo) =>
      ReopenTenantServiceRequest.reopenServiceRequest(caseNo);

  static Future<dynamic> getContractPayable(int contractId) =>
      TenantContractPayableService().getContractPayables(contractId);
  static Future<dynamic> getOutstandingPayments(int contractId) =>
      GetOutstandingPaymentsService().getOutstandingPayments(contractId);
  static Future<dynamic> getOutstandingPaymentsNewContract(int contractId) =>
      GetOutstandingPaymentsNewContractService().getOutstandingPaymentsNewContract(contractId);
  // *
  static Future<dynamic> updatePaymentMethod(record) =>
      UpdatePaymentMethodService.updatePaymentMethod(record);
  static Future<dynamic> updatePaymentMethodNew(record) =>
      UpdatePaymentMethodServiceNew.updatePaymentMethodNew(record);
  static Future<dynamic> downloadCheque(int paymentSettingId) =>
      TenantDownloadCheque.downloadcheque(paymentSettingId);
  static Future<dynamic> downloadChequeNew(int paymentSettingId) =>
      TenantDownloadChequeNew.downloadchequeNew(paymentSettingId);
  // static Future<dynamic> addContractPayment(final data, String filePath) =>
  //     AddPaymentsService.addPayment(data, filePath);

  // 112233 get tenant document
  static Future<dynamic> getReqDocsForTenant(String caseNo, int roleId) =>
      TenantGetReqDocs.getDocs(caseNo, roleId);

  static Future<dynamic> updateAramexAddress(
          int contractId, String address, int deliveryOption) =>
      AddAramexAddress.addAddress(contractId, address, deliveryOption);
  static Future<dynamic> updateAramexAddressNew(
          int contractId, String address, int deliveryOption) =>
      AddAramexAddressNew.addAddressNew(contractId, address, deliveryOption);

  static Future<dynamic> getContractOnlinePayable(int contractId) =>
      OnlinePayablesService().getContractPayable(contractId);
  static Future<dynamic> getContractOnlinePayablNew(int contractId) =>
      OnlinePayablesServiceNew().getContractPayableNew(contractId);

  static Future<dynamic> getUnverifiedPayments() =>
      UnverfiedContractPaymentServices.getData();

  static Future<dynamic> canCheckingContract(int contractId) =>
      CanCheckinContractService.getData(contractId);
  static Future<dynamic> getRenewalActions() => GetRenewalActions.getData();
  static Future<dynamic> getNewActions() => GetNewActions.getData();
  static Future<dynamic> updateContractStage(int dueActionId, int stageId) =>
      UpdateContractStage.updateStage(dueActionId, stageId);
  static Future<dynamic> updateContractStageSignContract(
          int dueActionId, int stageId) =>
      UpdateContractStage.updateStageSignContract(dueActionId, stageId);
  static Future<dynamic> updateContractStageSignContractNew(
          int dueActionId, int stageId) =>
      UpdateContractStage.updateStageSignContractNew(dueActionId, stageId);
  static Future<dynamic> getMinicipalApproval(int contractId) =>
      GetMunicipalApproval.getData(contractId);
  static Future<dynamic> getMinicipalApprovalNew(int contractId) =>
      GetMunicipalApprovalNew.getDataNew(contractId);
  static Future<dynamic> canDownloadContract(int contractId) =>
      CanDownloadContractService.getData(contractId);
  static Future<dynamic> caseCheckinContract(
          int contractId, int caseId, int dueActionId) =>
      CaseCheckinContractService.checkinContract(
          contractId, caseId, dueActionId);
}
