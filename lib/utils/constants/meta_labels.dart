import '../../data/helpers/session_controller.dart';

class AppMetaLabels {
  ///////////////////////////////
  /// Get Otp Screen Labels
  ///////////////////////////////

  String login =
      SessionController().getLanguage() == 1 ? "Login" : 'تسجيل الدخول';
  String color = SessionController().getLanguage() == 1 ? "Color" : 'لون';
  String rentPaidAmount = SessionController().getLanguage() == 1
      ? 'Rent Paid Amount'
      : 'مبلغ الإيجار المدفوع';
  String lossofRent =
      SessionController().getLanguage() == 1 ? 'Loss Of Rent' : 'خسارة الإيجار';
  String lossofRentDays = SessionController().getLanguage() == 1
      ? 'Loss of Rent Days'
      : 'خسارة أيام الإيجار';
  String prevRent = SessionController().getLanguage() == 1
      ? 'Previous Rent'
      : 'الإيجار السابق';
  String period = SessionController().getLanguage() == 1 ? 'Period' : 'فترة';
  String recoveryAmount = SessionController().getLanguage() == 1
      ? 'Recovery Amount'
      : 'مبلغ الاسترداد';
  String lpotitle = SessionController().getLanguage() == 1
      ? 'LPO Title'
      : 'عنوان أمر الشراء المحلي';
  String vATPaidAmount = SessionController().getLanguage() == 1
      ? 'VAT Paid Amount'
      : 'لمبلغ المدفوع لضريبة القيمة المضافة';
  String cardCharges =
      SessionController().getLanguage() == 1 ? 'Card Charges' : 'رسوم البطاقة';
  String modeofPayment = SessionController().getLanguage() == 1
      ? 'Mode of Payment'
      : 'طريقة الدفع';
  String owner = SessionController().getLanguage() == 1 ? 'Owner' : 'مالك';
  String otpVerification = SessionController().getLanguage() == 1
      ? "OTP Verification"
      : 'التحقق من الرقم السري';

  String verificationComplete = SessionController().getLanguage() == 1
      ? "Verification Complete"
      : 'اكتمل التحقق';

  String sureToExit = SessionController().getLanguage() == 1
      ? "Are you sure to exit the app?"
      : "هل أنت متأكد من الخروج من التطبيق؟";

  String oneTimePassword = SessionController().getLanguage() == 1
      ? "We will send you a One Time Password on this\nMobile Number."
      : "سنرسل لك كلمة مرور لمرة واحدة على هذا  الرقم للهاتف المحمول.";

  String mobileNumber = SessionController().getLanguage() == 1
      ? "Mobile Number"
      : "رقم الهاتف المحمول";

  String getOTP = SessionController().getLanguage() == 1
      ? "Get OTP"
      : "احصل على الرقم السري ";

  String enableRooted = SessionController().getLanguage() == 1
      ? "Enable Rooted Device"
      : 'تفعيل المجلد الرئيسى للجهاز';

  String enableSSL = SessionController().getLanguage() == 1
      ? "Enable SSL Pinning"
      : 'تفعيل الخاصية الأمنية';

  String verifyingOtp = SessionController().getLanguage() == 1
      ? "Verifying OTP code"
      : 'التحقق من الرقم السري ';

  String cancel = SessionController().getLanguage() == 1 ? "Cancel" : "إلغاء";

  String exit = SessionController().getLanguage() == 1 ? "Exit" : "تسجيل خروج";

  String scane = SessionController().getLanguage() == 1 ? "Scan" : "امسح";

  String scanningCard = SessionController().getLanguage() == 1
      ? "Scanning Card"
      : "بطاقة المسح الضوئي";

  String errorResending = SessionController().getLanguage() == 1
      ? 'Error resending OTP'
      : 'خطا  ارجو اعادة ارسال الرقم السرى';

  String error = SessionController().getLanguage() == 1 ? 'Error' : 'خطأ';

  String processingError = SessionController().getLanguage() == 1
      ? 'Processing Error'
      : 'خطأ في المعالجة';

  String pleaseEnterCompleteCardNo = SessionController().getLanguage() == 1
      ? 'Please enter 6 digit Cheque Number'
      : 'الرجاء إدخال رقم الشيك المكون من 6 أرقام';
  String pleaseAttachCheque = SessionController().getLanguage() == 1
      ? 'Please attach cheque copy first'
      : "يرجى إرفاق نسخة الشيك أولا";
  String pleaseEnterCompleteCardNoRejection =
      SessionController().getLanguage() == 1
          ? 'Please select cheque copy and enter 6 digit Cheque Number'
          : 'يرجى تحديد نسخة الشيك وإدخال رقم التحقق المكون من 6 أرقام';

  String fileExtensionError = SessionController().getLanguage() == 1
      ? 'You can only upload  "pdf , jpg , png" files of maximum size 10 MB'
      : 'يمكنك فقط تحميل ملفات "pdf، jpg، png" بحد أقصى 10 ميجا بايت';

  String fileSizenError = SessionController().getLanguage() == 1
      ? 'You can only upload files of maximum size 10 MB'
      : 'يمكنك فقط تحميل ملفات بحد أقصى 10 ميجا بايت';

  ///////////////////////////////
  ///  Otp verification Screen Labels
  ///////////////////////////////

  String enterTheCode = SessionController().getLanguage() == 1
      ? "Enter the code that was sent to"
      : "أدخل الرمز الذي تم إرساله إلى";

  String didnotrecieve = SessionController().getLanguage() == 1
      ? "Didn’t recieve the OTP code?"
      : "لم تتلق الرقم السري المتغير";

  String resentOtp = SessionController().getLanguage() == 1
      ? "Resend OTP"
      : "إعادة إرسال الرقم السري";
  String otpExpired = SessionController().getLanguage() == 1
      ? "OTP Code Expired"
      : "رمز التحقق من الهوية منتهي الصلاحية";

  String verify = SessionController().getLanguage() == 1
      ? "Verify and Proceed"
      : "تحقق وتابع";

  ///////////////////////////////
  /// Choose Language Screen Labels
  ///////////////////////////////
  String choose = SessionController().getLanguage() == 1 ? "CHOOSE" : "اختر";

  String language =
      SessionController().getLanguage() == 1 ? "Language" : "اللغة";

  String consentSetting = SessionController().getLanguage() == 1
      ? "Consent Settings"
      : "إعدادات الموافقة";

  String collierPropertiesPrivacyPolicy = SessionController().getLanguage() == 1
      ? "Colliers Properties - Privacy Policy"
      : "شركة مينا العقارية - سياسة الخصوصية";

  String collierPropertiesSource = SessionController().getLanguage() == 1
      ? '"Colliers Properties" Would Like to Access the '
      : "شركة الشرق الأوسط وشمال أفريقيا العقارية ترغب في الوصول إلى ";

  String collierPropertiesPrivacyPolicyLink =
      "https://www.menaProperties.ae/en/privacypolicy";

  String cont = SessionController().getLanguage() == 1 ? 'Continue' : 'متابعة';

  ///////////////////////////////
  /// Get OTP Country Code Screen Labels
  ///////////////////////////////
  String change = SessionController().getLanguage() == 1 ? "CHANGE" : "تغيير";

  String countryCode =
      SessionController().getLanguage() == 1 ? "Country Code" : "رمز البلد";

  String search = SessionController().getLanguage() == 1 ? "Search" : "بحث";

  String searchCity = SessionController().getLanguage() == 1
      ? "Search City"
      : 'البحث  بالمدينة';

  // String searchEmirate = SessionController().getLanguage() == 1
  //     ? "Search Emirate"
  //     : 'البحث في الإمارة';
  String uae = "UAE (+971)";

  String ksa = "KSA (+966)";

  ///////////////////////////////
  /// Setup Mpin Screen Labels
  ///////////////////////////////
  String setup = SessionController().getLanguage() == 1 ? "SET UP" : "إعداد";

  String mpin =
      SessionController().getLanguage() == 1 ? "MPIN" : "رقم التعريف الشخصي ";

  String name = SessionController().getLanguage() == 1 ? "Name" : "اسم";

  String nameStarick =
      SessionController().getLanguage() == 1 ? 'Name *' : '* اسم';
  String requireData =
      SessionController().getLanguage() == 1 ? '* Required' : ' *مطلوب ';
  String invalidEmail = SessionController().getLanguage() == 1
      ? 'Invalid Email'
      : 'بريد إلكتروني خاطئ';
  String emailWithStarick = SessionController().getLanguage() == 1
      ? 'Email *'
      : '* البريد الالكتروني';

  String noofResidentialFlat = SessionController().getLanguage() == 1
      ? 'No of Residential Flat'
      : "عدد الشقق السكنية";

  String noofCommercialFlat = SessionController().getLanguage() == 1
      ? 'No of Commercial Flat'
      : "عدد الشقق التجارية";

  String setupMPIN = SessionController().getLanguage() == 1
      ? "Setup your MPIN"
      : "قم بإعداد رقم التعريف الشخصي الخاص بك";

  String enterMpin = SessionController().getLanguage() == 1
      ? "Enter a six digit MPIN"
      : "أدخل رقم التعريف الشخصي المكون من ستة أرقام";

  String invoiceColudNotGenerated = SessionController().getLanguage() == 1
      ? "Invoice could not be generated due to "
      : "تعذر إنشاء الفاتورة بسبب";

  String reenterMpin = SessionController().getLanguage() == 1
      ? "Re-enter a six digit MPIN"
      : "إعادة ادخال الرقم التعريفى";
  String enableFaceID = SessionController().getLanguage() == 1
      ? "Enable Touch ID / Face ID"
      : 'تفعيل بصمة الوجه';
  String personalDataShare = SessionController().getLanguage() == 1
      ? "Personal data sharing"
      : "مشاركة البيانات الشخصية";

  String personalDataDisclaimerShare = SessionController().getLanguage() == 1
      ? "Disclaimer: Please do not enter any personal or sensitive data in any free text box which is not relevant to the purpose."
      : " اخلاء المسئولية :يرجى عدم مشاركة الرقم التعريفى الخاص بك";
  // : "إخلاء المسؤولية: يرجي عدم  مشاركة يرجى عدم مشاركة الكود الخاص بك مع اى شخص أخر    لها علاقة بالغرض";
  // : "إخلاء المسؤولية: يُرجى عدم إدخال أي بيانات شخصية أو حساسة في أي مربع نص حر لا علاقة له بالغرض.";

  String saveMPIN = SessionController().getLanguage() == 1
      ? "Save MPIN"
      : "حفظ رقم التعريف الشخصي ";

  ///////////////////////////////
  /// Select Role Screen Labels
  ///////////////////////////////

  String selectRole = SessionController().getLanguage() == 1
      ? "Select your role"
      : "حدد دورك الرئيسي";

  String sureToReset = SessionController().getLanguage() == 1
      ? "Are you sure to reset the app?"
      : "هل انت متاكد من اعادة ضبط الاعدادات";

  ///////////////////////////////
  /// Login Mpin Screen Labels
  ///////////////////////////////

  String mpinorfinger = SessionController().getLanguage() == 1
      ? "Verify fingerprint or Enter your mPIN"
      : "تحقق من بصمة الإصبع أو أدخل الرقم السري الخاص بك";

  String mpinorbiomatric = SessionController().getLanguage() == 1
      ? "Verify biometric or Enter your mPIN"
      : 'ادخل رقم التعريف الخاص بك';

  // : 'تحقق من البيومترية أو أدخل الرقم السري الخاص بك';

  String welcomeback =
      SessionController().getLanguage() == 1 ? "Welcome back" : "مرحبًا بعودتك";

  String forgotMPIN = SessionController().getLanguage() == 1
      ? "Forgot MPIN?"
      : " هل نسيت رقم التعريف الشخصي ";

  String needHelp =
      SessionController().getLanguage() == 1 ? "Need Help" : "تحتاج مساعدة";

  String help =
      SessionController().getLanguage() == 1 ? "Help" : "طلب المساعدة";

  String callUs =
      SessionController().getLanguage() == 1 ? "Call Us" : "اتصل بنا";

  String emailUs = SessionController().getLanguage() == 1
      ? "Email Us"
      : "راسلنا عبر البريد الإلكتروني";

  String contactCenter =
      SessionController().getLanguage() == 1 ? "Contact Centre" : "مركز اتصال ";

  // String contactCenter = SessionController().getLanguage() == 1
  //     ? "24-hour Contact Centre"
  //     : "مركز اتصال على مدار 24 ساعة";

  String within = SessionController().getLanguage() == 1
      ? "02 6354444 (within UAE)"
      : "02 6354444 (من داخل الإمارات العربية المتحدة)";

  String outside = SessionController().getLanguage() == 1
      ? "+971 2 6354444 (outside UAE)"
      : "+971 2 6354444 (من خارج الإمارات العربية المتحدة)	";

  // String within = SessionController().getLanguage() == 1
  //     ? "600 52 5500 (within UAE)"
  //     : "600 52 5500 (من داخل الإمارات العربية المتحدة)";

  // String outside = SessionController().getLanguage() == 1
  //     ? "+971 2 681 1511 (outside UAE)"
  //     : "+971 2 681 1511 (من خارج الإمارات العربية المتحدة)	";

  String collierEmail = 'FABProp.care@bankfab.com';

  ///////////////////////////////////
  /// public login screen
  /// ///////////////////////

  String welcomeToFab = SessionController().getLanguage() == 1
      ? 'Welcome to the future of properties'
      : 'أهلا بكم في مستقبل العقارات';

  ///////////////////////////////
  /// Tenant Dashboard Screen Labels
  ///////////////////////////////

  String noPropertiesFound = SessionController().getLanguage() == 1
      ? "No Properties Found"
      : 'لم يتم العثور على اي عقار';

  String properties =
      SessionController().getLanguage() == 1 ? "Properties" : "العقارات";

  String propertiesDetail = SessionController().getLanguage() == 1
      ? "Properties Details"
      : "تفاصيل العقارات";

  String collierProps = SessionController().getLanguage() == 1
      ? "Colliers Properties"
      : "مينا العقارية";

  String propertyDetails = SessionController().getLanguage() == 1
      ? "Property Details "
      : 'تفاصيل العقار';

  String paymentBalance = SessionController().getLanguage() == 1
      ? "Outstanding incl. Charges"
      : "المبالغ غير مدفوعة شاملة الرسوم ";

  String totalPayable = SessionController().getLanguage() == 1
      ? "Total Payable"
      : "إجمالي المبالغ المستحقة الدفع";

  String next30days =
      SessionController().getLanguage() == 1 ? "NEXT 30 DAYS" : "بعد 30 يومًا";

  String contractsExpiring = SessionController().getLanguage() == 1
      ? "Contracts expiring"
      : " عقود ستنتهى";
  // : "تنتهي العقود";

  String chequesDue = SessionController().getLanguage() == 1
      ? "Cheques due"
      : 'الشيكات المستحقة';

  String manageContracts = SessionController().getLanguage() == 1
      ? 'MANAGE CONTRACTS'
      : "إدارة العقود";

  String managePayments = SessionController().getLanguage() == 1
      ? 'MANAGE PAYMENTS'
      : 'إدارة المدفوعات';
  String manageServiceRequestCap = SessionController().getLanguage() == 1
      ? 'MANAGE SERVICE REQUEST'
      : 'إدارة طلب الخدمة';

  String onlinePaymentsCap = SessionController().getLanguage() == 1
      ? 'ONLINE PAYMENTS'
      : 'المدفوعات عبر الإنترنت';

  String dueActionsForContract = SessionController().getLanguage() == 1
      ? 'Click here for Contract Renewal Process                  '
      // : 'اضغط هنا لتجديد العقد او الاخلاء                 ';
      : ' اضغط هنا للتجديد العقد               ';
  // : 'انقر هنا لعملية تجديد العقد               ';

  // String dueActionsForContract = SessionController().getLanguage() == 1
  //     ? 'Click here for Contract Renewal/Vacating/End Process                  '
  //     : 'نقر هنا لتجديد العقد / إجازة / إنهاء العملية                ';

  String renewalTutorialForContract = SessionController().getLanguage() == 1
      ? 'Contract renewal tutorial'
      : 'برنامج تعليمي لتجديد العقد';

  String newTutorialForContract = SessionController().getLanguage() == 1
      ? 'Contract new tutorial'
      : 'عقد برنامج تعليمي جديد';

  String clickabovebtnForContractRenewalTutorial = SessionController()
              .getLanguage() ==
          1
      ? 'Click above link for tutorial video of Contract renewal process or'
      : 'انقر فوق الرابط أعلاه للحصول على فيديو تعليمي لعملية تجديد العقد أو';

  String clickabovebtnForContractNewTutorial = SessionController()
              .getLanguage() ==
          1
      ? 'Click above link for tutorial video of Contract new process or'
      : 'انقر فوق الرابط أعلاه للحصول على فيديو تعليمي لعملية جديدة للعقد أو';

  // : 'انقر هنا لمعالجة العقد                  ';

  String clickHereFeedback = SessionController().getLanguage() == 1
      ? 'Click here for your Feedback & Survey                 '
      : 'انقر هنا للحصول على ملاحظاتك واستطلاعك     ';

  String clickaboveButton = SessionController().getLanguage() == 1
      ? 'Click above button for contract'
      : 'اضغط فوق الزر أعلاه للعقد';
  // : 'انقر فوق الزر أعلاه للتعاقد';

  String renwal =
      SessionController().getLanguage() == 1 ? ' Renewal ' : ' تجديد ';

  // String renwalOrVacating = SessionController().getLanguage() == 1
  //     ? ' Renewal/Vacating '
  //     : ' تجديد / إجازة ';

  String processOr =
      SessionController().getLanguage() == 1 ? 'process or ' : 'عملية أو ';

  String onlinePayments = SessionController().getLanguage() == 1
      ? 'Online Payments'
      : 'المدفوعات عبر الإنترنت  ';

  String paid = SessionController().getLanguage() == 1 ? 'Paid' : 'مدفوع';

  String outstanding =
      SessionController().getLanguage() == 1 ? 'Outstanding' : 'غير مدفوعة';
  String outstandingWithRassom = SessionController().getLanguage() == 1
      ? 'Outstanding'
      : 'الرسوم غير مدفوعة';

  String rentOutstanding = SessionController().getLanguage() == 1
      ? 'Rent Outstanding'
      : 'المبالغ المستحقة';

  String rentalVal = SessionController().getLanguage() == 1
      ? 'Rental Values'
      : ' القيمة الايجارية';

  String occupiedUnits = SessionController().getLanguage() == 1
      ? 'Occupied Units'
      : 'الوحدات المشغولة';

  String vacantUnits = SessionController().getLanguage() == 1
      ? 'Vacant Units'
      : 'الوحدات الشاغرة';

  String noOfOccupancy = SessionController().getLanguage() == 1
      ? 'No of Occupancy'
      : 'عدد الإشغال';

  String occupancy =
      SessionController().getLanguage() == 1 ? 'Occupancy' : 'الإشغال';
  String noOfVacancy =
      SessionController().getLanguage() == 1 ? 'No of Vacancy' : 'عدد الشواغر';
  String vacancy = SessionController().getLanguage() == 1 ? 'Vacancy' : 'خالي';

  String activeContracts = SessionController().getLanguage() == 1
      ? 'Active Contracts'
      : 'العقود فعالة';

  String dueIn30Days = SessionController().getLanguage() == 1
      ? 'Due in 30 Days'
      : 'مُستحق خلال 30 يومًا';

  String toBePaidCapital = SessionController().getLanguage() == 1
      ? 'DUE IN 30 DAYS'
      : 'مُستحق خلال 30 يومًا';

  String expiringIn30days = SessionController().getLanguage() == 1
      ? 'CONTRACTS EXPIRING IN 30 DAYS'
      : 'تنتهي العقود خلال 30 يومًا';

  String chequesDueIn30Days = SessionController().getLanguage() == 1
      ? 'CHEQUES DUE IN 30 DAYS'
      : 'الشيكات مستحقة الدفع خلال 30 يومًا';

  String aed = SessionController().getLanguage() == 1 ? 'AED' : 'AED';
  String vatCharges = SessionController().getLanguage() == 1
      ? 'VAT Charges'
      : 'رسوم ضريبة القيمة المضافة';

  // String aed = SessionController().getLanguage() == 1 ? 'AED' : 'درهم';

  String unit = SessionController().getLanguage() == 1 ? 'Unit' : 'الوحدة';
  String totalUnits = SessionController().getLanguage() == 1
      ? 'Total Unit'
      : 'الوحدة الإجمالية';

  String dashboard =
      SessionController().getLanguage() == 1 ? 'Dashboard' : 'لوحة التحكم';

  String contracts =
      SessionController().getLanguage() == 1 ? 'Contracts' : 'العقود';

  String contract =
      SessionController().getLanguage() == 1 ? 'Contract' : 'العقد';

  String services =
      SessionController().getLanguage() == 1 ? 'Services' : 'خدمات';

  String serviceRequests = SessionController().getLanguage() == 1
      ? 'Service Requests'
      : 'طلبات الخدمة';

  String myRequests =
      SessionController().getLanguage() == 1 ? 'My Requests ' : 'طلباتي';

  String payments =
      SessionController().getLanguage() == 1 ? 'Payments' : 'المدفوعات';

  String contractDocumnets = SessionController().getLanguage() == 1
      ? 'Contract Documents'
      : 'عقد الايجار';

  String paymentMethod =
      SessionController().getLanguage() == 1 ? 'Payment Method' : 'طريقة الدفع';

  String gotoOnlinePayment = SessionController().getLanguage() == 1
      ? 'Go to Online Payment'
      : 'انتقل إلى الدفع الإلكتروني';

  String confirmPayment = SessionController().getLanguage() == 1
      ? 'Continue With Payment'
      : 'القيام بالدفع';

  String enterValidAddress = SessionController().getLanguage() == 1
      ? 'Please Enter Valid Address'
      : 'الرجاء إدخال عنوان صالح';
  String makePaymentThrough = SessionController().getLanguage() == 1
      ? 'I want to make this payment through'
      : 'أريد أن أقوم بالدفع من خلال';

  String pleaseUploadCheque = SessionController().getLanguage() == 1
      ? 'Please Upload Cheque'
      : 'يرجى تحميل الشيك';

  String onlineOrCard = SessionController().getLanguage() == 1
      ? 'Online/Card Payment'
      : 'الدفع عبر الإنترنت / البطاقة';

  String cheque = SessionController().getLanguage() == 1 ? 'Cheque' : 'الشيك';

  String bank = SessionController().getLanguage() == 1 ? 'Bank' : 'البنك';

  String bankTransfer = SessionController().getLanguage() == 1
      ? 'Bank Transfer'
      : 'التحويل المصرفي';

  String cardPayment =
      SessionController().getLanguage() == 1 ? 'Card Payment' : 'بطاقه ائتمان';

  String chequeCopy =
      SessionController().getLanguage() == 1 ? 'Cheque Copy' : 'نسخة الشيك';

  String uploadCheque = SessionController().getLanguage() == 1
      ? 'Select Cheque Copy / Take Photo'
      : 'التقاط صورة ';

  String yourCheque =
      SessionController().getLanguage() == 1 ? 'Your cheque' : 'الشيك الخاص بك';

  String your = SessionController().getLanguage() == 1 ? 'Your' : 'لك';
  String please = SessionController().getLanguage() == 1 ? 'Please' : 'لو سمحت';

  String fileRejected = SessionController().getLanguage() == 1
      ? 'has been rejected, please upload again'
      : 'تم الرفض , الرجاء اعادة التحميل';

  String pickup = SessionController().getLanguage() == 1 ? 'Pickup' : 'التقاط';

  String freePickupBC = SessionController().getLanguage() == 1
      ? 'Free Pickup by Courier'
      : 'النقل المجاني عن طريق البريد';

  String howToDeliverCheque = SessionController().getLanguage() == 1
      ? 'How would you like to deliver cheque?'
      : 'كيف تريد ان تسلم الشيك ';

  String selfDelivery =
      SessionController().getLanguage() == 1 ? 'Self Delivery' : 'توصيل ذاتي';

  String chequeCollectionAddress = SessionController().getLanguage() == 1
      ? 'Cheque Pickup Address'
      : 'عنوان استلام الشيك';

  String enterLocation = SessionController().getLanguage() == 1
      ? 'Please Enter Location'
      : 'الرجاء إدخال الموقع';

  String methodUpdated = SessionController().getLanguage() == 1
      ? 'Payment Method Updated'
      : 'تم تحديث طريقة الدفع';

  String alert = SessionController().getLanguage() == 1 ? 'Alert' : 'اخطار';
  String codeSent = SessionController().getLanguage() == 1
      ? 'Code Sent Successfully'
      : 'تم إرسال الرمز بنجاح';
  String codeAutoRetrievalTimeout = SessionController().getLanguage() == 1
      ? 'Auto-retrieval of verification code timed out'
      : 'انتهت مهلة استرجاع الرمز التحقق تلقائيًا';

  String pleaseSelectAllPayments = SessionController().getLanguage() == 1
      ? 'Please select appropriate payment method'
      : 'الرجاء تحديد طريقة الدفع المناسبة';

  String yourRequestCancelled = SessionController().getLanguage() == 1
      ? 'The request has been canceled/closed, and you cannot continue with it.'
      : 'تم إلغاء الطلب ولا يمكنك الاستمرار فيه.';

  String pleaseScan =
      SessionController().getLanguage() == 1 ? 'Please scan ' : 'يرجى المسح';

  String pleasetakeOtherSide = SessionController().getLanguage() == 1
      ? 'Please take a photo of the other side '
      : 'يرجى تصوير الجانب الاخر من الهوية الإماراتية سارية المفعول ';
  // يرجى تصوير الجانب الخلفى من'

  String frontSide =
      SessionController().getLanguage() == 1 ? 'Front Side' : 'الجانب الامامي';

  String backSide =
      SessionController().getLanguage() == 1 ? 'Back Side' : 'الجانب الخلفي';

  String otherSide =
      SessionController().getLanguage() == 1 ? 'Other Side' : 'الجانب الآخر';

  String bothSideScane =
      SessionController().getLanguage() == 1 ? 'Both sides' : 'كلا الجانبين';

  String bothSideScaneFullMessage = SessionController().getLanguage() == 1
      ? 'Please scan both sides of the Emirates ID'
      : ' يرجى مسح كلا الجانبين من الهوية الاماراتية';

  String validEID = SessionController().getLanguage() == 1
      ? ' of your valid Emirate ID.'
      : 'من الهوية اإماراتية السارية المفعول الخاصة بك';

  String pleaseWait = SessionController().getLanguage() == 1
      ? 'Please wait while your '
      : 'من فضلك انتظر ريثما';

  String data = SessionController().getLanguage() == 1 ? 'Data ' : 'بيانات';

  String dataISPreparing = SessionController().getLanguage() == 1
      ? 'is being processed.'
      : 'يتم معالجة..';

  String dataISPreparingAR = 'يرجى الانتظار حتى يتم معالجة نبياناتك';

  String uploadAttachedDocFirst = SessionController().getLanguage() == 1
      ? 'Please upload the attached document at first.'
      : 'يرجى تحميل الصفحة الامامية من الهوية الاماراتية';

  String pleaseWaitWhileLoading = SessionController().getLanguage() == 1
      ? 'Please wait while loading ... '
      : 'يرجى الانتظار أثناء التحميل...';

  String paymentConfirmed = SessionController().getLanguage() == 1
      ? 'Payment method already selected. You cannot change now.'
      : 'تم تحديد طريقة الدفع . لا يمكنك التغيير الآن.';

  String renatalpayments = SessionController().getLanguage() == 1
      ? 'Rental Payments'
      : 'دفعات الايجار';

  String additionalCharges = SessionController().getLanguage() == 1
      ? 'Additional Charges'
      : 'رسوم إضافية';

  String vatOnRent = SessionController().getLanguage() == 1
      ? 'VAT on Rent'
      : 'ضريبة القيمة المضافة على الإيجار';

  String vatOnCharges = SessionController().getLanguage() == 1
      ? 'VAT on Charges'
      : 'ضريبة القيمة المضافة على الرسوم';

  String dueDate =
      SessionController().getLanguage() == 1 ? 'Due Date' : 'تاريخ الاستحقاق';

  String drawYourSig = SessionController().getLanguage() == 1
      ? 'Please sign below in a manner similar to your Emirates ID'
      : 'الرجاء التوقيع ادناه بطريقة مشابهة للتوقيع الموجود فى الهوية الاماراتية ';
  // : 'الرجاء تسجيل الدخول أدناه بطريقة مشابهة لهوية الإمارات الخاصة بك';

  // String drawYourSig = SessionController().getLanguage() == 1
  //     ? 'Please Draw your signature'
  //     : 'من فضلك ارسم توقيعك';

  String totalpayments =
      SessionController().getLanguage() == 1 ? 'Total Payment' : 'إجمالي الدفع';

  String more = SessionController().getLanguage() == 1 ? 'More' : 'المزيد';

  String yourContracts = SessionController().getLanguage() == 1
      ? 'Your contracts'
      : 'عقودك الايجارية';

  String manage = SessionController().getLanguage() == 1 ? 'MANAGE' : 'إدارة';

  String viewAllContracts = SessionController().getLanguage() == 1
      ? 'VIEW ALL CONTRACTS'
      : 'عرض جميع العقود';

  String viewAllPayments = SessionController().getLanguage() == 1
      ? 'VIEW ALL PAYMENTS'
      : 'عرض جميع المدفوعات';

  String serviceRequest =
      SessionController().getLanguage() == 1 ? 'Service Request' : 'طلب خدمة';

  String newRequest =
      SessionController().getLanguage() == 1 ? 'NEW REQUEST' : 'طلب جديد';

  String newRequestSmall =
      SessionController().getLanguage() == 1 ? 'New Request' : 'طلب جديد';

  String accessCardCharges = SessionController().getLanguage() == 1
      ? 'Access Card Charges'
      : 'رسوم بطاقة الدخول';

  String chequeDate =
      SessionController().getLanguage() == 1 ? 'Cheque Date' : 'تاريخ الشيك';

  String markAsRead = SessionController().getLanguage() == 1
      ? 'Mark as Read'
      : 'وضع علامة مقروء';

  String archive = SessionController().getLanguage() == 1 ? 'Archive' : 'أرشيف';

  String all = SessionController().getLanguage() == 1 ? 'All' : 'الكل';

  String allTypes = SessionController().getLanguage() == 1
      ? "All types"
      : 'كل / جميع الأنواع';

  String unread =
      SessionController().getLanguage() == 1 ? 'Unread' : 'غير مقروء';

  String done = SessionController().getLanguage() == 1 ? 'Done' : 'تم';

  String edit = SessionController().getLanguage() == 1 ? 'Edit' : 'تعديل';

  String signContract1 =
      SessionController().getLanguage() == 1 ? 'SIGN CONTRACT' : 'وقع العقد';

  String signContract2 =
      SessionController().getLanguage() == 1 ? 'Sign Contract' : 'وقع العقد';

  String stageUpdated = SessionController().getLanguage() == 1
      ? 'Stage Updated Successfully'
      : 'المرحلة تم تحديثها بنجاح';

  String municipalityConfirmation = SessionController().getLanguage() == 1
      ? 'Thank you for completing the Municipality Approval'
      : 'شكرا لاستكمال موافقة البلدية';

  String pleaseConfirm =
      SessionController().getLanguage() == 1 ? 'Please Confirm' : 'يرجى تأكيد';

  String proceedTopay = SessionController().getLanguage() == 1
      ? 'PROCEED TO PAY'
      : 'مواصلة الدفع';

  String proceedTopayL = SessionController().getLanguage() == 1
      ? 'Proceed to Pay'
      : 'مواصلة الدفع';

  String chequeDetailsC = SessionController().getLanguage() == 1
      ? "CHEQUE DETAILS"
      : 'تفاصيل الشيك';

  ///////////////////////////////
  /// Tenant profile Screen Labels
  ///////////////////////////////

  String notifications =
      SessionController().getLanguage() == 1 ? 'Notifications' : 'إشعارات';

  String faq = SessionController().getLanguage() == 1
      ? 'FAQs'
      : 'الأسئلة والأجوبة الشائعة';

  String settings =
      SessionController().getLanguage() == 1 ? 'Settings' : 'الاعدادات';

  String fingerPrint =
      SessionController().getLanguage() == 1 ? 'Finger Print' : 'بصمة الاصبع';

  String logout =
      SessionController().getLanguage() == 1 ? 'Log out' : 'تسجيل الخروج';

  String about = SessionController().getLanguage() == 1 ? 'About' : 'نبذة عن';

  String update = SessionController().getLanguage() == 1 ? 'Update' : 'تحديث';

  String googlePlay =
      SessionController().getLanguage() == 1 ? 'Google Play' : 'تطبيقات جوجل';

  String appStore =
      SessionController().getLanguage() == 1 ? 'App Store' : 'متجر آبل';

  String updateApp =
      SessionController().getLanguage() == 1 ? 'Update App' : 'تحديث التطبيق';

  String availableVersion = SessionController().getLanguage() == 1
      ? 'Available Version : '
      : 'الإصدار المتاح:';

  String appVersion = SessionController().getLanguage() == 1
      ? 'App Version : '
      : 'نسخة التطبيق:';

  String aNewVersion = SessionController().getLanguage() == 1
      ? 'A new version of app '
      : 'نسخة جديدة من التطبيق ';

  String collierProperties = SessionController().getLanguage() == 1
      ? "Colliers Properties"
      : "مينا العقارية";

  String isAvailableAndFeatures =
      SessionController().getLanguage() == 1 ? 'is available.\n' : 'متاح. \n';

  String updateThelatestVersion = SessionController().getLanguage() == 1
      ? ' highly recommends that you update the app to the latest version, in order to take advantage of any security patches and performance enhancements that have been implemented.'
      : 'نوصي بشدة بتحديث التطبيق إلى أحدث إصدار ، من أجل الاستفادة من أي تصحيحات أمنية وتحسينات في الأداء تم تنفيذها.';

  String paymentConfirmation = SessionController().getLanguage() == 1
      ? 'Please ensure that you have selected the correct payment method as it cannot be changed after confirmation.\nDo you want to proceed?'
      : 'الرجاء التأكد من طريقة الدفع حيث لا يمكن تغييرها بعد ذلك';

  // : 'الرجاء التأكد من تحديد طريقة الدفع الصحيحة حيث لا يمكن تغييرها بعد التأكيد. \ n هل تريد المتابعة؟';
  // String paymentConfirmation = SessionController().getLanguage() == 1
  //     ? 'Please make sure that you have chosen the right payment methods as it can\'t be altered afterwards. \nDo you wish to continue ?'
  //     : 'يرجى التأكد من اختيارك لطرق الدفع الصحيحة حيث لا يمكن تغييرها بعد ذلك. \n هل ترغب في المتابعة؟';

  String loginToTawtheeq = SessionController().getLanguage() == 1
      ? 'Login To Tawtheeq'
      : 'تسجيل الدخول إلى توثيق';

  String invalidPhoneNumber = SessionController().getLanguage() == 1
      ? 'Invalid Mobile Number'
      : 'رقم الجوال غير صالح';

  String resetApp = SessionController().getLanguage() == 1
      ? 'Reset App'
      : 'إعادة تعيين التطبيق';

  String thisIsTemporaryFeature = SessionController().getLanguage() == 1
      ? 'This is the temporary feature'
      : 'هذه هي الميزة المؤقتة';

  String pleaseScanFrontSide = SessionController().getLanguage() == 1
      ? 'Please scan Front Side of your valid Emirate ID'
      : 'يرجى مسح الواجهة الأمامية لبطاقة الهوية الإمارتية الخاصة بك';

  String pleaseScanBackSide = SessionController().getLanguage() == 1
      ? 'Please scan Back Side of your valid Emirate ID'
      : 'يرجى مسح  الواجهة الخلفية لبطاقة الهوية الإمارتية الخاصة بك';

  String cardScanningFailed = SessionController().getLanguage() == 1
      ? 'Card Scanning Failed'
      : 'فشل مسح البطاقة';

  String scanningFailed = SessionController().getLanguage() == 1
      ? 'Scanning could not be successfull, please try again'
      : ' المسح غير ناجحً ، يرجى إعادة  المحاولة';

  String pleaseTryValidCardScanning = SessionController().getLanguage() == 1
      ? 'Please try with a clear and valid Emirate ID image'
      : 'يرجى المحاولة مع صورة هوية إمارتية  واضحة و فعالة';

  ///////////////////////////////
  /// Tenant Contracts Screen Labels
  ///////////////////////////////

  String info = SessionController().getLanguage() == 1 ? 'INFO' : 'معلومات';

  String financial =
      SessionController().getLanguage() == 1 ? 'FINANCIAL' : 'المالية';

  String general = SessionController().getLanguage() == 1 ? 'GENERAL' : 'عام';

  String vendorProperties =
      SessionController().getLanguage() == 1 ? 'PROPERTIES' : 'العقارات';

  String maininfo = SessionController().getLanguage() == 1
      ? 'MAIN INFO'
      : 'المعلومات الرئيسية';

  String unitinfo =
      SessionController().getLanguage() == 1 ? 'UNIT INFO' : 'معلومات الوحدة';

  String charges =
      SessionController().getLanguage() == 1 ? 'CHARGES' : 'الرسوم';

  String contractsPayments =
      SessionController().getLanguage() == 1 ? 'PAYMENTS' : 'المدفوعات';

  String verifiedPayments = SessionController().getLanguage() == 1
      ? 'VERIFIED PAYMENTS'
      : 'مدفوعات تم التحقق منها';

  String unverifiedPayments = SessionController().getLanguage() == 1
      ? 'UNVERIFIED PAYMENTS'
      : 'مدفوعات لم يتم التحقق منها';

  String contractNo =
      SessionController().getLanguage() == 1 ? 'Contract No.' : 'رقم العقد';

  String contractNum =
      SessionController().getLanguage() == 1 ? 'Contract ' : 'رقم العقد';

  String searchContracts = SessionController().getLanguage() == 1
      ? 'Search Contracts'
      : 'البحث عن عقود';

  String searchPayments = SessionController().getLanguage() == 1
      ? 'Search Payments'
      : 'البحث عن المدفوعات';

  String searchServices = SessionController().getLanguage() == 1
      ? 'Search Services'
      : 'خدمات البحث';

  String searchServicesby = SessionController().getLanguage() == 1
      ? 'Search by Request No/Category'
      : 'خدمات البحث عن طريق عدد الطلبات أو الفئة';

  String searchInvoices = SessionController().getLanguage() == 1
      ? 'Search Invoices'
      : 'البحث في الفواتير';

  String searchLpos = SessionController().getLanguage() == 1
      ? "Search LPO's"
      : 'بحث عن أوامر الشراء ';

  String purposedRemedy = SessionController().getLanguage() == 1
      ? "Purposed Remedy"
      : 'الحل المقترح';

  String descriptionn =
      SessionController().getLanguage() == 1 ? "Description" : 'الوصف';

  String contractTotalAmount = SessionController().getLanguage() == 1
      ? "Contract Total Amount"
      : 'المبلغ الإجمالي للعقد';
  String contractValueUnPaid = SessionController().getLanguage() == 1
      ? "Contract Value UnPaid"
      : 'قيمة العقد غير مدفوعة';
  String contractAnnualAmount = SessionController().getLanguage() == 1
      ? "Contract Annual Amount"
      : 'مبلغ العقد السنوي';
  String contractor =
      SessionController().getLanguage() == 1 ? "CONTRACTOR" : 'مقاول';
  String contractor1 =
      SessionController().getLanguage() == 1 ? "Contractor" : 'مقاول';

  String consultant =
      SessionController().getLanguage() == 1 ? "Consultant" : 'مستشار';

  String expensesCategory = SessionController().getLanguage() == 1
      ? "Expenses Category"
      : 'فئة التكاليف';

  String contractTitle =
      SessionController().getLanguage() == 1 ? "Contract Title" : 'عنوان العقد';

  String authorizedSignatory = SessionController().getLanguage() == 1
      ? "Authorized Signatory"
      : 'المُفوَّض بالتوقيع';

  String noofInstalments = SessionController().getLanguage() == 1
      ? "No. of Payment Installments"
      : 'عدد الاقساط';

  String instalmentNo =
      SessionController().getLanguage() == 1 ? "Installment No:" : 'رقم القسط';

  String instalmentNoWithoutColon =
      SessionController().getLanguage() == 1 ? "Installment No" : 'رقم القسط';

  String paymentType =
      SessionController().getLanguage() == 1 ? "Payment Type" : 'نوع الدفعة';

  String noofStaffwithAcc = SessionController().getLanguage() == 1
      ? "No. of Staffs with Accomodation"
      : 'عدد الموظفين مع السكن';

  String noofStaffwithoutAcc = SessionController().getLanguage() == 1
      ? "No. of Staffs without Accomodation"
      : 'عدد الموظفين دون السكن';

  String contractStatus =
      SessionController().getLanguage() == 1 ? "Contract Status" : 'حالة العقد';

  String propertyType =
      SessionController().getLanguage() == 1 ? "Property Type" : 'نوع العقار';

  String selectProperty = SessionController().getLanguage() == 1
      ? "Select Property"
      : 'حدد  العقار';

  String property =
      SessionController().getLanguage() == 1 ? "Property" : 'العقار ';

  String servieContractStatus = SessionController().getLanguage() == 1
      ? "Service Contract Status"
      : 'حالة عقد الخدمة ';

  String teminate =
      SessionController().getLanguage() == 1 ? "Terminate " : 'إنهاء';

  String propertyMgt = SessionController().getLanguage() == 1
      ? "Property Management"
      : 'إدارة العقارات';

  String propertyInfo = SessionController().getLanguage() == 1
      ? "Property Info"
      : 'معلومات العقار';

  String contractDate =
      SessionController().getLanguage() == 1 ? "Issue Date" : 'تاريخ الإصدار';

  String validDateRange = SessionController().getLanguage() == 1
      ? "Please Select Valid Date Range"
      : 'يرجى تحديد نطاق تاريخ صالح';

  String from = SessionController().getLanguage() == 1 ? "From" : 'من';
  String aSonoDate = SessionController().getLanguage() == 1
      ? "Amortization Calculation Date"
      : 'تاريخ حساب الإطفاء';

  String to = SessionController().getLanguage() == 1 ? "To" : 'الى';

  String filter = SessionController().getLanguage() == 1 ? "Filter" : 'صنف';

  String chqDetailsUpdatedWithin = SessionController().getLanguage() == 1
      ? 'Note: Cheque details updated with in 7-10 days from Bank statement. '
      : 'ملاحظة: تحقق من التفاصيل المحدثة خلال 7-10 أيام من كشف الحساب المصرفي.';

  String receiptNo =
      SessionController().getLanguage() == 1 ? "Receipt No." : 'رقم الإيصال';

  String receiptNum =
      SessionController().getLanguage() == 1 ? "Receipt Number" : 'رقم الإيصال';

  String receiptDate =
      SessionController().getLanguage() == 1 ? "Receipt Date" : 'تاريخ استلام';

  String receipts =
      SessionController().getLanguage() == 1 ? 'Receipts' : 'الإيصالات';

  String amount = SessionController().getLanguage() == 1 ? "Amount" : 'مبلغ';

  String paymentFor =
      SessionController().getLanguage() == 1 ? "Payment For" : 'الدفع';

  String date = SessionController().getLanguage() == 1 ? "Date" : 'تاريخ';

  String dateOFBirth = SessionController().getLanguage() == 1
      ? 'Date Of Birth'
      : 'تاريخ الميلاد';

  String chequeDetails = SessionController().getLanguage() == 1
      ? "Cheque Details"
      : 'تفاصيل الشيك';

  String chequeNoo =
      SessionController().getLanguage() == 1 ? "Cheque No." : 'رقم الشيك';

  String chequeNo =
      SessionController().getLanguage() == 1 ? "Cheque Number" : 'رقم الشيك';

  String chqIssuerBank = SessionController().getLanguage() == 1
      ? "Chq Issuer Bank"
      : 'بنك مصدر الشيك';

  String chqStatus =
      SessionController().getLanguage() == 1 ? 'Status of Chq' : 'حالة الشيك';

  String status = SessionController().getLanguage() == 1 ? "Status" : 'الحالة';

  String paymentDate = SessionController().getLanguage() == 1
      ? "Payment Date"
      : 'تاريخ الدفع أو الاستحقاق';

  String outstandingAmount = SessionController().getLanguage() == 1
      ? "Outstanding Charges"
      : "الرسوم غير مدفوعة ";

  String paidCharges = SessionController().getLanguage() == 1
      ? "Paid Charges"
      : 'الرسوم المدفوعة';

  String vatAmount = SessionController().getLanguage() == 1
      ? "VAT Amount"
      : 'مبلغ ضريبة القيمة المضافة';

  String chargeType =
      SessionController().getLanguage() == 1 ? "Charge Type" : 'نوع الرسوم';

  String totalAmount = SessionController().getLanguage() == 1
      ? "Total Amount"
      : 'المبلغ الإجمالي';

  String contractLength =
      SessionController().getLanguage() == 1 ? "Contract Length" : 'مدة العقد';

  String startDate =
      SessionController().getLanguage() == 1 ? "Start Date" : 'تاريخ البدء';

  String endDate =
      SessionController().getLanguage() == 1 ? "End Date" : 'تاريخ الانتهاء';

  String contractAmount =
      SessionController().getLanguage() == 1 ? "Contract Amount" : 'قيمة العقد';
  String lastContractAmount = SessionController().getLanguage() == 1
      ? "Last Contract Amount"
      : 'مبلغ العقد الأخير';

  String contractDocument = SessionController().getLanguage() == 1
      ? "Contract Documnets"
      : 'وثائق العقد';

  String prevContractNo = SessionController().getLanguage() == 1
      ? "Previous Contract No"
      : 'رقم العقد السابق';

  String unitCategory =
      SessionController().getLanguage() == 1 ? "Unit Category" : 'فئة الوحدة';

  String unitType =
      SessionController().getLanguage() == 1 ? "Unit Type" : 'نوع الوحدة';

  String selectunitType = SessionController().getLanguage() == 1
      ? "Select Unit Type"
      : 'حدد نوع الوحدة';

  String unitView =
      SessionController().getLanguage() == 1 ? "Unit View" : 'عرض الوحدة';

  String area =
      SessionController().getLanguage() == 1 ? "Area" : 'مساحة / المنطقة';

  ///////////by kamran

  String areaSize =
      SessionController().getLanguage() == 1 ? "Area Size" : 'مساحة / المنطقة';

  String currentRent = SessionController().getLanguage() == 1
      ? "Current Rent"
      : 'الإيجار الحالي';

  String facilities =
      SessionController().getLanguage() == 1 ? "Facilities" : 'المرافق';

  String residential =
      SessionController().getLanguage() == 1 ? "Residential" : "سكني";

  String bedRooms =
      SessionController().getLanguage() == 1 ? "Bed Rooms" : 'غرف نوم';

  String kitchens =
      SessionController().getLanguage() == 1 ? "Kitchens" : 'مطابخ';

  String maidRooms =
      SessionController().getLanguage() == 1 ? "Maid Rooms" : 'غرف الخادمة';

  String livingRooms =
      SessionController().getLanguage() == 1 ? "Living Rooms" : 'غرف المعيشة';

  String balconies =
      SessionController().getLanguage() == 1 ? "Balconies" : 'الشرفات';

  String washrooms =
      SessionController().getLanguage() == 1 ? "Washrooms" : 'حمام';

  String driverRooms =
      SessionController().getLanguage() == 1 ? "Driver Rooms" : 'غرف السائقين';

  String unitRefNo =
      SessionController().getLanguage() == 1 ? "Unit Ref No" : 'رقم الوحدة';

  String unitNo =
      SessionController().getLanguage() == 1 ? "Unit No" : 'رقم الوحدة';

  String noofUnits =
      SessionController().getLanguage() == 1 ? "No of Units" : 'عدد الوحدات';

  String rent =
      SessionController().getLanguage() == 1 ? "Rent" : 'القيمة الايجارية';
  String annualRent =
      SessionController().getLanguage() == 1 ? "Annual Rent" : 'الإيجار السنوي';

  String noofRooms =
      SessionController().getLanguage() == 1 ? "No of Rooms" : 'عدد الغرف';

  String clear = SessionController().getLanguage() == 1 ? "Clear" : 'امسح';

  String noPaymentFound = SessionController().getLanguage() == 1
      ? 'No Payment Found'
      : 'لم يتم العثور على دفعة';

  String noOfPaymentInstallments = SessionController().getLanguage() == 1
      ? 'No. of Payment Installments'
      : 'عدد أقساط السداد';

  String type = SessionController().getLanguage() == 1 ? 'Type' : 'نوع';

  String noServiceRequestsFound = SessionController().getLanguage() == 1
      ? 'No Service Requests Found'
      : 'لم يتم العثور على طلبات الخدمة';

  String maintenance =
      SessionController().getLanguage() == 1 ? 'Maintenance' : 'خدمات الصيانة';

  String leasing =
      SessionController().getLanguage() == 1 ? 'Leasing' : 'خدمات الايجارية';

  String filterSR = SessionController().getLanguage() == 1
      ? 'Filter Service Requests'
      : 'صنف طلبات الخدمات';

  ///////////////////////////////
  /// Tenant Profile Screen Labels
  ///////////////////////////////

  String myProfileTenant =
      SessionController().getLanguage() == 1 ? 'My Profile' : 'الملف الشخصى';

  String tenant = SessionController().getLanguage() == 1 ? 'Tenant' : 'مستأجر';

  String personalInfo = SessionController().getLanguage() == 1
      ? 'Personal Info'
      : 'معلومات شخصية';

  /////////////////////////////online payments

  String title = SessionController().getLanguage() == 1 ? 'Title' : 'عنوان';

  String reasonOfPayment = SessionController().getLanguage() == 1
      ? 'Reason of Payment'
      : 'سبب الدفع';

  String refNo =
      SessionController().getLanguage() == 1 ? 'Ref. No.' : 'الرقم المرجعي';

  String makePayment =
      SessionController().getLanguage() == 1 ? 'Make Payment' : 'قم بالدفع';

  ///////////////////////////////
  /// Vendor Dashboard Labels
  ///////////////////////////////

  String vendor = SessionController().getLanguage() == 1 ? 'Vendor' : 'المقاول';

  String pleaseFillDataInMainInfoFirst = SessionController().getLanguage() == 1
      ? 'Please enter the data in Main Info First'
      : 'الرجاء إدخال البيانات في المعلومات الرئيسية أولاً';

  String pleaseSelectServiceType = SessionController().getLanguage() == 1
      ? 'Please Select Service Type'
      : 'الرجاء تحديد نوع الخدمة';

  String pleaseEnterInvoiceAmountVal = SessionController().getLanguage() == 1
      ? 'Please Enter Invoice Amount Value'
      : 'الرجاء إدخال قيمة مبلغ الفاتورة';

  String pleaseEnterInvoiceNOVal = SessionController().getLanguage() == 1
      ? 'Please Enter Invoice No'
      : 'الرجاء إدخال رقم الفاتورة';
  String pleaseEnterValidChequeNO = SessionController().getLanguage() == 1
      ? 'Please enter valid Cheque Number'
      : 'الرجاء إدخال رقم الشيك الصحيح';

  String pleaseEnterInstallmentVal = SessionController().getLanguage() == 1
      ? 'Please Select Installment No'
      : 'الرجاء تحديد رقم القسط';

  String pleaseEnterInvoiceTRNVal = SessionController().getLanguage() == 1
      ? 'Please Enter Value Of TRN '
      : 'الرجاء إدخال قيمة TRN';

  String pleaseEnterDescription = SessionController().getLanguage() == 1
      ? 'Please Enter Remarks '
      : 'لرجاء إدخال الملاحظات';

  String pleaseSelectWorkCompleteionDate =
      SessionController().getLanguage() == 1
          ? 'Please Select Work Completion Date  '
          : 'يرجى تحديد تاريخ إتمام العمل';

  String pleaseSelectInvoiceDate = SessionController().getLanguage() == 1
      ? 'Please Select Invoice Date  '
      : 'يرجى تحديد تاريخ الفاتورة';

  String lpos =
      SessionController().getLanguage() == 1 ? "LPOs" : 'أوامر الشراء ';

  String lpo = SessionController().getLanguage() == 1 ? "LPO" : 'أوامر الشراء ';
  String lpoNo = SessionController().getLanguage() == 1 ? 'LPO No' : 'Lpo رقم';
  String nolpoNosFounf = SessionController().getLanguage() == 1
      ? 'No LPOs Found'
      : 'لم يتم العثور على LPOs';
  String aMCNo = SessionController().getLanguage() == 1 ? 'AMC No' : 'Amc رقم';
  String noAMCNosFound = SessionController().getLanguage() == 1
      ? 'No AMCs Found'
      : 'لم يتم العثور على AMCs';
  String yourBalanceAMount = SessionController().getLanguage() == 1
      ? 'Your Balance amount is '
      : 'مبلغ رصيدك هو ';
  String pleaseEnterValidAMount = SessionController().getLanguage() == 1
      ? ' ,Please enter valid amount'
      : ' الرجاء إدخال مبلغ صالح ';
  String pleaseEnterValidAMountSeparate = SessionController().getLanguage() == 1
      ? 'Please enter valid amount'
      : ' الرجاء إدخال مبلغ صالح ';
  String yourBalanceAmount = SessionController().getLanguage() == 1
      ? 'Your Balance amount is '
      : ' مبلغ رصيدك هو ';
  String pleaseEnterValidName = SessionController().getLanguage() == 1
      ? 'Please enter valid name'
      : ' الرجاء إدخال اسم صحيح ';
  String remarks =
      SessionController().getLanguage() == 1 ? 'Remarks' : 'ملاحظات';

  String lpoInProgress = SessionController().getLanguage() == 1
      ? "LPOs in Progress"
      : 'أوامر الشراء قيد التنفيذ';

  String amc =
      SessionController().getLanguage() == 1 ? "AMC" : 'عقد الصيانة السنوي';

  String invoices =
      SessionController().getLanguage() == 1 ? 'Invoices' : 'الفواتير';

  String specialCharNotAllowed = SessionController().getLanguage() == 1
      ? '(Special character not allowed)'
      : '(الأحرف الخاصة غير مسموح بها)';

  String invoice =
      SessionController().getLanguage() == 1 ? 'Invoice' : 'الفواتير';

  String invoicesNo =
      SessionController().getLanguage() == 1 ? 'Invoice No' : 'رقم الفاتورة';

  String invoiceDate = SessionController().getLanguage() == 1
      ? "Invoice Date"
      : 'تاريخ الفاتورة';

  String invoiceAmount = SessionController().getLanguage() == 1
      ? "Invoice Amount"
      : 'قيمة الفاتورة';

  String invoiceType =
      SessionController().getLanguage() == 1 ? "Invoice type" : 'نوع الفاتورة';

  String svcContracts = SessionController().getLanguage() == 1
      ? 'Service Contracts'
      : 'عقود الخدمة';

  String myProfile =
      SessionController().getLanguage() == 1 ? 'My Profile' : 'الملف الشخصى';

  String addNewUnit = SessionController().getLanguage() == 1
      ? 'Add new booking'
      : ' طلب حجز للعقار';

  String paymentInProcess = SessionController().getLanguage() == 1
      ? "Payment in Process"
      : 'الدفع قيد التنفيذ';

  String invoicesUnderProcess = SessionController().getLanguage() == 1
      ? "Invoices under process"
      : 'الفواتير تحت التنفيذ';

  String totalLpos = SessionController().getLanguage() == 1
      ? "Total LPOs"
      : 'إجمالي أوامر الشراء';

  String activeLpos = SessionController().getLanguage() == 1
      ? "Active LPOs"
      : 'أمر الشراء الفعال';

  String totalContractValues = SessionController().getLanguage() == 1
      ? "Total Contract Values"
      : 'إجمالي قيم العقد';

  String invoiceSubmitted = SessionController().getLanguage() == 1
      ? "Invoices Submitted"
      : 'الفواتير المُقدَّمة';

  String invoiceSubmittedCapital = SessionController().getLanguage() == 1
      ? "INVOICES SUBMITTED"
      : 'الفواتير المقدمة';

  String viewAllLpos = SessionController().getLanguage() == 1
      ? "VIEW ALL LPO's"
      : 'عرض كل أوامر الشراء';
  String viewAllServiceReq = SessionController().getLanguage() == 1
      ? "VIEW ALL SERVICE REQUESTS"
      : "عرض جميع طلبات الخدمة";

  String email =
      SessionController().getLanguage() == 1 ? 'Email' : 'البريد الالكتروني';

  String address =
      SessionController().getLanguage() == 1 ? 'Address' : 'العنوان';

  String lposSvc =
      SessionController().getLanguage() == 1 ? "SERVICES" : 'الخدمات';

  String lposterms =
      SessionController().getLanguage() == 1 ? "TERMS" : 'الشروط';

  String lposProperties =
      SessionController().getLanguage() == 1 ? "PROPERTIES" : 'العقارات';

  String lposInvoices =
      SessionController().getLanguage() == 1 ? "INVOICES" : 'الفواتير';

  String lpoRefNo = SessionController().getLanguage() == 1
      ? 'LPO Ref. No.'
      : 'الرقم المرجعي لأمر الشراء';

  String lpoDate =
      SessionController().getLanguage() == 1 ? 'LPO Date' : 'تاريخ أمر الشراء ';

  String paidBy =
      SessionController().getLanguage() == 1 ? 'Paid By' : 'تم الدفع بواسطة';

  String recBy =
      SessionController().getLanguage() == 1 ? 'Received By' : 'استلمت من قبل';

  String payMethod = SessionController().getLanguage() == 1
      ? 'Payment Method'
      : 'طريقة الدفع أو السداد';

  String payDate =
      SessionController().getLanguage() == 1 ? 'Payment Date' : 'تاريخ الدفع';

  String grandTotal = SessionController().getLanguage() == 1
      ? 'Grand Total'
      : 'المجموع الإجمالي';

  String noInvoicesFound = SessionController().getLanguage() == 1
      ? 'No Invoices Found'
      : 'لم يتم العثور على فواتير';

  String lPOStatus = SessionController().getLanguage() == 1
      ? 'LPO Status'
      : 'حالة  أمر الشراء';

  String completionDate = SessionController().getLanguage() == 1
      ? 'Completion Date'
      : 'تاريخ الاكتمال';

  String grossAmount = SessionController().getLanguage() == 1
      ? 'Gross Amount'
      : 'المبلغ الإجمالي';

  String discountAmount =
      SessionController().getLanguage() == 1 ? 'Discount Amount' : 'مبلغ الخصم';

  String discountPercentage = SessionController().getLanguage() == 1
      ? 'Discount Percentage'
      : 'نسبة الخصم';

  String netAmount =
      SessionController().getLanguage() == 1 ? 'Net Amount' : 'المبلغ الصافي';

  String pleaseSelect = SessionController().getLanguage() == 1
      ? 'Please select...'
      : 'يرجى تحديد ...';

  String pleaseSelectFromDate = SessionController().getLanguage() == 1
      ? 'Please select From date'
      : 'الرجاء تحديد من التاريخ';

  String pleaseSelectAsNODate = SessionController().getLanguage() == 1
      ? 'Please select Amorization Calculation Date'
      : 'الرجاء تحديد Amoriztiyan Kalkalathiyan Date';

  String dateRangeOfReport = SessionController().getLanguage() == 1
      ? 'Only 1 years data can be downloaded at one time'
      : 'يمكن تنزيل بيانات 3 سنوات فقط في وقت واحد';

  String pleaseSelectToDate = SessionController().getLanguage() == 1
      ? 'Please select To date'
      : 'الرجاء تحديد  التاريخ';

  String first = SessionController().getLanguage() == 1 ? ' first' : 'أولاً';

  String pleaseSelectFileFirst = SessionController().getLanguage() == 1
      ? 'Please select document at first'
      : 'الرجاء تحديد الوثيقة في البداية';

  String pleaseSelectAgent = SessionController().getLanguage() == 1
      ? 'Please select agent'
      : 'يرجى  تحديد وكيل';

  String sRType = SessionController().getLanguage() == 1
      ? 'Service Request Type'
      : 'نوع طلب الخدمة';

  String sRNO = SessionController().getLanguage() == 1 ? 'SR No. ' : 'SR No. ';

  String serviceNO =
      SessionController().getLanguage() == 1 ? 'Service No' : 'رقم الخدمة';

  String instNo =
      SessionController().getLanguage() == 1 ? 'Inst.No	' : 'رقم القسط';

  String tRNofLandlord = SessionController().getLanguage() == 1
      ? 'TRN of Landlord	'
      : 'رقم التعريف الضريبي للمالك';

  String noLPOFound = SessionController().getLanguage() == 1
      ? 'No LPOs Found'
      : 'لم يتم العثور على أمر الشراء  ';

  String docRefNo = SessionController().getLanguage() == 1
      ? 'Doc Ref No'
      : 'رقم مرجع المستند';

  String lPOType =
      SessionController().getLanguage() == 1 ? 'LPO Type' : 'نوع أمر الشراء ';

  String total = SessionController().getLanguage() == 1 ? 'Total' : 'المجموع';

  String offers = SessionController().getLanguage() == 1 ? 'Offers' : 'العروض';

  String offerProperties = SessionController().getLanguage() == 1
      ? 'Offer Properties '
      : 'عروض العقارات ';

  String accountTitle =
      SessionController().getLanguage() == 1 ? 'Account Title: ' : 'إسم الحساب';

  String accountNo =
      SessionController().getLanguage() == 1 ? 'Account No.' : 'رقم الحساب';

  String ibanNo = SessionController().getLanguage() == 1
      ? 'IBAN No.'
      : ' رقم الحساب المصرفي الدولي';

  String swiftCode = SessionController().getLanguage() == 1
      ? 'Swift Code'
      : 'رقم التحويل المالي';

  String faxNumber =
      SessionController().getLanguage() == 1 ? 'Fax Number' : 'رقم الفاكس';

  String iDNumber =
      SessionController().getLanguage() == 1 ? 'ID Number' : 'رقم الهوية';
  String transactionID = SessionController().getLanguage() == 1
      ? 'Transaction ID'
      : 'رقم المعاملة';

  String phoneNumber =
      SessionController().getLanguage() == 1 ? 'Phone Number' : 'رقم الهاتف';

  String emailAddress = SessionController().getLanguage() == 1
      ? 'Email Address'
      : 'عنوان البريد الكتروني';

  String isAuthorizedSignatory = SessionController().getLanguage() == 1
      ? 'Is Authorized Signatory'
      : 'هو المُفوَّض بالتوقيع';

  String supplierTRN = SessionController().getLanguage() == 1
      ? 'Supplier TRN'
      : 'رقم تسجيل دافع ضرائب المورد';

  String tradeLicenseNo = SessionController().getLanguage() == 1
      ? 'Trade License No'
      : 'رقم الرخصة التجارية';

  String contacts =
      SessionController().getLanguage() == 1 ? 'CONTACTS' : 'جهات الاتصال';

  String accounts =
      SessionController().getLanguage() == 1 ? 'ACCOUNTS' : 'حسابات';

  String editProfile = SessionController().getLanguage() == 1
      ? 'Edit Profile'
      : 'تعديل الملف الشخصي';

  String uploadDocs = SessionController().getLanguage() == 1
      ? 'Upload Documents'
      : 'تحميل المستندات';

  String stayOnPage = SessionController().getLanguage() == 1
      ? 'Stay On Page'
      : 'للبقاء فى الصفحة';

  String goToDashoboard =
      SessionController().getLanguage() == 1 ? 'Dashboard' : 'لوحة البداية';

  String docsSubmitted = SessionController().getLanguage() == 1
      ? 'Documents Submitted'
      : 'المستندات المقدمة';

  String docsApproved = SessionController().getLanguage() == 1
      ? 'Documents Approved'
      : 'تمت الموافقة على المستندات';

  String contractSigned = SessionController().getLanguage() == 1
      ? 'Contract Signed'
      : 'تم توقيع العقد';

  String approveMunicipal = SessionController().getLanguage() == 1
      ? 'Municipality Approval'
      : 'الموافقة البلدية';

  String instructions =
      SessionController().getLanguage() == 1 ? 'Instructions' : 'الإرشادات';

  String municipalApproval = SessionController().getLanguage() == 1
      ? 'Municipality Contract Approval'
      : 'اعتماد العقد فى البلدية';

  String confirmMunicipality = SessionController().getLanguage() == 1
      ? "I confirm that I've completed the municipality approval procedure."
      : 'أؤكد أنني أكملت إجراءات موافقة البلدية';

  String uploadVendorDocs = SessionController().getLanguage() == 1
      ? 'Upload Vendor Documents'
      : 'تحميل مستندات المقاول';

  String lpoAck = SessionController().getLanguage() == 1
      ? 'LPO Acknowledgement'
      : 'إقرار أمر الشراء ';

  String yourDocs = SessionController().getLanguage() == 1
      ? 'Your Documents'
      : 'المستندات الخاصة بك';

  String docsLike = SessionController().getLanguage() == 1
      ? 'Trade License, Certificates, Insurance, VAT Certificate etc...'
      : 'الرخصة التجارية ، الشهادات ، التأمين ، شهادة ضريبة القيمة المضافة ، إلخ ...';

  String uploadYourDoc = SessionController().getLanguage() == 1
      ? 'Upload Your Document'
      : 'قم بتحميل المستند الخاص بك';

  String allMandatory = SessionController().getLanguage() == 1
      ? 'All mandatory documents must be uploaded to submit'
      : 'يجب تحميل جميع الوثائق الإلزامية لتقديمها';

  String expDate =
      SessionController().getLanguage() == 1 ? 'Expiry Date' : 'تاريخ الانتهاء';

  String dateFormat = SessionController().getLanguage() == 1
      ? 'dd-MM-yyyy'
      : 'اليوم-الشهر-السنة';

  String dateFormatForShowRoundedDatePicker =
      SessionController().getLanguage() == 1 ? 'dd-MM-yyyy' : 'dd-MM-yyyy';

  String selectFuturedate = SessionController().getLanguage() == 1
      ? 'Please select future date'
      : 'يرجى تحديد التاريخ المستقبلي';

  String saved = SessionController().getLanguage() == 1 ? 'Saved' : 'تم الحفظ';

  String updatedSuccessfully = SessionController().getLanguage() == 1
      ? 'Updated Successfully'
      : 'تم التحديث بنجاح';

  ///////////////////////////////
  /// LandLord Labels
  ///////////////////////////////

  String landlord =
      SessionController().getLanguage() == 1 ? 'LandLord' : 'المالك';

  ///////////////////////////////
  /// Public Labels
  ///////////////////////////////

  String public = SessionController().getLanguage() == 1 ? 'Public' : 'زائر';

  // String public = SessionController().getLanguage() == 1 ? 'Public' : 'عام';
  /////////////////// Changed by kamran ////////////////////////////

  String sqf =
      SessionController().getLanguage() == 1 ? 'SQF' : 'المساحة بالقدم المربع';

  String sqm =
      SessionController().getLanguage() == 1 ? 'SQF' : 'المساحة بالمتر المربع';

  ///////////////////////////////////////////////////////////////////
  ///////////////////////////////
  /// button Labels
  ///////////////////////////////

  String retry =
      SessionController().getLanguage() == 1 ? 'Retry' : 'أعد المحاولة';

  String apply = SessionController().getLanguage() == 1 ? 'Apply' : 'تم';

  String submit = SessionController().getLanguage() == 1 ? 'Submit' : 'قدم';

  String upload = SessionController().getLanguage() == 1 ? 'Upload' : 'تحميل';

  String attachCopy = SessionController().getLanguage() == 1
      ? 'Attach Cheque Copy'
      : ' تحميل الشيك ';

  String confirm = SessionController().getLanguage() == 1 ? 'Confirm' : 'تاكيد';

  ///////////////////////////////
  /// Error Messages Labels
  ///////////////////////////////

  String validPhoneNo = SessionController().getLanguage() == 1
      ? 'Please Enter Valid Mobile Number'
      : 'يرجى إدخال رقم هاتف صحيح';
  String incorrectData = SessionController().getLanguage() == 1
      ? 'Incorrect Data'
      : 'بيانات غير صحيحة';

  String incorrectCode = SessionController().getLanguage() == 1
      ? 'You\'ve entered an incorrect code.'
      : 'لقد أدخلت رمزًا غير صحيح.';

  String incorrectMpin = SessionController().getLanguage() == 1
      ? 'You\'ve entered an incorrect MPIN.'
      : 'لقد قمت بإدخال رقم تعريف شخصي غير صحيح.';
  String tooManyReqtryLater = SessionController().getLanguage() == 1
      ? "Too Many Requests,Try Later "
      : 'الكثير من الطلبات، جرب لاحقًا';

  String tooltipName =
      SessionController().getLanguage() == 1 ? 'User Name' : 'اسم االمستخدم';

  String tooltipNumber = SessionController().getLanguage() == 1
      ? 'User Mobile Number'
      : 'رقم هاتف المستخدم';

  String mpinNotLess = SessionController().getLanguage() == 1
      ? 'MPIN must not less then 6'
      : 'رقم التعريف الشخصي يجب أن لا يقل عن 6 ارقام';

  String mpinDidNotMatch = SessionController().getLanguage() == 1
      ? 'MPIN didn\'t Match'
      : 'رقم التعريف الشخصي  غير متطابق';

  String selectAtleastOne = SessionController().getLanguage() == 1
      ? 'Please select atleast one'
      : 'يرجى تحديد واحد على الأقل';

  String selectFromDate = SessionController().getLanguage() == 1
      ? 'Please select From Date'
      : 'يرجى التحديد من التاريخ';

  String selectToDate = SessionController().getLanguage() == 1
      ? 'Please select To Date'
      : 'يرجى تحديد تاريخ';

  String noContractsFound = SessionController().getLanguage() == 1
      ? 'No Contracts Found'
      : 'لا توجد عقود';

  String on = SessionController().getLanguage() == 1 ? 'ON' : 'تشغيل';

  String off = SessionController().getLanguage() == 1 ? 'OFF' : 'إيقاف';

  String noMethodsFound = SessionController().getLanguage() == 1
      ? 'No Payment Methods Found'
      : 'لم يتم العثور على طرق دفع';

  /////////////////
  /// service req
  /// /////////

  String downloadContract = SessionController().getLanguage() == 1
      ? 'Download Contract'
      : 'تنزيل العقد';

  String downloadReport = SessionController().getLanguage() == 1
      ? 'Download Report'
      : 'تنزيل التقرير';

  String downloadingReport = SessionController().getLanguage() == 1
      ? 'Downloading ....'
      : 'تنزيل ......';

  String downloaded =
      SessionController().getLanguage() == 1 ? 'Downloaded' : 'تم التنزي';

  String download =
      SessionController().getLanguage() == 1 ? 'Download' : 'تحميل';

  String viewReport =
      SessionController().getLanguage() == 1 ? 'View Report' : 'عرض التقرير';

  String downloadReceipt = SessionController().getLanguage() == 1
      ? 'Download Receipt'
      : 'تنزيل الإيصال';

  String documents =
      SessionController().getLanguage() == 1 ? 'Documents' : 'الوثائق';

  String addRequest =
      SessionController().getLanguage() == 1 ? 'Add Request' : 'أضف  الطلب';

  String yourMessage =
      SessionController().getLanguage() == 1 ? 'Your Message' : 'رسالتك';

  String addFile =
      SessionController().getLanguage() == 1 ? 'Attach File' : 'أرفق ملف';

  String describeTheService = SessionController().getLanguage() == 1
      ? 'Describe the service you require'
      : 'صِف الخدمة التي تريدها';

  String addPhotos =
      SessionController().getLanguage() == 1 ? 'Add photos' : 'أضف الصور';

  String addFeedback =
      SessionController().getLanguage() == 1 ? 'Add Feedback' : 'أضف تعليقاتك';

  String takeSurvey = SessionController().getLanguage() == 1
      ? 'Take Survey'
      : 'شارك في الاستبيان';

  String survey = SessionController().getLanguage() == 1 ? 'Survey' : 'استبيان';

  String surveyCompTitle = SessionController().getLanguage() == 1
      ? 'Survey Completed'
      : 'تم الانتهاء من الاستبيان';

  String surveyCompMsg = SessionController().getLanguage() == 1
      ? 'Thanks for giving your precious time to complete the survey.'
      : 'نشكرك على إكمال الاستبيان.';

  String added = SessionController().getLanguage() == 1 ? 'Added' : 'مُضاف';

  String whyDoYou = SessionController().getLanguage() == 1
      ? 'Why do you want to reopen request?'
      : 'لماذا تريد إعادة فتح الطلب';

  String enterRemarks = SessionController().getLanguage() == 1
      ? 'Enter remarks'
      : 'أدخل الملاحظات';

  String reopenRequest = SessionController().getLanguage() == 1
      ? 'Reopen Request'
      : 'إعادة فتح الطلب';

  String areYouSure = SessionController().getLanguage() == 1
      ? 'Are you sure you want to cancel request?'
      : 'هل أنت متأكد أنك تريد إلغاء الطلب';

  String areYouSureToClose = SessionController().getLanguage() == 1
      ? 'Are you sure you want to close request?'
      : 'هل أنت متأكد من إغلاق الطلب';

  String tenantSignature = SessionController().getLanguage() == 1
      ? 'Tenant Signature'
      : 'توقيع المستأجر';

  String vendorSignature = SessionController().getLanguage() == 1
      ? 'Vendor Signature'
      : 'توقيع المقاول';

  String yes = SessionController().getLanguage() == 1 ? 'Yes' : 'نعم';

  String no = SessionController().getLanguage() == 1 ? 'No' : 'لا';

  String cancelRequest =
      SessionController().getLanguage() == 1 ? 'Cancel request' : 'إلغاء الطلب';

  String caseType =
      SessionController().getLanguage() == 1 ? 'Case type' : 'نوع الطلب';

  String category =
      SessionController().getLanguage() == 1 ? 'Category' : 'الفئة';

  String selectCategory =
      SessionController().getLanguage() == 1 ? 'Select Category' : 'حدّد الفئة';

  String pleaseSelectCategory = SessionController().getLanguage() == 1
      ? 'Please Select Category'
      : 'الرجاء تحديد الفئة';

  String subCategory =
      SessionController().getLanguage() == 1 ? 'Sub Category' : 'تصنيف فرعي';

  String selectSubCategory = SessionController().getLanguage() == 1
      ? 'Select Sub Category'
      : 'حدد فئة فرعية';

  String city = SessionController().getLanguage() == 1 ? 'City' : 'المدينة';

  String contactTime =
      SessionController().getLanguage() == 1 ? 'Contact Time' : 'وقت الاتصال';

  String description =
      SessionController().getLanguage() == 1 ? 'Description' : 'الوصف';

  String submitRequest =
      SessionController().getLanguage() == 1 ? 'Submit Request' : 'تقديم الطلب';

  String next = SessionController().getLanguage() == 1 ? 'Next' : 'التالي';

  String locationType =
      SessionController().getLanguage() == 1 ? 'Location Type' : 'نوع الموقع';

  String location =
      SessionController().getLanguage() == 1 ? 'Location' : 'الموقع';

  String offices =
      SessionController().getLanguage() == 1 ? 'Offices' : 'مكاتبنا';

  String ourServices =
      SessionController().getLanguage() == 1 ? 'Our Services' : 'الخدمات';

  String promotions =
      SessionController().getLanguage() == 1 ? 'Promotions' : 'العروض';

  String feedback =
      SessionController().getLanguage() == 1 ? 'Feedback' : 'الملاحظات';

  String rateExperience = SessionController().getLanguage() == 1
      ? 'Rate your experience'
      : 'قيم تجربتك';

  String areYouSatisfied = SessionController().getLanguage() == 1
      ? 'Are you satisfied with the Service?'
      : 'هل أنت راض عن الخدمة';

  String tellUs = SessionController().getLanguage() == 1
      ? 'Tell us how can we improve'
      : 'أخبرنا كيف يمكننا أن نتحسن';

  String acknowledged =
      SessionController().getLanguage() == 1 ? 'Acknowledged' : 'علم';

  String rejected =
      SessionController().getLanguage() == 1 ? 'Rejected' : 'مرفوض';

  String report = SessionController().getLanguage() == 1 ? 'Report' : 'تقرير';
  String summary = SessionController().getLanguage() == 1 ? 'Summary' : 'ملخص';

  String serviceCompletionReport = SessionController().getLanguage() == 1
      ? 'Service Completion Report'
      : 'تقرير إتمام الخدمة';

  String requestno =
      SessionController().getLanguage() == 1 ? 'Request No.' : 'رقم الطلب.';

  String uploadReport = SessionController().getLanguage() == 1
      ? 'Upload Service Report'
      : 'تحميل تقرير الخدمة';

  String uploadPhotos =
      SessionController().getLanguage() == 1 ? 'Upload Photos' : 'تحميل الصور';

  String uploadYourReport = SessionController().getLanguage() == 1
      ? 'Upload Your Service Report'
      : 'قم بتحميل تقرير الخدمة الخاص بك';

  String fileMustNot = SessionController().getLanguage() == 1
      ? 'File must not exceed 10MB (JPG, PNG, PDF formats only)'
      : 'يجب ألا يتجاوز الملف 10 ميجابايت (بتنسيقات JPG و PDF,PNG فقط)';

  String cannotAddSvcReq = SessionController().getLanguage() == 1
      ? 'You do not have any active contract. So you cannot add a service request.'
      : 'ليس لديك أي عقد فعال. لذلك لا يمكنك إضافة طلب خدمة.';

  ///////////////////////////////
  /// Baseclient Messages Labels
  ///////////////////////////////

  String noInternetConnection = SessionController().getLanguage() == 1
      ? 'No internet Connection'
      : 'لا يوجد اتصال بالإنترنت';

  String connectionTimedOut = SessionController().getLanguage() == 1
      ? 'Connection timed out'
      : 'انتهت مهلة الاتصال';

  String couldNotConnectToServer = SessionController().getLanguage() == 1
      ? 'Could not connect to server'
      : 'لا يمكن الاتصال باالحاسوب الرئيسي';

  String unauthorized =
      SessionController().getLanguage() == 1 ? 'Unauthorized' : 'غير مصرح به';

  String noDatafound = SessionController().getLanguage() == 1
      ? 'No data found'
      : 'لاتوجد بيانات';

  String noInstallmentfound = SessionController().getLanguage() == 1
      ? 'No Installment found'
      : 'کوئی قسط نہیں ملی';
  String noOptionsfound = SessionController().getLanguage() == 1
      ? 'No Options found'
      : 'لم يتم العثور على خيارات';

  String pleaseEnterMobileNoWithoutZero = SessionController().getLanguage() == 1
      ? 'Please do not start your phone number with zero'
      : 'من فضلك لا تبدأ رقم هاتفك بصفر';

  String pleaseEnterMobileNo = SessionController().getLanguage() == 1
      ? 'Please enter your phone number'
      : 'يرجى إدخال رقم الهاتف الخاص بك';

  String badRequest =
      SessionController().getLanguage() == 1 ? 'Bad Request' : 'طلب خاطئ';

  String invalidName = SessionController().getLanguage() == 1
      ? 'Only alphabets and spaces allowed'
      : 'فقط حروف وفراغات مسموحة';

  String invalidPhone = SessionController().getLanguage() == 1
      ? 'Only numbers and + allowed'
      : 'فقط ارقام وعلامة  + مسموحة';

  String invalidText = SessionController().getLanguage() == 1
      ? "Only alphabets, numbers, spaces and . , ' -_ allowed"
      : 'فقط حروف ارقام وفراغات واشارات مسموحة';

  String fillAllFields = SessionController().getLanguage() == 1
      ? 'Please fill all fields'
      : 'يرجى تعبئة كل الخانات ';

  String selectRating = SessionController().getLanguage() == 1
      ? 'Please select some rating'
      : 'يرجى تحديد التصنيف';

  String enterSomeRemarks = SessionController().getLanguage() == 1
      ? 'Please enter remarks'
      : 'يرجى إدخال الملاحظات';

  String notFound =
      SessionController().getLanguage() == 1 ? 'NotFound' : 'لا يوجد';

  String noSvcFound = SessionController().getLanguage() == 1
      ? 'No Services Found'
      : 'لم يتم العثور على خدمات';

  String anyError = SessionController().getLanguage() == 1
      ? 'Something went wrong'
      : 'حدث خطأ ما';

  String noPhotos = SessionController().getLanguage() == 1
      ? 'No Photos Found'
      : 'لم يتم العثور على صور';

  String noReports = SessionController().getLanguage() == 1
      ? 'No Reports Found'
      : 'لم يتم العثور على تقارير';

  String success = SessionController().getLanguage() == 1 ? 'Success' : 'نجاح';

  String appUpdatedSuccess = SessionController().getLanguage() == 1
      ? 'App Updated Successfully'
      : 'تم تحديث التطبيق بنجاح';

  String appUpdatFailed = SessionController().getLanguage() == 1
      ? 'App Updated Failed'
      : 'فشل تحديث التطبيق';

  String feedBackAddedSuccessFully = SessionController().getLanguage() == 1
      ? 'Feedback submit successfully'
      : 'إرسال الملاحظات بنجاح';

  String fileDownloadedSuccessfully = SessionController().getLanguage() == 1
      ? 'File downloaded successfully inside your device'
      : 'تم تنزيل الملف بنجاح داخل جهازك';

  String reqBooking =
      SessionController().getLanguage() == 1 ? 'Request Booking' : 'طلب الحجز';

  String pleaseSelectPayment = SessionController().getLanguage() == 1
      ? 'Please Select Some Payment'
      : 'الرجاء تحديد بعض المدفوعات';

  String successfullyPaid = SessionController().getLanguage() == 1
      ? 'Payments are completed.'
      : 'اكتملت الدفعات';
  // ? 'Card Payments / Bank Transfers are completed.'
  // : 'تم الدفع لبطاقة / التحويلات المصرفية';

  String errorProcessingPayment = SessionController().getLanguage() == 1
      ? 'Error processing payment. Please try later.'
      : 'خطأ في معالجة الدفع. الرجاء المحاولة لاحقا.';

  String requiredField =
      SessionController().getLanguage() == 1 ? 'Required' : 'مطلوب';

  String selectFABCorrectiveAction = SessionController().getLanguage() == 1
      ? 'Select Corrective Action'
      : 'حدد الإجراء التصحيحي';

  List<String> fABCorrectiveActionList = SessionController().getLanguage() == 1
      ? ['Repair', 'Replace', 'Reset', 'Other']
      : ['تصليح', 'تغيير', ' إعادة ضبط', 'آخر'];

  String pleaseSelectFABCorrectiveAction =
      SessionController().getLanguage() == 1
          ? 'Please Select any FAB Corrective Action'
          : 'يرجى تحديد أي إجراء تصحيحي لبنك أبوظبي الأول';

  String noSurveyFound = SessionController().getLanguage() == 1
      ? 'No Survey Found'
      : 'لم يتم العثور على استبيان';

  //////////////////////////////////////////

  String posted =
      SessionController().getLanguage() == 1 ? 'Posted' : 'تم النشر';

  String active = SessionController().getLanguage() == 1 ? 'Active' : 'فعال';

  /////////////////////////
  ///Under Development
  /////////////////////

  String underDev = SessionController().getLanguage() == 1
      ? 'To be implemented'
      : 'ليتم تنفيذه';

  ////////////////////////////////////////////////////
  ///contract rewenew

  String offerLetter =
      SessionController().getLanguage() == 1 ? 'Offer Letter' : 'رسالة عرض سعر';

  String extend = SessionController().getLanguage() == 1 ? 'Extend' : 'تمديد';

  String terminate =
      SessionController().getLanguage() == 1 ? 'Vacate' : 'اخلاء';

  String otherUnitInfo = SessionController().getLanguage() == 1
      ? 'Other Unit Info'
      : 'معلومات أخرى عن الوحدة';

  String searchVacantUnits = SessionController().getLanguage() == 1
      ? 'Search Vacant Units'
      : 'ابحث عن الوحدات الشاغرة';

  String selectNewUnit = SessionController().getLanguage() == 1
      ? 'Select New Unit'
      : 'حدد وحدة جديدة';

  String checkin =
      SessionController().getLanguage() == 1 ? 'Check-in' : 'سجل الدخول';

  String checkinReq = SessionController().getLanguage() == 1
      ? 'Check-in Request'
      : 'طلب تسجيل الدخول';

  String checkinReqSubmitted = SessionController().getLanguage() == 1
      ? 'Check-in Request Submitted'
      : 'تم إرسال طلب تسجيل الدخول';

  String checkinReqMsg = SessionController().getLanguage() == 1
      ? 'Are you sure you want to check-in contract?'
      : 'هل أنت متأكد أنك تريد أن توقع العقد ';

  String yourCheckinAgainst = SessionController().getLanguage() == 1
      ? "Your Check-in Request against Contract "
      : 'طلب تسجيل الدخول الخاص بك مقابل رقم العقد';

  String yourRenewalReqAgainst = SessionController().getLanguage() == 1
      ? "Your Renewal Request against Contract "
      : 'طلب التجديد مقابل رقم العقد ';

  String terminateL =
      SessionController().getLanguage() == 1 ? 'terminate' : 'إنهاء';

  String renew = SessionController().getLanguage() == 1 ? 'Renew' : 'تجديد';

  String renewofUnitRef = SessionController().getLanguage() == 1
      ? 'Renewal of unit'
      : 'تجديد الوحدة';

  String extensionReq = SessionController().getLanguage() == 1
      ? 'Extension Request'
      : 'طلب التمديد';

  String renewalReq = SessionController().getLanguage() == 1
      ? 'Renewal Request'
      : 'طلب التجديد';

  String vacateReq =
      SessionController().getLanguage() == 1 ? 'Vacate Request' : 'طلب الإخلاء';

  String legalReq = SessionController().getLanguage() == 1
      ? 'Legal Settlement Request'
      : 'طلب تسوية قانونية';

  String extendcontrat = SessionController().getLanguage() == 1
      ? 'Extend Contracts'
      : 'تمديد العقود';

  String whyTerminate = SessionController().getLanguage() == 1
      ? 'Why do you want to terminate contract?'
      : 'لماذا تريد إنهاء العقد';

  String chooseReason = SessionController().getLanguage() == 1
      ? 'Please select some reason to terminate contract.'
      : 'يرجى تحديد سبب لإنهاء العقد.';

  String terminationDate = SessionController().getLanguage() == 1
      ? 'Termination Date'
      : 'تاريخ الإنهاء';

  String earlyTermination = SessionController().getLanguage() == 1
      ? 'Early Termination'
      : 'الإنهاء المبكر';

  String legalSettlement = SessionController().getLanguage() == 1
      ? 'Legal Settlement'
      : 'تسوية قانونية';

  String legalCases =
      SessionController().getLanguage() == 1 ? 'Legal Cases' : 'قضايا شرعية';
  String openCases =
      SessionController().getLanguage() == 1 ? 'Open Cases' : 'فتح الحالات';
  String openServiceRequests = SessionController().getLanguage() == 1
      ? 'Open Service Requests'
      : 'فتح طلبات الخدمة';
  String closeCases =
      SessionController().getLanguage() == 1 ? 'Close Cases' : 'حالات قريبة';

  String reqLegalSettlement = SessionController().getLanguage() == 1
      ? 'Request Legal Settlement'
      : 'طلب تسوية قانونية';

  String reqLegalSettlementSubmitted = SessionController().getLanguage() == 1
      ? 'Legal Settlement Request Submitted'
      : 'تم تقديم طلب التسوية القانونية';

  String describeLegalSettlement = SessionController().getLanguage() == 1
      ? 'Describe your legal settlement request.'
      : 'صف طلب التسوية القانوني الخاص بك.';

  String extendperiod =
      SessionController().getLanguage() == 1 ? 'Extend Period' : 'تمديد الفترة';

  String slelctextendperiod = SessionController().getLanguage() == 1
      ? 'Select Extend Period'
      : 'حدد تمديد الفترة';

  String renweldatelbl =
      SessionController().getLanguage() == 1 ? 'Renewel Date' : 'تاريخ التجديد';

  String viewDetails =
      SessionController().getLanguage() == 1 ? 'View Details' : 'عرض التفاصيل';

  String yourExtensionAgainst = SessionController().getLanguage() == 1
      ? "Your Extension Request against Contract "
      : 'طلب التمديد الخاص بك مقابل العقد رقم';

  String yourRenewalAgainst =
      SessionController().getLanguage() == 1 ? "Request No. " : 'رقم الطلب.';

  String yourReqNoIsNew1 = SessionController().getLanguage() == 1
      ? ' generated for renewal of Tenancy Contract.'
      : 'تم تلخيصه. يرجى ملاحظة رقم الطلب الخاص بك ';

  String yourReqNoIsNew2 = SessionController().getLanguage() == 1
      ? ' for future reference.'
      : 'للرجوع اليها في المستقبل.';

  String terminationRequest = SessionController().getLanguage() == 1
      ? 'Termination Request'
      : "طلب الإنهاء";

  String yourterminationAgainst = SessionController().getLanguage() == 1
      ? "Your Termination Request against Contract "
      : 'طلب إنهاء العقد الخاص بك رقم ';

  String yourReqNoIs = SessionController().getLanguage() == 1
      ? ' has been summited. Your Request number is '
      : 'تم تقديمها. رقم طلبك هو';

  String yourLegalReq = SessionController().getLanguage() == 1
      ? 'Your Legal Settlement Request against Contract '
      : 'طلب التسوية القانونية الخاص بك ضد العقد رقم';

  String reqScuccesful = SessionController().getLanguage() == 1
      ? 'Request Successful'
      : 'تم الطلب بنجاح';

  String updatesCapital =
      SessionController().getLanguage() == 1 ? 'COMMUNICATION' : 'التواصل';

  String documentsCapital =
      SessionController().getLanguage() == 1 ? 'DOCUMENTS' : 'مستندات';

  String passport =
      SessionController().getLanguage() == 1 ? 'Passport' : 'جواز سفر';

  String sector = SessionController().getLanguage() == 1 ? 'Sector' : 'قطاع';
  String ownerName =
      SessionController().getLanguage() == 1 ? 'Owner Name' : 'اسم المالك';

  String emirateid = SessionController().getLanguage() == 1
      ? 'Emirate ID'
      : 'الهوية الاماراتية';

  String attachChequeCopy = SessionController().getLanguage() == 1
      ? 'Attach Cheque Copy'
      : 'إرفاق نسخة الشيك';

  String attach = SessionController().getLanguage() == 1 ? 'Attach' : 'يربط';

  String pleaseFillTheCheque = SessionController().getLanguage() == 1
      ? 'Please fill your cheque as filled in the image below.'
      : 'يرجى ملء الشيك كما هو مملوء  بالصورة التالية';

  String uploadYourEmirateID = SessionController().getLanguage() == 1
      ? 'Upload Your Emirate ID'
      : 'قم بتحميل بطاقة الهوية الخاصة بك';

  String denied =
      SessionController().getLanguage() == 1 ? 'Denied' : 'تم الحظر';

  String cameraDenied = SessionController().getLanguage() == 1
      ? 'Camera permission denied'
      : 'تم رفض تشغيل الكاميرا ';

  String feedbackAdded = SessionController().getLanguage() == 1
      ? 'Feedback Submitted Successfully'
      : 'تم إرسال الملاحظات بنجاح';

  String filedetails = SessionController().getLanguage() == 1
      ? 'File must not exceed 10MB (JPG, PNG, PDF formats only)'
      : 'يجب ألا يتجاوز الملف 10 ميجابايت (بتنسيقات JPG و PDF,PNG فقط)';

  String filedetailsEID = SessionController().getLanguage() == 1
      ? 'File must not exceed 10MB (JPG, PNG formats only)'
      : 'يجب ألا يتجاوز الملف 10 ميجابايت (بتنسيقات JPG ,PNG  فقط)';

  String fileUploaded = SessionController().getLanguage() == 1
      ? 'File uploaded successfully'
      : 'تم تحميل الملف بنجاح';

  String documentUploaded = SessionController().getLanguage() == 1
      ? 'Documents submitted successfully'
      : 'تم إرسال المستندات بنجاح';

  String generatingContractInfo = SessionController().getLanguage() == 1
      ? 'Generating contract information please wait'
      : 'يتم تحميل بيانات العقد';

  String loading =
      SessionController().getLanguage() == 1 ? 'Loading...' : 'تحميل...';

  String monthly =
      SessionController().getLanguage() == 1 ? "Monthly" : 'شهرياً';

  String rateyourexperiance = SessionController().getLanguage() == 1
      ? 'Rate your experience'
      : 'قيم تجربتك';

  String areyouSatisfied = SessionController().getLanguage() == 1
      ? 'Are you satisfied with the experience ?'
      : 'هل أنت راض عن التجربة';

  String requestDetails = SessionController().getLanguage() == 1
      ? 'Request Details'
      : ' تفاصيل الطلب';

  String requestNotCanncelled = SessionController().getLanguage() == 1
      ? 'Request is not cancelled Successfully'
      : 'لم يتم إلغاء الطلب بنجاح';

  String contactPersonDetails = SessionController().getLanguage() == 1
      ? 'Contact Person Details'
      : 'تفاصيل جهة الاتصال';

  String ack = SessionController().getLanguage() == 1 ? 'Acknowledge' : 'إقرار';

  String notInScope =
      SessionController().getLanguage() == 1 ? 'Not in scope' : 'ليس في نطاق';

  String statusUpdated = SessionController().getLanguage() == 1
      ? 'Status Updated Successfully'
      : 'تم تحديث الحالة بنجاح';

  String contractInfo = SessionController().getLanguage() == 1
      ? 'Contract Info'
      : 'معلومات العقد';

  String succesfullSubmissionRenewalRequest = SessionController()
              .getLanguage() ==
          1
      ? 'You can use the communication tab to get more information after submitting.'
      : 'يمكنك استخدام علامة تبويب الاتصال للحصول على مزيد من المعلومات بعد الإرسال.';

  String collierPersonalDocUploadInfo = SessionController().getLanguage() == 1
      ? 'I understand that I need to share my Emirates ID, passport and any other related documents with Colliers Properties as this is necessary for the renewal of my Tenancy agreement with Colliers Properties.'
      : 'أدرك أنني بحاجة إلى مشاركة بطاقة الهوية الإماراتية وجواز السفر وأي مستندات أخرى ذات صلة مع شركة مينا العقارية لأن ذلك ضروري لتجديد عقد الإيجار الخاص بي مع شركة مينا العقارية.';

  String enterfeedback = SessionController().getLanguage() == 1
      ? "Please Enter feedback"
      : 'يرجى إدخال الملاحظات';

  String agentDetails = SessionController().getLanguage() == 1
      ? "Agent Details"
      : 'تفاصيل الوكيل';

  String selectAgent =
      SessionController().getLanguage() == 1 ? 'Select Agent' : 'حدد الوكيل';

  String searchAgent =
      SessionController().getLanguage() == 1 ? "Search Agent" : 'عامل البحث';

  String searchByKeyWork = SessionController().getLanguage() == 1
      ? "Search by keyword "
      : 'البحث عن طريق الكلمات الرئيسية';

  String agentList =
      SessionController().getLanguage() == 1 ? "Agent List" : 'قائمة الوكيل';

  String maxAmount =
      SessionController().getLanguage() == 1 ? "Max Amount" : 'المبلغ الأقصى';

  String max = SessionController().getLanguage() == 1 ? "Max" : 'الأقصى';

  String searchByKeyword = SessionController().getLanguage() == 1
      ? "Search by Property"
      : 'البحث عن العقارات';

  String citty = SessionController().getLanguage() == 1 ? "City" : 'مدينة';

  String emirate =
      SessionController().getLanguage() == 1 ? "Emirate" : 'الإمارة';

  String searchProperties = SessionController().getLanguage() == 1
      ? "Search Properties"
      : 'البحث عن العقارات';

  String reset =
      SessionController().getLanguage() == 1 ? "Reset " : 'اعادة ضبط البرنامج ';

  String someThingWentWrong = SessionController().getLanguage() == 1
      ? "Some thing went wrong"
      : 'حدث خطأ ما ';

  String requestNotCancelled = SessionController().getLanguage() == 1
      ? "Failure cancelling request"
      : 'لم يتم إلغاء الطلب بنجاح';

  String reqCancelled = SessionController().getLanguage() == 1
      ? 'You cannot communicate when request is closed or cancelled'
      : 'لا يمكنك التواصل عند إغلاق الطلب أو إلغاؤه';

  String requestAddedSuccessfully = SessionController().getLanguage() == 1
      ? "Request Added Successfully"
      : 'تم إضافة الطلب بنجاح';

  String updateProfile =
      SessionController().getLanguage() == 1 ? 'Update Profile' : 'تحديث الملف';
  String updatePublicProfile = SessionController().getLanguage() == 1
      ? 'Update Public Profile'
      : "تحديث الملف الشخصي العام";

  String skip = SessionController().getLanguage() == 1 ? 'Skip' : 'تخطى';

  String updateYourProfile = SessionController().getLanguage() == 1
      ? 'Update Your Profile'
      : 'قم بتحديث ملفك الشخصي';

  String ok = SessionController().getLanguage() == 1 ? 'OK' : 'موافق';

  String minAmount =
      SessionController().getLanguage() == 1 ? "Min Amount" : 'المبلغ الأدنى';

  String min = SessionController().getLanguage() == 1 ? "Min" : 'الأدنى';

  String serviceReqNotUpdated = SessionController().getLanguage() == 1
      ? "Please change some fields to send your request"
      : 'يرجى تغيير بعض الحقول لإرسال طلبك';

  String pleaseWriteMsg = SessionController().getLanguage() == 1
      ? 'Please write a message'
      : 'يرجى كتابة رسالة';

  String send = SessionController().getLanguage() == 1 ? "Send" : 'إرسال';

  String selectCity =
      SessionController().getLanguage() == 1 ? "Select City" : ' حدد المدينة';

  // String selcetEmirate = SessionController().getLanguage() == 1
  //     ? "Select Emirate"
  //     : 'حدّد الإمارة';

  String bookingRequest =
      SessionController().getLanguage() == 1 ? "Booking Request" : 'طلب حجز';

  String beds = SessionController().getLanguage() == 1 ? "Beds" : 'غرف النوم';

  String bath = SessionController().getLanguage() == 1 ? "Bath" : 'حمام';

  String sqFt =
      SessionController().getLanguage() == 1 ? "SQF" : 'المساحة بالقدم المربع';

  String sqMt =
      SessionController().getLanguage() == 1 ? "SQM" : 'المساحة بالمتر المربع';

  String minRent =
      SessionController().getLanguage() == 1 ? "Min. Rent" : 'مِلكِي. ينظف';

  String targetRent =
      SessionController().getLanguage() == 1 ? "Rent" : 'القيمة الايجارية';

  String fullName =
      SessionController().getLanguage() == 1 ? 'Full Name ' : ' الاسم الكامل';
  String fullNameWithStaric =
      SessionController().getLanguage() == 1 ? 'Full Name *' : '*الاسم الكامل';

  String pleaseEnter = SessionController().getLanguage() == 1
      ? 'Please Enter...'
      : 'يرجى إدخال...';

  String pleaseVerify = SessionController().getLanguage() == 1
      ? 'Please Verify'
      : 'الرجاء التحقق من المعلومات الخاصة بك';

  String pleaseEnterName = SessionController().getLanguage() == 1
      ? 'Please enter name'
      : 'يرجى إدخال الاسم';

  String pleaseEnterFullName = SessionController().getLanguage() == 1
      ? 'Please enter full Name'
      : 'الرجاء إدخال الاسم الكامل';

  String pleaseEnterCorrectID = SessionController().getLanguage() == 1
      ? 'Please enter correct ID Number'
      : "الرجاء إدخال رقم التعريف الصحيح";

  String pleaseSelectCorrectExpDate = SessionController().getLanguage() == 1
      ? 'Please select correct Expiry Date'
      : 'يرجى تحديد تاريخ انتهاء الصلاحية الصحيح';

  String pleaseSelectDOB = SessionController().getLanguage() == 1
      ? 'Please select Date of Birth'
      : 'الرجاء تحديد تاريخ الميلاد';

  String pleaseSelectDatesFirst = SessionController().getLanguage() == 1
      ? "Please select From and To dates"
      : "الرجاء تحديد تاريخ من وإلى";

  String pleaseEnterPhoneno = SessionController().getLanguage() == 1
      ? 'Please enter phone number'
      : 'يرجى إدخال رقم الهاتف';

  String pleaseEnterReqtDetails = SessionController().getLanguage() == 1
      ? 'Please enter request details'
      : 'يرجى إدخال تفاصيل الطلب';

  String cellNo = SessionController().getLanguage() == 1
      ? "Call Center No."
      : 'رقم مركز الاتصال';
  // ? "Cell No."
  // : 'رقم الهاتف المحمول';

  String officeTiming =
      SessionController().getLanguage() == 1 ? "Office Timing" : 'ساعات العمل';

  String discoveyGarden = SessionController().getLanguage() == 1
      ? "Discovery Gardens"
      : 'ديسكفري جاردنز';

  String villa = SessionController().getLanguage() == 1 ? "Villa" : 'فيلا';

  String list = SessionController().getLanguage() == 1 ? "List" : 'قائمة';

  String ended = SessionController().getLanguage() == 1 ? "Ended" : 'انتهى';

  String draft = SessionController().getLanguage() == 1 ? "Draft" : 'مسودة';

  String reqtAlreadySubmitted = SessionController().getLanguage() == 1
      ? "Update profile request already submitted. Case No. "
      : 'تم إرسال طلب تحديث الملف الشخصي بالفعل. القضية رقم.';

  String renewelCharges = SessionController().getLanguage() == 1
      ? 'Renewel Charges'
      : 'رسوم التجديد';

  String acceptRenewel = SessionController().getLanguage() == 1
      ? "Accept Renewel"
      : 'أقبل التجديد';

  String openSR = SessionController().getLanguage() == 1
      ? "Open Service Request"
      : 'افتح طلب الخدمة ';

  String openContract =
      SessionController().getLanguage() == 1 ? "Open Contract" : 'افتح العقد';

  String close = SessionController().getLanguage() == 1 ? "Close" : 'اغلاق';

  String clickHere =
      SessionController().getLanguage() == 1 ? 'Click Here' : 'انقر هنا';

  String chequeSample = SessionController().getLanguage() == 1
      ? 'Cheque Sample '
      : 'مثال على الشيك';

  String renewalFlow = SessionController().getLanguage() == 1
      ? 'Contract Renewal Tutorial'
      : 'برنامج تعليمي لتجديد العقد';
  String renewalFlowText =
      SessionController().getLanguage() == 1 ? 'Renewal Flow' : 'تجديد التدفق';

  String play = SessionController().getLanguage() == 1 ? 'Play' : 'يلعب';

  String pleaseSelectRenewalFlow = SessionController().getLanguage() == 1
      ? 'Please select tutorial'
      : 'الرجاء تحديد البرنامج التعليمي';

  String renewalFlowMore = SessionController().getLanguage() == 1
      ? 'Contract renewal tutorial'
      : 'برنامج تعليمي لتجديد العقد';
  String renewalFlowTutorial = SessionController().getLanguage() == 1
      ? 'Contract Tutorials'
      : 'دروس العقد';
  String renewalFlowTutorialUrl = SessionController().getLanguage() == 1
      ? 'Contract Renewal Process For Dubai & NE'
      : "عملية تجديد العقد في دبي والشمال الشرقي";

  String back = SessionController().getLanguage() == 1 ? "Back" : 'رجوع';

  String declineRenewel = SessionController().getLanguage() == 1
      ? "Decline Renewel"
      : 'رفض التجديد';

  String submitted =
      SessionController().getLanguage() == 1 ? 'Submitted' : 'مُقَدَّم';

  String caseNo =
      SessionController().getLanguage() == 1 ? ' Case No. ' : 'رقم الطلب';

  String inoviceNumber = SessionController().getLanguage() == 1
      ? "Invoice Number"
      : 'رقم الفاتورة';

  String inoviceNo =
      SessionController().getLanguage() == 1 ? "Invoice No" : 'رقم الفاتورة';

  String pleaseSelectExpiryDate = SessionController().getLanguage() == 1
      ? "Please select expiry date"
      : 'الرجاء تحديد تاريخ انتهاء الصلاحية';

  String pleaseScaneFrontSideOfEID = SessionController().getLanguage() == 1
      ? "Please scan FRONT & BACK side of your's Emirate ID SEPARATELY as shown below"
      : 'يرجى إجراء مسح ضوئي للجانبين الأمامي والخلفي من الهوية الاماراتية  بشكل منفصل كما هو موضح أدناه';

  String pleaseScaneFrontSideOfEIDAgain = SessionController().getLanguage() == 1
      ? "Please scan FRONT & BACK side of your's Emirate ID again "
      : 'يرجى مسح الوجه الأمامي والخلفي لبطاقة الهوية الخاصة بك بشكل صحيح';

  String areYouSureCloseAPP = SessionController().getLanguage() == 1
      ? "Are you sure,\nyou want to exit the App?"
      : 'هل أنت متأكد؟ \n تريد الخروج من التطبيق؟';

  String pleaseScanebackSideOfEID = SessionController().getLanguage() == 1
      ? "Please scanne back side of your's Emirate ID as shown"
      : 'يرجى مسح الجانب الخلفي من معرف الإمارة الخاص بك كما هو موضح';

  String reScane =
      SessionController().getLanguage() == 1 ? "Rescan" : 'إعادة المسح';

  ///////////////////////Landlords////////////////////
  ///
  ///
  ///
  ///

  String issueDateLand =
      SessionController().getLanguage() == 1 ? "Issue Date" : 'تاريخ الإصدار';

  String startDateLand =
      SessionController().getLanguage() == 1 ? "Start Date" : 'تاريخ البدء ';

  String endDateLand =
      SessionController().getLanguage() == 1 ? "End Date" : 'تاريخ الانتهاء';

  String propertyNameLand =
      SessionController().getLanguage() == 1 ? "Property Name" : 'اسم العقار';

  String yourContractsLand =
      SessionController().getLanguage() == 1 ? "Your Contracts" : 'عقودك';

  String propertiessLand =
      SessionController().getLanguage() == 1 ? "Properties" : 'العقارات';

  String unitRefLand =
      SessionController().getLanguage() == 1 ? "Unit Ref" : 'مرجع الوحدة';

  String unitTypeLand =
      SessionController().getLanguage() == 1 ? "Unit Type" : 'نوع الوحدة';

  String aedLand =
      SessionController().getLanguage() == 1 ? "AED" : 'درهم إماراتي';

  String viewAllPropertiesLand = SessionController().getLanguage() == 1
      ? "VIEW ALL PROPERTIES"
      : 'عرض كل العقارات';

  String reportsLand =
      SessionController().getLanguage() == 1 ? "Reports" : 'التقارير';

  String landLord =
      SessionController().getLanguage() == 1 ? "LandLord" : 'المالك';

  String reportsTitleLand =
      SessionController().getLanguage() == 1 ? "Report Title" : 'عنوان التقرير';

  String reportDetailsLand = SessionController().getLanguage() == 1
      ? "Report Details"
      : 'تفاصيل التقرير';

  String serviceTypeLand =
      SessionController().getLanguage() == 1 ? "Service Type" : 'نوع الخدمة';

  String workCompletionDate = SessionController().getLanguage() == 1
      ? "Work Completion Date"
      : 'تاريخ إتمام العمل';

  String propertyLand =
      SessionController().getLanguage() == 1 ? "Property" : 'العقار';

  String locationLand =
      SessionController().getLanguage() == 1 ? 'Location' : 'الموقع';

  String prefferdDateAndTime = SessionController().getLanguage() == 1
      ? "Prefferd date and time"
      : 'التاريخ والوقت المفضلان';

  String generateReportLand = SessionController().getLanguage() == 1
      ? "Generate Report"
      : 'انشاء تقرير';

  String contractLengthLand =
      SessionController().getLanguage() == 1 ? "Contract Length" : 'مدة العقد';

  String addressLand =
      SessionController().getLanguage() == 1 ? 'Address' : 'العنوان';

  String contractNoLand =
      SessionController().getLanguage() == 1 ? 'Contract No.' : 'رقم العقد';

  String monthsLand =
      SessionController().getLanguage() == 1 ? 'months' : 'الشهور';

  String bedsLand = SessionController().getLanguage() == 1 ? "Beds" : 'أسِرَّة';

  String bathLand = SessionController().getLanguage() == 1 ? "Bath" : 'حمام';

  String sqftLand =
      SessionController().getLanguage() == 1 ? "Sq Ft" : 'قدم مربع';

  String amountLand =
      SessionController().getLanguage() == 1 ? 'amount' : 'مبلغ';

  String propertyDetailsLand = SessionController().getLanguage() == 1
      ? "Property Details"
      : 'تفاصيل العقارات';

  String listedPriceLand =
      SessionController().getLanguage() == 1 ? "Listed Price" : 'السعر المدرج';

  String propertyInfoLand = SessionController().getLanguage() == 1
      ? "Property Info"
      : 'معلومات العقار';

  String propertyInfoCapLand = SessionController().getLanguage() == 1
      ? "PROPERTY INFO"
      : 'معلومات الملكية';

  String unitCatgLand =
      SessionController().getLanguage() == 1 ? "Unit Category" : 'فئة الوحدة';

  String bedRoomsLand =
      SessionController().getLanguage() == 1 ? "Bed Rooms" : 'غرف نوم';

  String washRoomsLand =
      SessionController().getLanguage() == 1 ? "Washrooms" : 'حمام';

  String balconiesLand =
      SessionController().getLanguage() == 1 ? "Balconies" : 'شرفات';

  String livingRoomsLand =
      SessionController().getLanguage() == 1 ? "Living Rooms" : 'غرف المعيشة';

  String maidRoomsLand =
      SessionController().getLanguage() == 1 ? "Maid Rooms" : 'غرف الخادمة';

  String kitchenLand =
      SessionController().getLanguage() == 1 ? "Kitchens" : 'مطابخ';

  String selectTypeLand =
      SessionController().getLanguage() == 1 ? "Select Type" : 'حدّد الصنف';

  String year = SessionController().getLanguage() == 1 ? 'year' : 'سنة';

  String discoverVirtualApartment = SessionController().getLanguage() == 1
      ? 'Discover the Virtual Apartment Tour'
      : 'اكتشف الدورة الافتراضية للوحدة';

  //----------------------------New Labels --------------------------//

  String deviceBlocked = SessionController().getLanguage() == 1
      ? 'Device is blocked please wait'
      : "الجهاز محجوب الرجاء الانتظار";

  String seconds = SessionController().getLanguage() == 1 ? 'Seconds' : 'ثواني';

  String verifying =
      SessionController().getLanguage() == 1 ? "Verifying" : "جاري التحقق";

  String pleaseUseFingerprint = SessionController().getLanguage() == 1
      ? 'Please use fingerprint to login'
      : "الرجاء استخدام بصمة الإصبع لتسجيل الدخول";

  String fingerPrintNotset = SessionController().getLanguage() == 1
      ? 'Finger print is not set'
      : "لم يتم تعيين بصمة الإصبع";

  String easyMpin = SessionController().getLanguage() == 1
      ? 'Too Easy Mpin'
      : " رقم التعريف الشخصي سهل للغاية";

  String noMoreData = SessionController().getLanguage() == 1
      ? 'No More Data'
      : "لا مزيد من البيانات";

  String loadMoreData =
      SessionController().getLanguage() == 1 ? 'Load More' : "تحميل المزيد";

  String validatingUser = SessionController().getLanguage() == 1
      ? 'Validating User'
      : "التحقق من صحة المستخدم";

  String noService =
      SessionController().getLanguage() == 1 ? 'No Service' : "لا توجد خدمة";

  String rootedDevice =
      SessionController().getLanguage() == 1 ? 'Rooted Device' : "جهاز متجذر";

  String connectionNotSecure = SessionController().getLanguage() == 1
      ? 'Connection Not Secure'
      : "الاتصال غير آمن";

  String noPayments = SessionController().getLanguage() == 1
      ? 'No Payments'
      : "لا توجد مدفوعات";

  String showReceipts = SessionController().getLanguage() == 1
      ? 'Show Receipts'
      : "إظهار الإيصالات";

  String storagePermissions = SessionController().getLanguage() == 1
      ? 'Storage permissions not granted'
      : "لم يتم منح أذونات التخزين";

  String iAgree = SessionController().getLanguage() == 1
      ? 'I Agree to the'
      : "أنا أوافق على";

  String termsConditions = SessionController().getLanguage() == 1
      ? 'Terms & Conditions'
      : "الشروط والأحكام";

  String refundPolicy = SessionController().getLanguage() == 1
      ? 'Refund/Return Policy'
      : "سياسة الاسترداد / الإرجاع";

  String acceptTermsConditions = SessionController().getLanguage() == 1
      ? 'Accept Terms and Conditions.'
      : "أوافق على الشروط و الأحكام";

  String yourSignature = SessionController().getLanguage() == 1
      ? 'Please Draw your signature.'
      : 'من فضلك ارسم توقيعك';

  String drawyourSignature = SessionController().getLanguage() == 1
      ? 'Draw your signature.'
      : 'ضع توقيعك';

  String signatureSuccessfullu = SessionController().getLanguage() == 1
      ? 'Signature saved successfully.'
      : 'تم حفظ التوقيع بنجاح.';

  String signatureSaved = SessionController().getLanguage() == 1
      ? 'Successfully signed'
      : 'تم التوقيع بنجاح';

  String signatureSavedTenant = SessionController().getLanguage() == 1
      ? 'Successfully signed'
      : 'تم التوقيع بنجاح';

  String signatureSavedTenantEIDOne = SessionController().getLanguage() == 1
      ? 'Contract signed successfully, however please note that your contract will be generated after completion of Tawtheeq Process.'
      : 'تم توقيع العقد بنجاح، وللعلم سيتم انشاء العقد بعد الانتهاء من توثيقه';
  // : 'تم توقيع العقد بنجاح، ووللعلم سيتم انشاء العقد بعد الانتهاء من توثيقة';
  // : 'تم توقيع العقد بنجاح ، ولكن يرجى للعلم أنه سيتم إنشاء عقدك بعد الانتهاء من عملية توثيق';

  String noFileReceived = SessionController().getLanguage() == 1
      ? "No file received"
      : "لم يتم تلقي أي ملف";

  String files = SessionController().getLanguage() == 1 ? "Files" : "الملفات";

  String invoiceNumber = SessionController().getLanguage() == 1
      ? "Invoice Number"
      : 'رقم الفاتورة';

  String reqDate =
      SessionController().getLanguage() == 1 ? "Request Date" : "تاريخ الطلب";
  String received =
      SessionController().getLanguage() == 1 ? 'Received' : 'تلقى';
  String balance =
      SessionController().getLanguage() == 1 ? 'Balance' : "الرصيد";

  String searchCategory =
      SessionController().getLanguage() == 1 ? "Search Category" : "بحث";

  String pleaseAdd = SessionController().getLanguage() == 1
      ? 'Please add some message'
      : "الرجاء إضافة رسالة";

  String photoLibrary =
      SessionController().getLanguage() == 1 ? 'Photo Library' : "مكتبة الصور";

  String storage =
      SessionController().getLanguage() == 1 ? 'Storage' : "مكتبة التخزين";

  String camera =
      SessionController().getLanguage() == 1 ? 'Camera' : "آلة تصوير";

  String wantremovephoto = SessionController().getLanguage() == 1
      ? 'Do you want to remove photo?'
      : "هل تريد إزالة الصورة؟";

  String remove = SessionController().getLanguage() == 1 ? 'Remove' : "إزالة";

  String searchLocation = SessionController().getLanguage() == 1
      ? 'Search Location'
      : "البحث في الموقع";

  String contactDetails = SessionController().getLanguage() == 1
      ? 'Contact Details'
      : "تفاصيل الاتصال";

  String otherthantenant = SessionController().getLanguage() == 1
      ? 'Other than tenant'
      : "بخلاف المستأجر";

  String createNewServiceRequest = SessionController().getLanguage() == 1
      ? 'Create new service request'
      : "إنشاء طلب خدمة جديد";

  String vacatingReason = SessionController().getLanguage() == 1
      ? 'Vacating Reason: '
      : "سبب الإخلاء";

  String vacatingDate = SessionController().getLanguage() == 1
      ? 'Vacating Date: '
      : "تاريخ الإخلاء";

  String photos = SessionController().getLanguage() == 1 ? 'Photos' : "صور";

  String reqClosed =
      SessionController().getLanguage() == 1 ? 'Request Closed' : "الطلب مغلق";

  String closeReq =
      SessionController().getLanguage() == 1 ? 'Close Request' : "طلب إغلاق";
  String closeReqs = SessionController().getLanguage() == 1
      ? 'Close Requests'
      : "إغلاق الطلبات";
  String openReqs =
      SessionController().getLanguage() == 1 ? 'Open Requests' : "طلب يفتح";

  String targetRent1 = SessionController().getLanguage() == 1
      ? 'Target Rent'
      : "الإيجار المستهدف";

  String saveSignature = SessionController().getLanguage() == 1
      ? 'Save Signature'
      : "احفظ التوقيع";

  String takeTenantSignature = SessionController().getLanguage() == 1
      ? 'Take Tenant Signature'
      : "خذ توقيع المستأجر";

  String outstandingPayment = SessionController().getLanguage() == 1
      ? 'Outstanding Payments'
      : "المبالغ المستحقة";

  String loginAsTenant = SessionController().getLanguage() == 1
      ? 'Please login as tenant'
      : 'الرجاء تسجيل الدخول كمستأجر';

  String loginAsVendor = SessionController().getLanguage() == 1
      ? 'Please login as vendor'
      : 'الرجاء تسجيل الدخول كمقاول';

  String loginAsLandlord = SessionController().getLanguage() == 1
      ? 'Please login as landlord'
      : 'الرجاء تسجيل الدخول كمالك';

  String loginAsPublic = SessionController().getLanguage() == 1
      ? 'Please login as search properties'
      : 'الرجاء تسجيل الدخول العقارات';

  String noPendingPaymentFound = SessionController().getLanguage() == 1
      ? 'No pending payments were found against this contract'
      : 'لا توجد اى دفعات لهذا العقد ';

  String noPendingPF = SessionController().getLanguage() == 1
      ? 'No pending payments were found.'
      : 'لم يتم العثور على المدفوعات المعلقة.';

  String viewContract =
      SessionController().getLanguage() == 1 ? 'View Contract' : "عرض العقد";

  String authenticationfailed = SessionController().getLanguage() == 1
      ? 'Authentication Failed'
      : "المصادقة فشلت";

  String biometric =
      SessionController().getLanguage() == 1 ? 'Biometric' : "البصمة";

  ///////////////////////////////
  /// Due Action Contract
  ///////////////////////////////

  String stage1 = SessionController().getLanguage() == 1
      ? '-For annual contract renewal, press “Renew”'
      : '"لتجديد العقد السنوي ، اضغط على "تجديد ';

  // String stage1 = SessionController().getLanguage() == 1
  //     ? '-For annual contract renewal, press “Renew”\n-For short term renewal, press “Extend”'
  //     : '- لتجديد العقد السنوي ، اضغط على "تجديد" \n - للتجديد قصير المدى ، اضغط على "تمديد"';

  String stage2 = SessionController().getLanguage() == 1
      ? 'Please upload the required documents to proceed with your Renewal Request.'
      : 'يرجى تحميل المستندات المطلوبة لمتابعة طلب التجديد الخاص بك.';

  String collierStage3 = SessionController().getLanguage() == 1
      ? 'The documents have been successfully submitted. You will be notified within 2 working days once the verification is completed by the Colliers Properties team.'
      : 'تم تقديم المستندات بنجاح. سيتم إخطارك خلال يومي عمل بمجرد اكتمال عملية التحقق من قبل فريق عقارات الشرق الأوسط وشمال إفريقيا';

  String collierStage4 = SessionController().getLanguage() == 1
      ? 'Your documents have been approved by Colliers Properties and the renewal process has been initiated. You can expect the details of the new contract to be shared within 1 to 2 working days.'
      : 'تمت الموافقة على مستنداتك من قبل شركة مينا العقارية وبدأت عملية التجديد. يمكنك أن تتوقع مشاركة تفاصيل العقد الجديد خلال يوم أو يومين عمل.';

  String collierStage5 = SessionController().getLanguage() == 1
      ? 'The first rental installment and all other charges must be paid through “Online”.\n\nThe remaining rental installments can be paid by cheques (made out to "Colliers Properties") which can be submitted through the Aramex service (at no additional cost) initiated by Colliers Properties.'
      : "يجب دفع القسط الإيجاري الأول وجميع الرسوم الأخرى من خلال \"أون لاين\".\n\nيمكن دفع أقساط الإيجار المتبقية عن طريق الشيكات (المحررة لصالح \"شركة مينا العقارية\") والتي يمكن تقديمها من خلال خدمة أرامكس (بدون أي رسوم إضافية). التكلفة) بمبادرة من شركة مينا العقارية.";

  String collierStage5_1 = SessionController().getLanguage() == 1
      // ? 'Once online payment is acknowledged and physical cheque copies are received (if any), you will be notified to “sign tenancy contract.'
      ? 'Thanks for making the Payment. Once online payment is acknowledged or physical cheque copies are received, you will be notified to “Sign Tenancy Contract".'
      : ' شكرًا على إجراء الدفع. بمجرد إقرار الدفع عبر الإنترنت أو استلام نسخ الشيكات الفعلية ، سيتم إخطارك بـ "توقيع عقد الإيجار';

  String collierStage5_12 = SessionController().getLanguage() == 1
      ? 'Payment completed.\nOnce online payment is acknowledged or physical cheque copies are received, you will be notified to “Sign Tenancy Contract".'
      : ' اكتمل الدفع. \n بمجرد الإقرار بالدفع عبر الإنترنت أو استلام نسخ الشيك الفعلي ، سيتم إخطارك بـ "توقيع عقد الإيجار';

  String stage6 = SessionController().getLanguage() == 1
      ? 'Your tenancy contract is available to sign.'
      : 'عقد الإيجار الخاص بك متاح للتوقيع.';
  // String stage6 = SessionController().getLanguage() == 1
  //     ? 'Your tenancy contract is generated, please proceed to sign.'
  //     : 'تم إنشاء عقد الإيجار الخاص بك ، يرجى المتابعة للتوقيع.';

  String stage7 = SessionController().getLanguage() == 1
      ? 'Your signed contract is under review with our team. We will notify you of the next step within 1 to 2 working days.'
      : 'عقدك الموقع قيد المراجعة مع فريقنا. سنخطرك بالخطوة التالية في غضون يوم إلى يومين عمل';

  String stage8 = SessionController().getLanguage() == 1
      ? 'Your contract require municipality processing from your side, please click on the link on the municipality tab to complete the required process and confirm.'
      : 'يتطلب عقدك معالجة البلدية من جانبك ، يرجى النقر على الرابط في علامة التبويب البلدية لإكمال العملية المطلوبة والتأكيد.';

  String stage8_1 = SessionController().getLanguage() == 1
      ? 'Please click on the Login To Tawtheeq link to complete the municipality process.'
      : 'الرجاء الضغط على رابط تسجيل الدخول إلى توثيق لإتمام إجراءات البلدية.';

  String collierStage9 = SessionController().getLanguage() == 1
      ? 'Dear Tenant, Thanks for choosing Colliers Properties as your real estate service provider, your contract will be ready to download within 1 to 2 working days.'
      : 'عزيزي المستأجر، شكرًا لاختيارك شركة مينا العقارية كمزود للخدمات العقارية، سيكون عقدك جاهزًا للتنزيل خلال يوم إلى يومي عمل.';
}
