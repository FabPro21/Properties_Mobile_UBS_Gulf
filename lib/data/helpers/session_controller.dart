import 'package:fap_properties/data/models/auth_models/get_user_roles_model.dart';
import 'package:fap_properties/data/models/auth_models/verify_user_otp_model.dart';
import 'package:get/get.dart';

class SessionController {
  static final SessionController _instance = SessionController._internel();

  // Companies
  // 1 Fab Properties
  // 2 MENA Real Estate
  // Must Add iosAppID *******
  int isFabApp = 1;

  User _user;
  String vendorUserType = "";
  String _loginToken = "";
  String _token = "";
  String _publicToken = "";
  String _deviceToken = "";
  String _phone = "";
  String _dialingCode = "+971";
  String _selectedFlag;
  int _statusCode;
  String _otpCode;
  String _goToDashboard;
  String _contractNo;
  String _lpoId;
  String _transactionId;
  String _caseTypeId = "";
  String _caseCategoryId = "";
  String _notificationId;
  int _contractID;
  int _contractUnitId;
  String _contractStatus = "Please Select...";
  String _caseNo;
  String _agentId;
  String _lpoRefNo;
  String _url = "";
  String _tenantId = "";
  String _userNameAr = "";
  int _selectedRoleId = 0;
  bool _resetMpin = false;
  int _selectedLang = 1;
  String _propId = "";
  String _propCatId = "";
  String _unitTypeName = "";
  String _propCatName = "";
  String _cityId = "";
  Map<String, dynamic> _notificationData;
  bool enableSSL = true;
  bool fingerprint = false;
  int userID = -1;
  bool enableFireBaseOTP = false;

  String idNumber;
  String storeAppVerison;

  String videoPath;
  String videoPathFromAsset;
  String videoURl;

  factory SessionController() {
    return _instance;
  }

  SessionController._internel() {
    _user = User();
  }
  void setLanguage(int id) {
    _selectedLang = id;
  }

  int getLanguage() {
    return _selectedLang;
  }

  RxBool showArea = true.obs;

  void setResetMpin(bool reset) {
    _resetMpin = reset;
  }

  bool getResetMpin() {
    return _resetMpin;
  }

  void setSelectedRoleId(int roleId) {
    _selectedRoleId = roleId;
  }

  int getSelectedRoleId() {
    return _selectedRoleId;
  }

  void setUser(User user) {
    _user = user;
  }

  void setUserName(String name) {
    _user.name = name;
  }

  void setUserNameAr(String name) {
    _userNameAr = name;
    _user.fullNameAr = name;
  }

  String getUserNameAr() {
    return _userNameAr;
  }

  void setUserID(String id) {
    userID = int.parse(id);
    _user.userId = int.parse(id);
  }

  int getUserID() {
    return userID;
  }

  void setToken(String token) {
    _token = token;
  }

  String getToken() {
    return _token;
  }

  void setLoginToken(String token) {
    _loginToken = token;
  }

  String getLoginToken() {
    return _loginToken;
  }

  void setfingerprint(bool fp) {
    fingerprint = fp;
  }

  bool getfingerprint() {
    return fingerprint;
  }

  void setPublicToken(String token) {
    _publicToken = token;
  }

  String getPublicToken() {
    return _publicToken;
  }

  void setStatusCode(int statusCode) {
    _statusCode = statusCode;
  }

  int getStatusCode() {
    return _statusCode;
  }

  void setDeviceTokken(String deviceToken) {
    _deviceToken = deviceToken;
  }

  String getDeviceTokken() {
    return _deviceToken;
  }

  User getUser() {
    return _user;
  }

  int getUserId() {
    return _user.userId;
  }

  String getUserName() {
    // if (_selectedLang == 1)
    //   return _user.name;
    // else
    //   return _user.fullNameAr;
    return _user.name;
  }

  String getUserMobile() {
    return _user.mobile;
  }

  String getUserEmail() {
    return _user.email;
  }

  void setUserRoles(List<Role> roles) {
    _user.roles = roles;
  }

  List<Role> getUserRole() {
    return _user.roles;
  }

  int getUserRoleLength() {
    return _user.roles.length;
  }

  void setOtpCode(String otpCode) {
    _otpCode = otpCode;
  }

  String getOtpCode() {
    return _otpCode;
  }

  void setGoToDashboard(String goToDashboard) {
    _goToDashboard = goToDashboard;
  }

  String getGoToDashboard() {
    return _goToDashboard;
  }

  void setPhone(String phone) {
    _phone = phone;
  }

  String getPhone() {
    return _phone;
  }

  void setDialingCode(String dialingCode) {
    _dialingCode = dialingCode;
  }

  String getDialingCode() {
    return _dialingCode;
  }

  void setSelectedFlag(String selectedFlag) {
    _selectedFlag = selectedFlag;
  }

  String getSelectedFlag() {
    return _selectedFlag;
  }

  void setContractNo(String contractNo) {
    _contractNo = contractNo;
  }

  String getContractNo() {
    return _contractNo;
  }

  void setLpoId(String lpoId) {
    _lpoId = lpoId;
  }

  String getLpoId() {
    return _lpoId;
  }

  void setTransactionId(String transactionId) {
    _transactionId = transactionId;
  }

  String getTransactionId() {
    return _transactionId;
  }

  void setNotificationId(String notificationId) {
    _notificationId = notificationId;
  }

  String getNotificationId() {
    return _notificationId;
  }

  void setContractID(int contractID) {
    _contractID = contractID;
  }

  int getContractID() {
    return _contractID;
  }

  void setContractUnitID(int unitId) {
    _contractUnitId = unitId;
  }

  int getContractUnitID() {
    return _contractUnitId;
  }

  void setContractStatus(String contractStatus) {
    _contractStatus = contractStatus;
  }

  String getContractStatus() {
    return _contractStatus;
  }

  void setCaseTypeId(String caseTypeId) {
    _caseTypeId = caseTypeId;
  }

  String getCaseTypeId() {
    return _caseTypeId;
  }

  void setCaseCategoryId(String caseCategoryId) {
    _caseCategoryId = caseCategoryId;
  }

  String getCaseCategoryId() {
    return _caseCategoryId;
  }

  String getPropId() {
    return _propId;
  }

  void setPropId(String propId) {
    _propId = propId;
  }

  String getPropCatId() {
    return _propCatId;
  }

  void setPropCatId(String propCatId) {
    _propCatId = propCatId;
  }
///////////

  String getPropCatName() {
    return _propCatName;
  }

  void setPropCatName(String propCatName) {
    _propCatName = propCatName;
  }

  ///
  String getUnitTypeName() {
    return _unitTypeName;
  }

  void setUnitTypeName(String unitTypeName) {
    _unitTypeName = unitTypeName;
  }

  String getCityId() {
    return _cityId;
  }

  void setCityId(String cityId) {
    _cityId = cityId;
  }

  // void setPropertyType(String propertyType) {
  //   _propertyType = propertyType;
  // }

  // String getPropertyType() {
  //   return _propertyType;
  // }

  void setCaseNo(String caseNo) {
    _caseNo = caseNo;
  }

  String getCaseNo() {
    return _caseNo;
  }

  void setAgentId(String agentId) {
    _agentId = agentId;
  }

  String getAgentId() {
    return _agentId;
  }

  // void setNameAr(String nameAr) {
  //   _nameAr = nameAr;
  // }

  // String getNameAr() {
  //   return _nameAr;
  // }

  // void setFullNameAr(String fullNameAr) {
  //   _fullNameAr = fullNameAr;
  // }

  // String getFullNameAr() {
  //   return _fullNameAr;
  // }

  void setLpoRefNo(String lpoRefNo) {
    _lpoRefNo = lpoRefNo;
  }

  String getLpoRefNo() {
    return _lpoRefNo;
  }

  void setUrl(String url) {
    _url = url;
  }

  String getUrl() {
    return _url;
  }

  void setTenantId(String tenantId) {
    _tenantId = tenantId;
  }

  String getTenantId() {
    return _tenantId;
  }

  void setNotificationData(Map<String, dynamic> data) {
    _notificationData = data;
  }

  Map<String, dynamic> getNotificationData() {
    return _notificationData;
  }

  void resetSession() {
    _selectedRoleId = 0;
    _token = '';
    _publicToken = '';
  }
}
