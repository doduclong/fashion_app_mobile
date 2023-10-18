import 'package:get/get.dart';

import 'trans/en_us.dart';
import 'trans/vi_vn.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en_US': en, 'vi_VN': vi};

  // common
  static String get errorSever => 'errorSever'.tr;

  static String get cancel => "cancel".tr;

  static String get language => "language".tr;

  static String get accountActivated => "accountActivated".tr;

  static String get accountInactived => "accountInactived".tr;

  static String get all => "all".tr;

  static String get choose => "choose".tr;

  static String get filter => "filter".tr;

  static String get keyWord => "keyWord".tr;

  static String get exit => "exit".tr;

  static String get connectFailed => 'connectFailed'.tr;

  static String get male => "male".tr;

  static String get female => 'female'.tr;

  static String get other => 'other'.tr;

  static String get retry => 'retry'.tr;

  static String get noMoreData => 'noMoreData'.tr;

  static String get birthday => 'birthday'.tr;

  static String get camera => 'camera'.tr;

  static String get faceData => 'faceData'.tr;

  static String processSuccess(String label) => "processSuccess".trParams({
    'label': label,
  });

  static String processFail(String label, String errorMessage) =>
      "processFail".trParams({'label': label, 'errorMessage': errorMessage});

  ///login
  static String get pass => "pass".tr;

  static String get rememberPassword => "rememberPassword".tr;

  static String get login => "login".tr;

  static String get fulfil => 'fulfil'.tr;

  static String get password => 'password'.tr;

  static String get notEmail => 'notEmail'.tr;

  static String get companyCode => 'companyCode'.tr;

  static String get incorrectFormat2 => "incorrectFormat2".tr;

  static String get emailNotBlank => "emailNotBlank".tr;

  static String get passwordNotBlank => "passwordNotBlank".tr;

  static String get companyCodeNotBlank => "companyCodeNotBlank".tr;

  static String get logout => "logout".tr;

  static String get privacyPolicy => "privacyPolicy".tr;

  // url input dialog
  static String get ok => "ok".tr;

  static String get notBlank => "notBlank".tr;

  static String incorrectFormat(String label) => "incorrectFormat".trParams({
    'label': label,
  });

  // Employee Filter
  static String get companyName => "companyName".tr;

  static String get filterBCompany => 'filterBCompany'.tr;

  static String get untapableMessage1 => 'untapableMessage1'.tr;

  static String get filterBDepartment => 'filterBDepartment'.tr;

  static String get departmentName => 'departmentName'.tr;

  static String get accountStatus => 'accountStatus'.tr;

  // Face Images
  static String get getFaceData => 'getFaceData'.tr;

  static String get cameraPermission => 'cameraPermission'.tr;

  // QR code Scanner
  static String get qrCodeScanner => "qrCodeScanner".tr;

  static String get qrCodeGuide => "qrCodeGuide".tr;

  static String get scanQrCodeWithCamera => "scanQrCodeWithCamera".tr;

  static String get chooseQrImage => "chooseQrImage".tr;

  static String get enterCompanyCode => "enterCompanyCode".tr;

  static String get qrCodeCancel => "qrCodeCancel".tr;

  // face image input
  static String get moveDeviceUp => "moveDeviceUp".tr;

  static String get moveDeviceDown => "moveDeviceDown".tr;

  static String get moveDeviceLeft => "moveDeviceLeft".tr;

  static String get moveDeviceRight => "moveDeviceRight".tr;

  static String get turnLeft => "turnLeft".tr;

  static String get turnRight => "turnRight".tr;

  static String get raiseHead => "raiseHead".tr;

  static String get lowerHead => "lowerHead".tr;

  static String get wholeFaceInFrame => "wholeFaceInFrame".tr;

  static String get captured => "captured".tr;

  static String get takeAllPictures => "takeAllPictures".tr;

  // add edit user
  static String get addFaceData => "addFaceData".tr;

  static String get gender => "gender".tr;

  static String get notSelectCompanyYet => "notSelectCompanyYet".tr;

  static String get department => "department".tr;

  static String get company => "company".tr;

  static String get basicInfor => "basicInfor".tr;

  static String get fullName => "fullName".tr;

  static String get email => "email".tr;

  static String get phoneNumber => "phoneNumber".tr;

  static String get avatar => "avatar".tr;

  static String get findCompany => "findCompany".tr;

  static String get findDepartment => "findDepartment".tr;

  static String get update => "update".tr;

  static String get create => "create".tr;

  static String get library => "library".tr;

  static String get updateProfile => "updateProfile".tr;

  static String get addAccount => "addAccount".tr;

  // Preview Face Images
  static String get recaptureThisPhoto => "recaptureThisPhoto".tr;

  // Employee Profile
  static String get profile => "profile".tr;

  static String get resetPassword => "resetPassword".tr;

  static String get lockAccount => "lockAccount".tr;

  static String get unlockAccount => "unlockAccount".tr;

  // Change Password
  static String get changePassword => "changePassword".tr;

  static String get enterCurrentPassword => "enterCurrentPassword".tr;

  static String get minPassLength => "minPassLength".tr;

  static String get enterNewPassword => "enterNewPassword".tr;

  static String get repeatNewPassword => "repeatNewPassword".tr;

  static String get passwordsDoNotMatch => "passwordsDoNotMatch".tr;

  static String get employee => "employee".tr;

  static String get personal => "personal".tr;

  // Id Card Info
  static String get personalInfor => "personalInfor".tr;

  static String get cardNo => "cardNo".tr;

  static String get placeOfResidence => "placeOfResidence".tr;

  static String get placeOfOrigin => "placeOfOrigin".tr;

  static String get autoFill => "autoFill".tr;

  // Id Card Preview
  static String get reCapture => "reCapture".tr;

  static String get front => "front".tr;

  static String get idCard => "idCard".tr;

  static String get continue1 => "continue".tr;

// Id Card Scanner
  static String get cardPhotographyGuide => "cardPhotographyGuide".tr;

  static String get instructionsDuringShooting => "instructionsDuringShooting".tr;

  static String get invalid => "Invalid".tr;

  static String get crop => "Crop".tr;

  static String get pose => "Pose".tr;

  static String get small => "Small".tr;

  static String get blur => "Blur".tr;

  static String get occlusion => "Occlusion".tr;

  static String get mask => "Mask".tr;

  static String get same => "Same".tr;

  static String get exist => "Exist".tr;

  static String get bright => "Brightness".tr;

  static String get error => "error".tr;

  static String get reviewTheErrorPhotos => "reviewTheErrorPhotos".tr;

  static String get holdCamera => "holdCamera".tr;

  static String get takeAway => "takeAway".tr;

  static String get bringCloser => "bringCloser".tr;

  static String get reSend => "reSend".tr;

  static String get nfcIconTooltip => 'nfcIconTooltip'.tr;

  static String get nfcTutorialAccess => 'nfcTutorialAccess'.tr;

  static String get nfcTutorial => 'nfcTutorial'.tr;

  static String get nfcAccessStatus => 'nfcAccessStatus'.tr;

  static String get nfcReadDataStatus => 'nfcReadDataStatus'.tr;

  static String get nfcReadPhotoStatus => 'nfcReadPhotoStatus'.tr;

  static String get nfcVerificationStatus => 'nfcVerificationStatus'.tr;

  static String get nfcCheckFeatureStatus => 'nfcCheckFeatureStatus'.tr;

  static String get nfcSuccessStatus => 'nfcSuccessStatus'.tr;

  static String get nfcAvailable => 'nfcAvailable'.tr;

  static String get nfcEnable => 'nfcEnable'.tr;

  static String get nfcEnableDes => 'nfcEnableDes'.tr;

  static String get mrzInvalid => 'mrzInvalid'.tr;

  static String get connectCardError => 'connectCardError'.tr;

  static String get verifyChipError => 'verifyChipError'.tr;

  static String get readChipDataError => 'readChipDataError'.tr;

  static String get verifyDataError => 'verifyDataError'.tr;

  static String get accessChipError => 'accessChipError'.tr;

  static String get responseFromChipError => 'responseFromChipError'.tr;

  static String get passAccessChipError => 'passAccessChipError'.tr;
}
