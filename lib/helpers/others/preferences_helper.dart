import 'package:makhosi_app/enums/click_type.dart';
import 'package:makhosi_app/utils/app_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  Future<void> setUserType(ClickType userType) async {
    String userStringType;
    switch (userType) {
      case ClickType.PATIENT:
        userStringType = AppKeys.PATIENT;
        break;
      case ClickType.PRACTITIONER:
        userStringType = AppKeys.PRACTITIONER;
        break;
    }
    var pref = await SharedPreferences.getInstance();
    await pref.setString(AppKeys.USER_TYPE, userStringType);
    await pref.commit();
  }

  Future<void> setLanguage(String language) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setString(AppKeys.APP_LANGUAGE, language);
  }

  Future<void> setCountry(String country) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setString(AppKeys.APP_COUNTRY, country);
  }

  Future<String> getLanguage() async {
    return (await SharedPreferences.getInstance())
            .getString(AppKeys.APP_LANGUAGE) ??
        '';
  }

  Future<String> getCountry() async {
    return (await SharedPreferences.getInstance())
            .getString(AppKeys.APP_COUNTRY) ??
        '';
  }

  Future<String> getUserType() async {
    return (await SharedPreferences.getInstance())
            .getString(AppKeys.USER_TYPE) ??
        'null';
  }
}
