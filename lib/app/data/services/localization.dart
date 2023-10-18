import 'dart:collection';
import 'dart:ui';
import 'package:get/get.dart';

import '../../../core/utils/keys.dart';
import '../enum/language.dart';
import 'local_storage_get.dart';

class LocalizationService extends GetxService {
  static LocalizationService get to => Get.find();

  static final localStorage = LocalStorage.get;

  static const fallbackLocale = Locale('en', 'US');

  static final langCodes = ['en', 'vi'];

  static final locales = [
    const Locale('en', 'US'),
    const Locale('vi', 'VN'),
  ];

  static final langs = LinkedHashMap.from({'en': 'English', 'vi': 'Tiếng Việt'});

  static Locale getLocaleFromLanguage({String? langCode}) {
    var lang = langCode ?? localStorage.read(LocalStorageKeys.LANG_CODE) as String? ?? Get.deviceLocale?.languageCode;

    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }

    return Get.locale ?? fallbackLocale;
  }

  static Language getCurrentAppLanguage() {
    var lang = localStorage.read(LocalStorageKeys.LANG_CODE) as String? ?? Get.deviceLocale?.languageCode;

    switch (lang) {
      case "en":
        return Language.English;
      case "vi":
        return Language.Vietnamese;
      default:
        return Language.Vietnamese;
    }
  }

  final locale = getLocaleFromLanguage().obs;

  setLang(Language lang) {
    changeLocale(lang.code);
  }

  void changeLocale(String langCode) {
    locale.value = getLocaleFromLanguage(langCode: langCode);
    localStorage.write(LocalStorageKeys.LANG_CODE, locale.value.languageCode);
    Get.updateLocale(locale.value);
  }

  @override
  void onInit() {
    super.onInit();
  }
}
