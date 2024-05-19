import 'package:fap_properties/data/helpers/session_controller.dart';
import 'package:fap_properties/data/services/public_services/public_booking_request/public_bookingreq_get_images_service.dart';
import 'package:fap_properties/data/services/public_services/public_faqs/public_faqs_categories_service.dart';
import 'package:fap_properties/data/services/public_services/public_feedback/public_get_feedback_service.dart';
import 'package:fap_properties/data/services/public_services/public_feedback/public_save_feedback_service.dart';
import 'package:fap_properties/data/services/public_services/public_location/public_location_service.dart';
import 'package:fap_properties/data/services/public_services/public_notifications/get_public_notifications_services.dart';
import 'package:fap_properties/data/services/public_services/public_notifications/public_archive_notifications_services.dart';
import 'package:fap_properties/data/services/public_services/public_notifications/public_count_notification_service.dart';
import 'package:fap_properties/data/services/public_services/public_notifications/public_notifications_detail_services.dart';
import 'package:fap_properties/data/services/public_services/public_notifications/public_read_notifications_services.dart';
import 'package:fap_properties/data/services/public_services/public_offers/public_offer_details_service.dart';
import 'package:fap_properties/data/services/public_services/public_offers/public_offers_service.dart';
import 'package:fap_properties/data/services/public_services/public_profile/public_can_edit_profile_service.dart';
import 'package:fap_properties/data/services/public_services/public_profile/public_get_profile_service.dart';
import 'package:fap_properties/data/services/public_services/public_profile/public_update_profile_service.dart';
import 'package:fap_properties/data/services/public_services/public_properties_services/public_services_categoreis_service.dart';
import 'package:fap_properties/data/services/public_services/public_properties_services/public_services_categories_details_service.dart';
import 'package:fap_properties/data/services/public_services/public_property_management/public_property_management_service.dart';
import 'package:fap_properties/data/services/public_services/public_services_myrequest/public_services_maininfo_service.dart';
import 'package:fap_properties/data/services/public_services/public_services_myrequest/public_services_myrequest_service.dart';
import 'package:fap_properties/data/services/public_services/public_updates/download_ticket_files.dart';
import 'package:fap_properties/data/services/public_services/public_updates/public_add_ticket_service.dart';
import 'package:fap_properties/data/services/public_services/public_updates/public_get_tickets_service.dart';

import '../services/public_services/get_city_services.dart';
import '../services/public_services/get_properties_services.dart';
import '../services/public_services/get_property_category_services.dart';
import '../services/public_services/get_property_detail_services.dart';
import '../services/public_services/get_unit_type_services.dart';
import '../services/public_services/public_booking_request/public_booking_request_service.dart';
import '../services/public_services/public_booking_request/public_save_booking_request_service.dart';
import '../services/public_services/public_cancel_bookingreq/public_cancel_bookingreq_service.dart';
import '../services/public_services/public_faqs/public_faqs_question_and_description_service.dart';
import '../services/public_services/public_profile/public_update_profile_service2.dart';

class PublicRepositoryDrop2 {
  // static Future<dynamic> getLanguage() => GetLanguageServices.getData();
  static Future<dynamic> getEmirates() => GetCityServices.getData();
  static Future<dynamic> getPropertyCategory() =>
      GetPropertyCategoryServices.getData();
  static Future<dynamic> getUnitType(category) =>
      GetUnitTypeServices.getData(category);
  static Future<dynamic> getProperties(
          String propName,
          minRentAmount,
          maxRentAmount,
          areaType,
          minAreaSize,
          maxAreaSize,
          minRoom,
          maxRoom,
          pagenum) =>
      GetPropertiesServices.getData(propName, minRentAmount, maxRentAmount,
          areaType, minAreaSize, maxAreaSize, minRoom, maxRoom, pagenum);
  static Future<dynamic> getPropertiesPagination(
          String propName,
          minRentAmount,
          maxRentAmount,
          areaType,
          minAreaSize,
          maxAreaSize,
          minRoom,
          maxRoom,
          pageNo) =>
      GetPropertiesServices.getDataPagination(
          propName,
          minRentAmount,
          maxRentAmount,
          areaType,
          minAreaSize,
          maxAreaSize,
          minRoom,
          maxRoom,
          pageNo);
  static Future<dynamic> getPropertyDetail() =>
      GetPropertyDetailServices.getData();
  ////////////public faqs
  static Future<dynamic> getPublicFaqsCatg() =>
      PublicFaqsCategoriesSerice.getPublicFaqsCatg();

  static Future<dynamic> getPublicFaqsQuestionAndDescription(int categoryId) =>
      PublicFaqsQuestionsAndDescriptionSerice.getPublicFaqsQuestion(categoryId);

  static Future<dynamic> getPublicBookingAgent() =>
      PublicBookingRequestAgentServices.getAgentList();
  static Future<dynamic> savePublicBookingRequest(
          dynamic propertyID,
          dynamic description,
          dynamic contractUnitId,
          dynamic otherContactPersonName,
          dynamic otherContactPersonMobile,
          dynamic agentId) =>
      PublicSaveBookingRequestService.saveFeedbackData(
          propertyID,
          description,
          contractUnitId,
          otherContactPersonName,
          otherContactPersonMobile,
          agentId);
  static Future<dynamic> getServiceRequest() =>
      PublicGetServiceMyRequestService.getServiceRequest();
  static Future<dynamic> getServiceMainInfo(int caseno) =>
      PublicServiceMainInfoService.getServiceMainInfo(caseno);
  static Future<dynamic> savePublicFeedback(
          int caseId, String description, double rating) =>
      PublicSaveFeedbackServices.saveFeedbackData(caseId, description, rating);
  static Future<dynamic> getPublicFeedback(int caseNo) =>
      PublicGetFeedbackServices.getfeedback(caseNo);
  static Future<dynamic> getPublicLocation() =>
      PublicLocationServices.getLocation();
  static Future<dynamic> cancelBookingRequest(int caseNo) =>
      PublicCancelBookingRequestService.cancelBookingRequest(caseNo);
  static Future<dynamic> getBookingreqImagesProperty(int propertyId) =>
      PublicBookingRequestGetImagesServices.getPropertyImages(propertyId);
  static Future<dynamic> getBookingreqImages(int unitId) =>
      PublicBookingRequestGetImagesServices.getImages(unitId);
  static Future<dynamic> publicAddTicketReply(
          String reqNo, String message, String path) =>
      PublicAddTicketService.addTicketData(reqNo, message, path);
  static Future<dynamic> publicGetTicketReply(String reqNo) =>
      PublicGetTicketsService.getData(reqNo);
  static Future<dynamic> downloadTicketFile(int id) =>
      PublicDownloadTenantTicketFiles.getData(id);

  static Future<dynamic> getOffersDetails(String offerId) =>
      PublicOffersDetailsService.getOffersDetails(offerId);
  static Future<dynamic> getOffers() => PublicOffersSerice.getOffers();

  static Future<dynamic> updateProfile(
          String name, String mobileNo, String email) =>
      PublicUpdateProfileService.updateProfile(name, mobileNo, email);
  static Future<dynamic> updatePublicProfile(
          String name, String userID, String email) =>
      PublicUpdateProfileService.updatePublicProfile(name, userID, email);
  static Future<dynamic> updateProfile2(String name, String email) =>
      PublicUpdateProfileService2.updateProfile(name, email);
  static Future<dynamic> canEditProfile() =>
      PublicCanEditProfileService.canEditProfile();

  static Future<dynamic> publicPropertyManagement() =>
      PublicPropertyManagementService.getPropertyManagement();

  static Future<dynamic> getProfile() => PublicGetProfileService.getProfile();
  static Future<dynamic> getServiceCategories() =>
      PublicServicesCategoriesService.getServiceCategories();

  static Future<dynamic> getServiceCategoriesDetails(int categoryId) =>
      PublicServicesCategoriesDetailsService.getServiceCategoriesDetails(
          categoryId);

  static Future<dynamic> publicGetNotification(String status) =>
      PublicGetNotificationsServices.getNotification(status);
  static Future<dynamic> publicGetNotificationPagination(
          String status, pageNo) =>
      PublicGetNotificationsServices.getNotificationPagination(status, pageNo);

  static Future<dynamic> publicNotificationDetails() =>
      PublicNotificationsDetailServices.getNotificationDetails(
          SessionController().getNotificationId());

  static Future<dynamic> archivedNotifications() =>
      PublicArchiveNotificationsServices.getArchivedNotifications();
  static Future<dynamic> readNotifications() =>
      PublicReadNotificationsServices.getReadNotification();
  static Future<dynamic> countNotifications() =>
      PublicCountNotificationsServices.getNotificationsCount();
}
