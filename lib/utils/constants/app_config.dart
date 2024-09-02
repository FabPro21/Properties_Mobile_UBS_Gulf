import 'package:flutter/foundation.dart';

class AppConfig {
  static final AppConfig _instance = AppConfig._internel();

  // for landlord
  bool isUat = true;

  String? baseUrl;

  String? validateUser;
  String? validateUserFB;
  String? verifyUserOtp;
  String? verifyUserOtpFB;
  String? getNewToken;

  String? commonAppConfig;

  String? publicAppConfig;

  String? tenantAppConfig;

  String? appConfigVendor;

  String? getMetaDataVersion;

  String? getMetaData;

  String? getcountries;

  String? validate;

  String? updateDeviceInfo;

  String? saveMpin;

  String? getUserRoles;

  String? addPublicUser;

  String? login;

  String? updateLang;

  String? validateRoleByMpin;

  String? validateRoleByFP;

  String? validatePublicRole;

  String? compareDeviceToken;

  //////////////////
  ///   tenantAppConfig!
  //////////////////

  String? getContracts;

  String? getContractDetails;

  String? getContractPayable;

  String? getCanCheckinContract;

  String? caseCheckinContract;

  String? getNotifications;

  String? getNotificationFiles;

  String? downloadNotificationFile;

  String? getTenantProfile;

  String? updateTenantProfile;

  String? canEditProfile;

  String? getServiceRequests;

  String? getContractUnits;

  String? getContractUnitDetails;

  String? getUnitAditionalDetails;

  String? getTenantNotifications;

  String? tenantReadNotifications;

  String? tenantArchiveNotifications;

  String? tenantNotificationsDetails;

  // String? getUnitDetails;

  String? getContractPayments;

  // String? getpaymentDetails;

  String? getContractCharges;

  String? payments;

  String? paymentsGet;

  String? getStats;

  String? dashboard;

  String? tenantDashboardGetData;

  String? getOnlinePayments;

  String? getContractCheques;

  String? toBePaidIn30Days;

  String? contractsExpiringIn30Days;

  String? getPropTypes;

  String? getContractStatus;

  // this api is using for vendor contract status
  String? getVendorContractsStatus;

  String? getContractswithFilter;

  String? contractChargeReceipts;

  String? paymentsDownloadReceipt;

  String? contractDownload;
  String? contractDownloadNew;

  String? downloadContractTerms;
  String? downloadContractTermsNew;

  // String? downloadContractWithSignature;

  String? contractRenewalActions;
  String? contractNewActions;

  String? downloadOfferLetter;

  String? getOutstandingPayments;
  String? getOutstandingPaymentsNew;

  String? updateContractPaymentMethod;
  String? updateContractPaymentMethodNew;

  String? updateContractStage;
  String? updateContractStageNew;

  String? getApproveMunicipal;
  String? getApproveMunicipalNew;

  String? downloadSignedContract;

  String? canDownloadContract;

  String? unVerfiedAllPayment;

  String? unVerfiedContractPayment;

  //////////////////
  ///   VendorAppConfig
  //////////////////

  String? contractorProfile;

  String? getlpoproperties;

  String? getlpos;

  String? getlposdetail;

  String? getlpoterm;

  String? getlposervies;

  String? getlpostatus;

  String? getLpowithFilter;

  //String? getVendorContractsStatus;

  String? getVendorContractswithFilter;

  String? getVendorAccounts;

  String? getststs;

  String? getdashboardlpo;

  String? contactPerson;

  String? accountInfo;

  String? doc;

  String? getVendorProfile;

  String? getAllLpo;

  String? getContractFinancialTerms;

  String? getContactPersons;

  String? getVendorContracts;

  String? getVendorContractDetails;

  String? getVendorContractProperties;

  String? lpoInvoices;

  String? contractInvoices;
  String? vendorDashboardAllInvoces;

  String? getLanguage;
  String? updateLanguage;
  String? saveLanguage;
  String? getTenantServiceRequests;
  String? getCaseTypes;
  String? caseCategory;
  String? caseSubCategory;
  String? getCities;
  String? getTenantContractUnits;
  String? getContactTiming;
  String? getPreferredLanguages;
  String? getServiceRequestDetails;
  String? saveServiceRequest;
  String? cancelServiceRequest;
  String? getSurveyQuestions;
  String? getSurveyQuestionAnswers;
  String? saveSurveyAnswer;
  /////////////////////
  String? getVendorServiceRequest;
  String? getVendorServiceRequestDetails;
  String? getEmirates;
  String? getPropertyCategory;
  String? vendorSaveInvoiceServiceRequest;
  String? vendorGetInvoiceServiceRequest;

  ///Comment by kamran
  //String? getUnitType;
  String? getUnitTypeByCategoryId;
  String? getProperties;
  String? getPropertyDetail;
  String? getPropertyImage;
  String? getUnitImage;

  String? getPropertyImageVendor;

  //////////////////////////
  String? getTicketReplies;
  String? addTicketReply;
  String? downloadTicketFile;
  String? uploadTicketFiles;
  String? uploadServiceRequestFiles;
  String? uploadServiceRequestFilesNew;
  String? uploadEIDFilesDetail;
  String? updateServiceRequestFiles;
  String? updateContractDocumentStage;
  String? getServiceRequestThumbnailList;
  String? removeSvcReqPhoto;

  ///////////////////////
  //////tenant
  String? getTenantFaqsCatg;
  String? getTenanatFaqsQuestions;
  String? saveTenantFeedback;
  String? getTenantFeedback;
  String? reopenSvcReq;
  String? getExtensionPeriods;
  String? extendContract;
  String? terminateContract;
  String? checkinContract;
  String? renewContract;
  String? getContractRenewalInfo;
  String? getTerminateReasons;
  String? legalSettlementReq;
  String? getDashboardPopup;
  String? onlinePayables;
  String? onlinePayablesNew;
  String? addContractPayment;
  String? updateContractPaymentAddress;
  String? updateContractPaymentAddressNew;
  String? downloadCheque;
  String? downloadChequeNew;
  String? removeCheque;
  String? removeChequeNew;
  String? registerPayment;
  String? registerPaymentNew;
  String? getPolicyData;
  String? createSignatureRequest;
  String? getReqDocs;
  String? getReqDocsPDF;
  String? tenantDownloadDoc;
  String? tenantGetDocsByType;
  //////////////////
  ///vendor
  String? getVendorFaqsCatg;
  String? getVendorFaqsQuestionAndDescription;
  // String? getDocType;
  String? vendorUploadServiceRequestFiles;
  String? vendorUploadInvoiceServiceRequestFiles;
  String? vendorUpdateServiceRequestFiles;
  String? vendorGetServiceRequestImages;
  String? vendorGetServiceRequestDocs;
  String? vendorRemoveSvcReqPhoto;
  String? vendorCloseRequest;
  String? vendorAcknowledgeCase;
  String? contractorRejected;
  String? uploadTenantSign;
  String? uploadVendorSign;

  // get tenant doc
  String? tenantGetServiceRequestDocs;

  String? updateProfileRequest;
  String? getVendorNotification;
  String? vendorNotificationDetails;
  String? vendorReadNotification;
  String? vendorArchiveNotification;
  String? vendorGetDocsByType;
  String? vendorDownloadDoc;
  String? vendorGetTickets;
  String? vendorAddTicket;
  String? vendorDownloadTicketFile;
  String? vendorGetSRReportDetail;
  String? getLpoDropdownForIvoice;
  String? getAMCDropdownForInvoice;
  String? getAmcInstallmentForInvoice;
/////////////////////
///////public
  String? getPublicFaqsCatg;
  String? getPublicFaqsQuestionAndDescription;
  String? getPublicBookingAgentList;
  String? savePublicBookingRequest;
  String? getPublicServices;
  String? publicServiceMianinfo;
  String? savePublicFeedback;
  String? getPublicFeedback;
  String? getPublicLocation;
  String? cancelPublicBookingreq;
  String? getBookingReqImages;
  String? getBookingReqPropertyImage;
  String? publicAddTicketReply;
  String? publicGetTicketReplies;
  String? publicDownloadTicketFile;
  ////////////
  String? getOffers;
  String? getOffersDetails;
/////////
  String? getVendorOffers;
  String? getVendorOffersDetails;
/////////////
  String? getPublicOffers;
  String? getPublicOffersDetails;
  String? publicCanEditProfile;
  String? publicGetProfile;
  String? publicUpdateProfile;
  String? updatePublicProfile; // new
  String? publicUpdateProfile2;
  String? getPublicServiceCategories;
  String? proceedToLogin;
  String? getPublicServicesCategoriesDetails;
  String? publicPropertyManagement;
  String? getPublicNotification;
  String? publicNotificationDetails;
  String? publicArchivedNotifications;
  String? publicReadNotifications;
  String? publicCountNotifications;

/////////////landlord///////////////
  ///
  ///
  String? landlordAppConfig;
  String? getLandlordContracts;
  String? getLandlordContractswithFilter;
  String? getLandlordContractStatus;
  String? getLandlordPropTypes;
  String? getLandlordEmirate;
  String? getLandlordCategory;
  String? getPropertyWithFilter;
  String? getLandlordContractDetails;
  String? getLandlordContractCharges;
  String? unVerfiedLandlordContractPayment;
  String? getLandlordContractUnits;
  String? getLandlordUnits;
  String? getLandlordContractPayments;
  String? getLandlordUnVeridiedPayments;
  String? getLandlordContractCheques;
  String? getLandlordContractChargeReceipts;
  String? getLandlordUnitAdditionalDetails;
  String? getLandlordPayments;
  String? getLandlordProfile;
  String? getLandlordProperties;
  String? getLandlordPropertyUnits;
  String? getLandlordPropertyDetails;
  String? getLandlordPropertyUnitDetails;
  String? getLandlordNotifications;
  String? landlordDashboardGetData;
  String? landLordReadNotifications;
  String? landLordArchiveNotifications;
  String? landLordNotificationsDetails;
  String? landLorddownloadNotificationFile;
  String? landLordgetNotificationFilese;
  String? getLandLordProfile;
  String? canEditLandLordProfile;
  String? updateLandLordProfile;
  String? getLandlordFaqsCatg;
  String? getLandlordFaqs;
  String? getLandlordContractPayable;
  String? getLandlordUitImages;
  String? paymentsDownloadReceiptLandlord;
  String? getContractChargesLandlord;
  String? contractChargeReceiptsLandlord;
  String? downloadAMCReport;
  String? getDropDownType;
  String? generateAMCReportSummary;
  String? downloadGenerateLPOReport;
  String? generateLPOReportSummary;
  String? downloadGenerateBERReport;
  String? downloadGenerateVATReport;
  String? generateVATReportSummary;
  String? downloadGenerateChequeRegisterReport;
  String? generateChequeRegisterReportSummary;
  String? downloadGenerateLegalCaseReport;
  String? generateLegalCaseReport;
  String? generateLegalCaseReportSummary;
  String? generateContractReport;
  String? generateContractReportSummary;
  String? downloadGenerateReceiptRegisterReport;
  String? generateReceiptRegisterReportSummary;
  String? downloadGenerateUnitStatusReport;
  String? generateUnitStatusReportSummary;
  String? downloadGenerateLandLordGetContracts;
  String? downloadGenerateBuildingStatusReport;
  String? generateBuildingStatusReportSummary;
  String? occupancyVacancyRegisterReport;
  String? occupancyVacancyRegisterSummary;
  String? landlordInvoces;
  String? getLandlordReportDropDownType;

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internel() {
    setUrls();
  }

  void setUrls() {
    if (kReleaseMode) isUat = true;

///////////////////////////////////////////////////////////////////////////

    // COL -> col (colauth01,colauth01,coltenant01,collandlord01)
    // baseUrl = 'https://provisuat.uaenorth.cloudapp.azure.com';
    // commonAppConfig! =
    //     'https://provisuat.uaenorth.cloudapp.azure.com/colauth01/api/';
    // publicAppConfig! = 'https://provisuat.uaenorth.cloudapp.azure.com/colpublic01/';
    // tenantAppConfig! =
    //     'https://provisuat.uaenorth.cloudapp.azure.com/coltenant01/api/';
    // appConfigVendor! =
    //     'https://provisuat.uaenorth.cloudapp.azure.com/colvendor01/api/';
    // landlordAppConfig! =
    //     'https://provisuat.uaenorth.cloudapp.azure.com/collandlord01/api/';

    // FABP -> fabp (fabpauth01,fabppublic01,fabptenant01,fabplandlord01)
    // baseUrl = 'https://provisuat.uaenorth.cloudapp.azure.com';
    // commonAppConfig =
    //     'https://provisuat.uaenorth.cloudapp.azure.com/fabpauth01/api/';
    // publicAppConfig =
    //     'https://provisuat.uaenorth.cloudapp.azure.com/fabppublic01/';
    // tenantAppConfig =
    //     'https://provisuat.uaenorth.cloudapp.azure.com/fabptenant01/api/';
    // appConfigVendor =
    //     'https://provisuat.uaenorth.cloudapp.azure.com/fabpvendor01/api/';
    // landlordAppConfig =
    //     'https://provisuat.uaenorth.cloudapp.azure.com/fabplandlord01/api/';

///////////////////////////////////////////////////////////////////////////
    // Production
    baseUrl = 'https://landlord.fabproperties.ae';
    commonAppConfig = 'https://landlord.fabproperties.ae/auth01/api/';
    publicAppConfig = 'https://landlord.fabproperties.ae/public/';
    tenantAppConfig = 'https://landlord.fabproperties.ae/tenant01/api/';
    appConfigVendor = 'https://landlord.fabproperties.ae/vendor01/api/';
    landlordAppConfig = 'https://landlord.fabproperties.ae/landlord/api/';

    // Internal Testing
///////////////////////////////////////////////////////////////////////////

    // 44 Server --> uat
    // commonAppConfig = 'https://20.174.25.44/Auth/api/';
    // publicAppConfig = 'https://20.174.25.44/Public/';
    // tenantAppConfig = 'https://20.174.25.44/Tenant/Api/';
    // appConfigVendor = 'https://20.174.25.44/Vendor/Api/';
    // landlordAppConfig = 'https://20.174.25.44/Landlord/Api/';

    // 43 Server
    ///////////////////////////////////////////////////////////////////////////
    // commonAppConfig! = 'http://216.108.228.43:8081/api/';
    // publicAppConfig! = 'http://40.80.86.229:9014/';
    // tenantAppConfig! = 'http://216.108.228.43:8092/api/';
    // appConfigVendor! = 'http://216.108.228.43:8083/api/';
    // landlordAppConfig! = 'http://216.108.228.43:8085/api/';

///////////////////////////////////////////////////////////////////////////

    /// //////////////////
    ///   New Flow Apis
    //////////////////
    validateUser = commonAppConfig! + 'Auth/ValidateUser';
    validateUserFB = commonAppConfig! + 'Auth/ValidateFirebaseUser';
    verifyUserOtp = commonAppConfig! + 'Auth/VerifyUserOtp';
    verifyUserOtpFB = commonAppConfig! + 'Auth/GenerateFirbaseUserToken';
    getNewToken = commonAppConfig! + 'Auth/RefreshToken';

    /// //////////////////
    ///   New Fl  ow Apis
    //////////////////

    getMetaDataVersion = commonAppConfig! + 'Data/getmetadataversion';
    getMetaData = commonAppConfig! + 'Data/getmetadata';
    getcountries = commonAppConfig! + 'Data/getcountries';
    updateDeviceInfo = commonAppConfig! + 'Account/UpdateDeviceInfo';
    saveMpin = commonAppConfig! + 'Account/SaveMpin';
    getUserRoles = commonAppConfig! + 'Account/GetUserRoles';
    proceedToLogin = commonAppConfig! + 'Account/ProceedToLogin';
    login = commonAppConfig! + 'Account/Login';
    updateLang = commonAppConfig! + 'Account/UpdateCurrentLanguage';
    validateRoleByMpin = commonAppConfig! + 'Account/ValidateRolebyMpin';
    validateRoleByFP = commonAppConfig! + 'Auth/ValidateRoleByFP';
    validatePublicRole = commonAppConfig! + 'Auth/ValidatePublicRole';
    compareDeviceToken = commonAppConfig! + 'Account/CompareToken';

    //////////////////
    ///   tenantAppConfig!
    //////////////////

    getContracts = tenantAppConfig! + 'Tenant/Contracts/GetContracts';
    getContractDetails =
        tenantAppConfig! + 'Tenant/Contracts/GetContractDetails';
    getCanCheckinContract = tenantAppConfig! + 'Tenant/Contracts/CanCheckIn';
    caseCheckinContract =
        tenantAppConfig! + 'Tenant/Contracts/CaseCheckinContract';
    getNotifications = tenantAppConfig! + 'Tenant/Notifications/Get';
    downloadNotificationFile =
        tenantAppConfig! + 'Tenant/Notifications/DownloadNotificationFile';
    getNotificationFiles =
        tenantAppConfig! + 'Tenant/Notifications/GetNotificationFiles';
    getTenantProfile = tenantAppConfig! + 'Tenant/Profile/Get';
    getServiceRequests =
        tenantAppConfig! + 'Tenant/Dashboard/GetServiceRequests';
    getContractUnits = tenantAppConfig! + 'Tenant/Contracts/GetContractUnits';
    getContractUnitDetails =
        tenantAppConfig! + 'Tenant/Contracts/GetUnitDetails';
    getUnitAditionalDetails =
        tenantAppConfig! + 'Tenant/Contracts/GetUnitAditionalDetails';
    getTenantNotifications = tenantAppConfig! + 'Tenant/Notifications/Get';
    tenantReadNotifications = tenantAppConfig! + 'Tenant/Notifications/Read';
    tenantArchiveNotifications =
        tenantAppConfig! + 'Tenant/Notifications/Archived';
    tenantNotificationsDetails =
        tenantAppConfig! + 'Tenant/Notifications/GetDetails';
    // getUnitDetails = tenantAppConfig! + 'Tenant/Units/GetUnitDetails';
    getContractPayments =
        tenantAppConfig! + 'Tenant/Contracts/GetContractPayments';
    // getpaymentDetails = tenantAppConfig! + 'Tenant/Charges/GetPaymentDetails';
    getContractCharges =
        tenantAppConfig! + 'Tenant/Contracts/GetContractCharges';
    payments = tenantAppConfig! + 'Tenant/Payments';
    paymentsGet = tenantAppConfig! + 'Tenant/Payments/Get';
    getStats = tenantAppConfig! + 'Tenant/Dashboard/GetStats';
    dashboard = tenantAppConfig! + 'dashboard/getdata?TenantId=';
    // tenantDashboardGetData = tenantAppConfig! + 'Tenant/Dashboard/GetDataV1';
    tenantDashboardGetData = tenantAppConfig! + 'Tenant/Dashboard/GetData';
    getOnlinePayments =
        tenantAppConfig! + 'Tenant/GatewayPayment/ViewOnlinePaymant';
    getContractCheques =
        tenantAppConfig! + 'Tenant/Contracts/GetContractCheques';
    toBePaidIn30Days = tenantAppConfig! + 'Tenant/Dashboard/ToBePaidIn30Days';
    contractsExpiringIn30Days =
        tenantAppConfig! + 'Tenant/Contracts/ContractExpire30Days';

    getPropTypes = tenantAppConfig! + 'Tenant/Contracts/GetPropertyTypes';
    getContractStatus = tenantAppConfig! + 'Tenant/Contracts/GetContractStatus';
    getContractswithFilter =
        tenantAppConfig! + 'Tenant/Contracts/GetContractswithFilter';
    contractChargeReceipts =
        tenantAppConfig! + 'Tenant/Contracts/ContractChargeReceipts';
    paymentsDownloadReceipt =
        tenantAppConfig! + 'Tenant/Payments/DownloadReceipt';
    contractDownload = tenantAppConfig! + 'Tenant/Contracts/DownloadContract';
    contractDownloadNew =
        tenantAppConfig! + 'Tenant/Contracts/DownloadContractNew';
    downloadContractTerms =
        tenantAppConfig! + 'Tenant/Contracts/DownloadContractTerms';
    downloadContractTermsNew =
        tenantAppConfig! + 'Tenant/Contracts/DownloadContractTermsNew';
    // downloadContractWithSignature = tenantAppConfig! +
    //     'Tenant/Contracts/DownloadContractWithSignature?ContractId=';
    downloadOfferLetter =
        tenantAppConfig! + 'Tenant/Contracts/DownloadOfferLetter';
    contractRenewalActions =
        tenantAppConfig! + 'Tenant/Contracts/ContractRenewalActions';
    contractNewActions =
        tenantAppConfig! + 'Tenant/Contracts/ContractNewActions';
    getOutstandingPayments =
        tenantAppConfig! + 'Tenant/Contracts/GetOutstandingPayments';
    getOutstandingPaymentsNew =
        tenantAppConfig! + 'Tenant/Contracts/GetOutstandingPaymentsNew';
    updateContractPaymentMethod =
        tenantAppConfig! + 'Tenant/Contracts/UpdateContractPaymentMethod';
    updateContractPaymentMethodNew =
        tenantAppConfig! + 'Tenant/Contracts/UpdateContractPaymentMethodNew';
    updateContractStage =
        tenantAppConfig! + 'Tenant/Contracts/UpdateContractStage';
    updateContractStageNew =
        tenantAppConfig! + 'Tenant/Contracts/UpdateContractStageNew';
    getApproveMunicipal =
        tenantAppConfig! + 'Tenant/Contracts/GetApproveMunicipal';
    getApproveMunicipalNew =
        tenantAppConfig! + 'Tenant/Contracts/GetApproveMunicipalNew';
    downloadSignedContract =
        tenantAppConfig! + 'Tenant/Contracts/DownloadSignedContract';
    canDownloadContract =
        tenantAppConfig! + 'Tenant/Contracts/CanDownloadContract';
    unVerfiedContractPayment =
        tenantAppConfig! + 'Tenant/GatewayPayment/UnVerfiedContractPayment';
    unVerfiedAllPayment = tenantAppConfig! +
        'Tenant/GatewayPayment/UnVerfiedAllPayment?ContractId=';
    getTenanatFaqsQuestions =
        tenantAppConfig! + "Tenant/ServiceRequests/GetFaqs";

    //////////////////
    ///   VendorAppConfig
    //////////////////

    contractorProfile = appConfigVendor! + 'Vendor/Profile/Get';
    getlpoproperties = appConfigVendor! + 'Vendor/Lpo/GetLpoProperties';

    getlpos = appConfigVendor! + 'Vendor/Lpo/GetLpoData';
    getlposdetail = appConfigVendor! + 'Vendor/Lpo/GetLpoDetails';
    getlpoterm = appConfigVendor! + 'Vendor/Lpo/GetTerms';
    getlposervies = appConfigVendor! + 'Vendor/Lpo/GetServices';
    getlpostatus = appConfigVendor! + 'Vendor/Lpo/GetLpoStatus';
    getLpowithFilter = appConfigVendor! + 'Vendor/Lpo/GetAllLpowithFilter';
    getVendorContractsStatus =
        appConfigVendor! + 'Vendor/Contracts/GetContractStatus';
    getVendorContractswithFilter =
        appConfigVendor! + 'Vendor/Contracts/GetContractsWithFilter';
    getVendorAccounts = appConfigVendor! + 'Vendor/Accounts/GetAccountInfo';

    getVendorFaqsCatg = appConfigVendor! + 'Vendor/GeneralData/GetFaqCategories';
    getVendorFaqsQuestionAndDescription =
        appConfigVendor! + 'Vendor/GeneralData/GetFaqs';

    getVendorOffersDetails = appConfigVendor! + "Vendor/Offer/GetOfferDetail";
    getVendorOffers = appConfigVendor! + "Vendor/Offer/GetOffer";

    vendorReadNotification = appConfigVendor! + "Vendor/Notifications/Read";

    //dashboard
    getststs = appConfigVendor! + 'Vendor/Dashboard/GetData';
    getdashboardlpo = appConfigVendor! + 'Vendor/Dashboard/GetLpoProperties';

    contactPerson = appConfigVendor! + 'Vendor/ContactPersons/GetContactPersons';
    accountInfo = appConfigVendor! + 'Vendor/Accounts/GetAccountInfo';
    doc = appConfigVendor! + 'Vendor/Documents/GetDocuments';
    getVendorProfile = appConfigVendor! + 'Vendor/Profile/Get';
    getAllLpo = appConfigVendor! + 'Vendor/Lpo/GetAllLpo';
    getContractFinancialTerms =
        appConfigVendor! + 'Vendor/Contracts/GetContractFinancialTerms';
    getContactPersons =
        appConfigVendor! + 'Vendor/ContactPersons/GetContactPersons';

    //contracts

    getVendorContracts = appConfigVendor! + 'Vendor/Contracts/GetContracts';
    getVendorContractDetails =
        appConfigVendor! + 'Vendor/Contracts/GetContractDetails';
    getVendorContractProperties =
        appConfigVendor! + 'Vendor/Contracts/GetContractProperties';
    lpoInvoices = appConfigVendor! + 'Vendor/Contracts/LpoInvoices';
    contractInvoices = appConfigVendor! + 'Vendor/Contracts/ContractInvoices';

    //////svc req
    ///uploadServiceRequestFiles =
    // getDocType = tenantAppConfig! + 'Vendor/Documents/GetDocumentListByType';
    vendorUploadServiceRequestFiles =
        appConfigVendor! + 'Vendor/ServiceRequests/UploadServiceRequestFiles';
    vendorUploadInvoiceServiceRequestFiles = appConfigVendor! +
        'Vendor/ServiceRequests/UploadInvoiceServiceRequestFiles';
    vendorUpdateServiceRequestFiles =
        appConfigVendor! + 'Vendor/ServiceRequests/UpdateCaseAttachment';
    vendorGetServiceRequestImages =
        appConfigVendor! + 'Vendor/ServiceRequests/GetServiceRequestImages';
    vendorGetServiceRequestDocs =
        appConfigVendor! + 'Vendor/ServiceRequests/GetServiceRequestDocuments';
    vendorRemoveSvcReqPhoto =
        appConfigVendor! + 'Vendor/ServiceRequests/RemoveServiceRequestFiles';
    vendorCloseRequest =
        appConfigVendor! + 'Vendor/ServiceRequests/CloseServiceRequest';
    vendorAcknowledgeCase =
        appConfigVendor! + 'Vendor/ServiceRequests/AcknowledgeCase';
    contractorRejected =
        appConfigVendor! + 'Vendor/ServiceRequests/ContractorRejected';
    uploadTenantSign =
        appConfigVendor! + 'Vendor/ServiceRequests/UploadTenantSign';
    uploadVendorSign =
        appConfigVendor! + 'Vendor/ServiceRequests/UploadVendorSign';
    // getTenantSignature =
    // appConfigVendor! + 'Vendor/ServiceRequests/GetVendorSignature?CaseNo=';
    // getVendorSignature =
    //     appConfigVendor! + 'Vendor/ServiceRequests/GetTenantSignature?CaseNo=';
    updateProfileRequest =
        appConfigVendor! + 'Vendor/Profile/UpdateProfileRequest';

    vendorDashboardAllInvoces =
        appConfigVendor! + "Vendor/Dashboard/GetAllInvoices";

    vendorGetDocsByType = appConfigVendor! +
        'Vendor/ServiceRequests/GetServiceRequestDocumentsByType';

    vendorDownloadDoc = appConfigVendor! +
        'Vendor/ServiceRequests/DownloadServiceRequestDocuments';
    vendorGetTickets =
        appConfigVendor! + 'Vendor/ServiceRequests/GetTicketReplies';
    vendorAddTicket = appConfigVendor! + 'Vendor/ServiceRequests/AddTicketReply';
    vendorDownloadTicketFile =
        appConfigVendor! + 'Vendor/ServiceRequests/DownloadTicketFile';
    vendorGetSRReportDetail =
        appConfigVendor! + 'Vendor/ServiceRequests/GetSRReportDetail';
    getLpoDropdownForIvoice = appConfigVendor! + 'Vendor/Lpo/LpoDropdown';
    getAMCDropdownForInvoice = appConfigVendor! + 'Vendor/Lpo/AMCDropdown';
    getAmcInstallmentForInvoice = appConfigVendor! + 'Vendor/Lpo/AmcInstallment';
    ////////////////////////
    ///DROP 2 APIs
    ///////////////////////
    ///
    ///
    //////////////
    ///common
    /////////////

// get document for tenant
    tenantGetServiceRequestDocs =
        appConfigVendor! + 'Tenant/ServiceRequests/GetServiceRequestDocuments';

    getLanguage = commonAppConfig! + 'Auth/Getlanguages';
    updateLanguage = commonAppConfig! + 'Auth/UpdateUserLanguage';

    //////////////////
    ///   tenantAppConfig!
    //////////////////

    saveLanguage = tenantAppConfig! + 'Auth/SaveLanguage';
    getTenantServiceRequests =
        tenantAppConfig! + 'Tenant/ServiceRequests/GetTenantServiceRequests';
    getCaseTypes = tenantAppConfig! + 'Tenant/ServiceRequests/GetCaseTypes';
    caseCategory = tenantAppConfig! + 'Tenant/ServiceRequests/CaseCategory';
    caseSubCategory =
        tenantAppConfig! + 'Tenant/ServiceRequests/CaseSubCategory';
    getCities = tenantAppConfig! + 'Tenant/ServiceRequests/GetCities';
    getTenantContractUnits =
        tenantAppConfig! + 'Tenant/ServiceRequests/GetTenantContractUnit';
    getContactTiming =
        tenantAppConfig! + 'Tenant/ServiceRequests/GetContactTiming';
    getPreferredLanguages =
        tenantAppConfig! + 'Tenant/ServiceRequests/GetPreferredLanguages';
    getServiceRequestDetails =
        tenantAppConfig! + 'Tenant/ServiceRequests/GetServiceRequestDetails';
    saveServiceRequest =
        tenantAppConfig! + 'Tenant/ServiceRequests/SaveServiceRequestv1';
    cancelServiceRequest =
        tenantAppConfig! + 'Tenant/ServiceRequests/CancelRequest';
    getSurveyQuestions = tenantAppConfig! + 'Tenant/Survey/GetSurveyQuestions';
    getSurveyQuestionAnswers =
        tenantAppConfig! + 'Tenant/Survey/GetSurveyQuestionAnswer';
    saveSurveyAnswer = tenantAppConfig! + 'Tenant/Survey/SaveSurveyAnswers';

    getExtensionPeriods = tenantAppConfig! + 'Tenant/Case/GetExtensionPeriod';
    terminateContract = tenantAppConfig! + 'Tenant/Case/AddTerminateRequest';
    checkinContract = tenantAppConfig! + 'Tenant/Case/CheckinContract';
    extendContract = tenantAppConfig! + 'Tenant/Case/AddExtensionRequest';
    renewContract = tenantAppConfig! + 'Tenant/Case/AddRenewalRequest';
    getContractRenewalInfo =
        tenantAppConfig! + 'Tenant/Case/GetRenewalContractInfo';
    getTerminateReasons = tenantAppConfig! + 'Tenant/Case/GetVacatingList';
    legalSettlementReq =
        tenantAppConfig! + 'Tenant/Case/LegalSettlementContract';

    reopenSvcReq =
        tenantAppConfig! + 'Tenant/ServiceRequests/ReopenServiceRequest';

    getPropertyImage = tenantAppConfig! + 'Tenant/Contracts/GetPropertyImage';

    getUnitImage = tenantAppConfig! + 'Tenant/Contracts/GetUnitImage';
    getTicketReplies =
        tenantAppConfig! + 'Tenant/ServiceRequests/GetTicketReplies';
    addTicketReply = tenantAppConfig! + 'Tenant/ServiceRequests/AddTicketReply';
    downloadTicketFile =
        tenantAppConfig! + 'Tenant/ServiceRequests/DownloadTicketFile';

    // uploadTicketFiles =
    //     tenantAppConfig! + 'Tenant/ServiceRequests/UploadTicketFiles';
    // commmented 14/oct/2022
    // uploadServiceRequestFiles =
    //     tenantAppConfig! + 'Tenant/ServiceRequests/';
    uploadServiceRequestFiles =
        tenantAppConfig! + 'Tenant/ServiceRequests/UploadServiceRequestFiles';
    uploadServiceRequestFilesNew =
        tenantAppConfig! + 'Tenant/ServiceRequests/UploadServiceRequestFilesNew';
    // upload EMID Detail
    uploadEIDFilesDetail = tenantAppConfig! +
        'Tenant/ServiceRequests/UploadServiceRequestEmirateId';
    updateServiceRequestFiles =
        tenantAppConfig! + 'Tenant/ServiceRequests/UpdateCaseAttachment';
    updateContractDocumentStage =
        tenantAppConfig! + 'Tenant/ServiceRequests/UpdateContractDocumentStage';
    // getServiceRequestImages = tenantAppConfig! +
    //     'Tenant/ServiceRequests/GetServiceRequestImages?CaseNo=';
    getServiceRequestThumbnailList = tenantAppConfig! +
        'Tenant/ServiceRequests/GetServiceRequestThumbnailList';

    getTenantFaqsCatg =
        tenantAppConfig! + "Tenant/ServiceRequests/GetFaqCategories";
    removeSvcReqPhoto =
        tenantAppConfig! + 'Tenant/ServiceRequests/RemoveServiceRequestFiles';

    updateTenantProfile =
        tenantAppConfig! + "Tenant/Profile/UpdateProfileRequest";

    canEditProfile = tenantAppConfig! + 'Tenant/Profile/CanEditProfile';

    /////////
    saveTenantFeedback =
        tenantAppConfig! + "Tenant/ServiceRequests/SaveSRFeedback";
    getTenantFeedback =
        tenantAppConfig! + "Tenant/ServiceRequests/GetSRFeedback";

    getOffersDetails = tenantAppConfig! + "Tenant/Offer/GetOfferDetail";

    getOffers = tenantAppConfig! + "Tenant/Offer/GetOffer";

    getDashboardPopup =
        tenantAppConfig! + "Tenant/Dashboard/GetDashboardNotifications";

    getContractPayable = tenantAppConfig! + "Tenant/Contracts/ContractPayables";
    onlinePayables = tenantAppConfig! + 'Tenant/Contracts/OnlinePayments';
    onlinePayablesNew = tenantAppConfig! + 'Tenant/Contracts/OnlinePaymentsNew';
    addContractPayment =
        tenantAppConfig! + 'Tenant/Contracts/AddContractPayments';
    updateContractPaymentAddress =
        tenantAppConfig! + 'Tenant/Contracts/UpdateContractPaymentAddress';
    updateContractPaymentAddressNew =
        tenantAppConfig! + 'Tenant/Contracts/UpdateContractPaymentAddressNew';
    downloadCheque = tenantAppConfig! + 'Tenant/Contracts/DownloadCheque';
    downloadChequeNew = tenantAppConfig! + 'Tenant/Contracts/DownloadChequeNew';
    removeCheque = tenantAppConfig! + 'Tenant/Contracts/RemoveContractCheque';
    removeChequeNew =
        tenantAppConfig! + 'Tenant/Contracts/RemoveContractChequeNew';
    registerPayment = tenantAppConfig! + 'Tenant/GatewayPayment/RegisterPayment';
    registerPaymentNew =
        tenantAppConfig! + 'Tenant/GatewayPayment/RegisterPaymentNew';
    getPolicyData =
        tenantAppConfig! + 'Tenant/GeneralData/GetConfigurationValue';
    createSignatureRequest =
        tenantAppConfig! + 'Tenant/Case/CreateSignatureRequest';
    getReqDocs =
        tenantAppConfig! + 'Tenant/ServiceRequests/GetServiceRequestDocuments';
    getReqDocsPDF = tenantAppConfig! +
        'Tenant/ServiceRequests/GetServiceRequestDocumentsPdf';
    tenantDownloadDoc = tenantAppConfig! +
        'Tenant/ServiceRequests/DownloadServiceRequestDocuments';

    tenantGetDocsByType = tenantAppConfig! +
        'Tenant/ServiceRequests/GetServiceRequestDocumentsByType';

    //////////////////
    ///  VendorAppConfig
    //////////////////
    getPropertyImageVendor =
        appConfigVendor! + 'Vendor/Contracts/GetPropertyImage';
    contractorProfile = appConfigVendor! + 'Vendor/Profile/Get?UserId=';
    getVendorServiceRequest =
        appConfigVendor! + 'Vendor/ServiceRequests/GetVendorServiceRequests';
    getVendorServiceRequestDetails =
        appConfigVendor! + 'Vendor/ServiceRequests/GetServiceRequestDetail';
    vendorSaveInvoiceServiceRequest =
        appConfigVendor! + 'Vendor/ServiceRequests/SaveInvoiceServiceRequest';
    vendorGetInvoiceServiceRequest =
        appConfigVendor! + 'Vendor/ServiceRequests/GetCaseServiceRequestDetail';

    vendorNotificationDetails =
        appConfigVendor! + "Vendor/Notifications/GetDetails";
    getVendorNotification = appConfigVendor! + "Vendor/Notifications/Get";
    vendorArchiveNotification =
        appConfigVendor! + "Vendor/Notifications/Archived";

    //////////////////
    ///   Public
    //////////////////
    getEmirates = publicAppConfig! + 'api/Public/Property/GetEmirate';
    getPropertyCategory =
        publicAppConfig! + 'api/Public/Property/GetPropertyCategory';
    //////////Comment by kamran
    // getUnitType = publicAppConfig! + 'api/Public/Property/GetUnitType';
    getUnitTypeByCategoryId =
        publicAppConfig! + 'api/Public/Property/GetUnitTypeByCategory';
    // getProperties = publicAppConfig! +
    //     'api/Public/Property/GetProperties?PropertyCategoryID=';
    getProperties = publicAppConfig! + 'api/Public/Property/GetUnitProperties';
    getPropertyDetail =
        publicAppConfig! + 'api/Public/Property/GetUnitPropertyDetail';
    ///////////
    getPublicFaqsCatg =
        publicAppConfig! + 'api/public/GeneralData/GetFaqCategories';
    getPublicFaqsQuestionAndDescription =
        publicAppConfig! + 'api/public/GeneralData/GetFaqs';
    getPublicBookingAgentList =
        publicAppConfig! + 'api/Public/BookingRequest/GetAgentList';

    // savePublicBookingRequest =
    //     publicAppConfig! + "api/Public/BookingRequest/SaveBookingRequestOld";
    savePublicBookingRequest =
        publicAppConfig! + "api/Public/BookingRequest/SaveBookingRequest";

    getPublicServices =
        publicAppConfig! + "api/Public/BookingRequest/GetServiceRequests";
    publicServiceMianinfo =
        publicAppConfig! + "api/Public/BookingRequest/GetRequestDetails";
    savePublicFeedback =
        publicAppConfig! + "api/public/BookingRequest/SaveBRFeedback";
    getPublicFeedback =
        publicAppConfig! + "api/public/BookingRequest/GetBRFeedback";
    getPublicLocation = publicAppConfig! + "api/public/GeneralData/GetLocations";
    getPublicFeedback =
        publicAppConfig! + "api/public/BookingRequest/GetBRFeedback";
    getPublicLocation = publicAppConfig! + "api/public/GeneralData/GetLocations";
    cancelPublicBookingreq =
        publicAppConfig! + "api/public/BookingRequest/CancelRequest";
    getBookingReqImages = publicAppConfig! + 'api/Public/Property/GetUnitImage';
    getBookingReqPropertyImage =
        publicAppConfig! + 'api/Public/Property/GetPropertyImage';
    publicAddTicketReply =
        publicAppConfig! + "api/Public/BookingRequest/AddTicketReply";
    publicGetTicketReplies =
        publicAppConfig! + "api/Public/BookingRequest/GetTicketReplies";
    publicDownloadTicketFile =
        publicAppConfig! + "api/Public/BookingRequest/DownloadTicketFile";

    getPublicOffers = publicAppConfig! + "api/Public/Offer/GetOffer";
    getPublicOffersDetails =
        publicAppConfig! + "api/Public/Offer/GetOfferDetail";
    publicCanEditProfile =
        publicAppConfig! + "api/Public/Profile/CanEditProfile";

    publicGetProfile = publicAppConfig! + "api/Public/Profile/GetProfile";
    publicUpdateProfile =
        publicAppConfig! + "api/Public/Profile/UpdateProfileRequest";
    updatePublicProfile = commonAppConfig! + "Auth/UpdateUserProfile";
    publicUpdateProfile2 = publicAppConfig! + "api/Public/Profile/UpdateProfile";
    getPublicServicesCategoriesDetails =
        publicAppConfig! + "api/Public/GeneralData/GetServices";
    getPublicServiceCategories =
        publicAppConfig! + "api/Public/GeneralData/GetServicesCategories";
    publicPropertyManagement =
        publicAppConfig! + "api/Public/GeneralData/GetPropertyManagement";
    publicNotificationDetails =
        publicAppConfig! + "api/Public/Notifications/GetDetails";
    getPublicNotification = publicAppConfig! + "api/Public/Notifications/Get";
    publicNotificationDetails =
        publicAppConfig! + "api/Public/Notifications/GetDetails";
    getPublicNotification = publicAppConfig! + "api/Public/Notifications/Get";
    publicArchivedNotifications =
        publicAppConfig! + "api/Public/Notifications/Archived";
    publicReadNotifications = publicAppConfig! + "api/Public/Notifications/Read";
    publicCountNotifications =
        publicAppConfig! + "api/Public/Notifications/GetCountNotification";

    ////////////End Points////////////////
    ///////////  Landlord  //////////////

    /// Notification Done

    getLandlordNotifications =
        landlordAppConfig! + 'Notification/GetNotifications';
    landLordReadNotifications =
        landlordAppConfig! + 'Notification/ReadArchiveNotification';
    landLordArchiveNotifications =
        landlordAppConfig! + 'Notification/ReadArchiveNotification';
    landLordNotificationsDetails =
        landlordAppConfig! + 'Notification/GetNotificationDetails';
    landLorddownloadNotificationFile =
        landlordAppConfig! + 'Notification/DownloadNotificationFile';
    landLordgetNotificationFilese =
        landlordAppConfig! + 'Notification/GetNotificationFiles';

    // Profile and Faqs
    getLandLordProfile = landlordAppConfig! + 'Landlord/Profile/GetProfile';
    canEditLandLordProfile =
        landlordAppConfig! + 'Landlord/Profile/CanEditProfile';
    updateLandLordProfile =
        landlordAppConfig! + 'Landlord/Profile/UpdateProfileRequest';
    getLandlordFaqsCatg = landlordAppConfig! + "Faq/GetFaqCategories";
    getLandlordFaqs = landlordAppConfig! + "Faq/GetFaqs";

    // Contracts
    getLandlordContracts = landlordAppConfig! + 'Landlord/Contract/GetContracts';
    getLandlordContractswithFilter =
        landlordAppConfig! + 'Landlord/Contract/GetContractsWithFilter';
    getLandlordContractStatus =
        landlordAppConfig! + 'Landlord/Contract/GetContractStatus';
    getLandlordPropTypes =
        landlordAppConfig! + 'Landlord/Property/GetPropertyTypes';
    getLandlordEmirate =
        landlordAppConfig! + 'Landlord/Property/GetPropertyEmirate';
    getLandlordCategory =
        landlordAppConfig! + 'Landlord/Property/GetPropertyCategory';
    getPropertyWithFilter =
        landlordAppConfig! + 'Landlord/Property/GetPropertyWithFilter';
    getLandlordContractPayable =
        tenantAppConfig! + "Landlord/Contract/ContractPayables";
    getLandlordContractDetails =
        landlordAppConfig! + 'Landlord/Contract/GetContractDetails';
    getLandlordContractUnits =
        landlordAppConfig! + 'Landlord/Contract/GetContractUnits';

    // Properties & GetData
    // Dashboard GetData
    landlordDashboardGetData = landlordAppConfig! + 'Landlord/Property/GetData';
    // Properties
    getLandlordProperties = landlordAppConfig! + 'Landlord/Property/GetProperty';
    getLandlordPropertyUnits =
        landlordAppConfig! + 'Landlord/Property/GetPropertyUnits';
    getLandlordUitImages =
        landlordAppConfig! + 'api/Public/Property/GetUnitImage';
    getLandlordPropertyDetails =
        landlordAppConfig! + 'Landlord/Property/GetPropertyDetails';
    getLandlordPropertyUnitDetails =
        landlordAppConfig! + 'Landlord/Property/GetPropertyUnitDetails';

    // Payment
    getLandlordPayments = landlordAppConfig! + 'Landlord/Payments/Get';
    getLandlordContractPayments =
        landlordAppConfig! + 'Landlord/Contract/GetContractPayments';
    getLandlordUnVeridiedPayments =
        landlordAppConfig! + 'Landlord/Contract/GetContractPayments';
    getLandlordContractCheques =
        landlordAppConfig! + 'Landlord/Contract/GetContractCheques';
    getLandlordContractChargeReceipts =
        landlordAppConfig! + 'Landlord/Contract/ContractChargeReceipts';
    getLandlordContractCharges =
        landlordAppConfig! + 'Landlord/Contract/GetContractCharges';
    unVerfiedLandlordContractPayment =
        landlordAppConfig! + 'Landlord/Contract/UnVerfiedContractPayment';
    getLandlordUnits = landlordAppConfig! + 'Landlord/Contract/GetUnits';
    paymentsDownloadReceiptLandlord =
        landlordAppConfig! + 'Landlord/Payments/DownloadReceipt';
    getContractChargesLandlord =
        landlordAppConfig! + 'Landlord/Contract/GetContractCharges';
    contractChargeReceiptsLandlord =
        landlordAppConfig! + 'Landlord/Contract/ContractChargeReceipts';

    // reports
    // report
    getLandlordReportDropDownType =
        landlordAppConfig! + "Landlord/Report/GetDropdownByType";
    downloadAMCReport = landlordAppConfig! + 'Landlord/Report/GenerateAMCReport';
    getDropDownType = landlordAppConfig! + 'Landlord/Report/GetDropdownByType';
    generateAMCReportSummary =
        landlordAppConfig! + 'Landlord/Report/GenerateAMCReportSummary';
    downloadGenerateLPOReport =
        landlordAppConfig! + 'Landlord/Report/GenerateLPOReport';
    generateLPOReportSummary =
        landlordAppConfig! + 'Landlord/Report/GenerateLPOReportSummary';
    downloadGenerateBERReport =
        landlordAppConfig! + 'Landlord/Report/GenerateBERReport';
    downloadGenerateVATReport =
        landlordAppConfig! + 'Landlord/Report/GenerateVATReport';
    generateVATReportSummary =
        landlordAppConfig! + 'Landlord/Report/GenerateVATReportSummary';
    downloadGenerateChequeRegisterReport =
        landlordAppConfig! + 'Landlord/Report/GenerateChequeRegisterReport';
    generateChequeRegisterReportSummary = landlordAppConfig! +
        'Landlord/Report/GenerateChequeRegisterReportSummary';
    downloadGenerateLegalCaseReport =
        landlordAppConfig! + 'Landlord/Report/GenerateLegalCaseReport';
    generateLegalCaseReport =
        landlordAppConfig! + 'Landlord/Report/GenerateLegalCaseReport';
    generateLegalCaseReportSummary =
        landlordAppConfig! + 'Landlord/Report/GenerateLegalCaseReportSummary';
    generateContractReport =
        landlordAppConfig! + 'Landlord/Report/GenerateLandLordGetContract';
    generateContractReportSummary = landlordAppConfig! +
        'Landlord/Report/GenerateLandLordGetContractSummary';
    downloadGenerateReceiptRegisterReport =
        landlordAppConfig! + 'Landlord/Report/GenerateReceiptRegisterReport';
    generateReceiptRegisterReportSummary = landlordAppConfig! +
        'Landlord/Report/GenerateReceiptRegisterReportSummary';
    downloadGenerateUnitStatusReport =
        landlordAppConfig! + 'Landlord/Report/GenerateUnitStatusReport';
    generateUnitStatusReportSummary =
        landlordAppConfig! + 'Landlord/Report/GenerateUnitStatusReportSummary';
    downloadGenerateLandLordGetContracts =
        landlordAppConfig! + 'Landlord/Report/GenerateLandLordGetContracts';
    downloadGenerateBuildingStatusReport =
        landlordAppConfig! + 'Landlord/Report/GenerateBuildingStatusReport';
    generateBuildingStatusReportSummary = landlordAppConfig! +
        'Landlord/Report/GenerateBuildingStatusReportSummary';
    occupancyVacancyRegisterReport =
        landlordAppConfig! + 'Landlord/Report/OccupancyVacancyRegister';
    occupancyVacancyRegisterSummary =
        landlordAppConfig! + 'Landlord/Report/OccupancyVacancyRegisterSummary';
    landlordInvoces = landlordAppConfig! + "Landlord/Property/GetAllInvoices";
  }
}
