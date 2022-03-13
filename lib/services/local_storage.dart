import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_eaters/services/preferences_keys.dart';

class LocalStorage {
  SharedPreferences? _preferences;
  static final LocalStorage _instance = LocalStorage._init();
  static LocalStorage get instance {
    return _instance;
  }

  LocalStorage._init();

  factory LocalStorage() {
    return _instance;
  }

  static preferencesInit() async {
    _instance._preferences ??= await SharedPreferences.getInstance();
    return;
  }

  Future<void> setStringValue(PreferencesKeys key, String value) async {
    await _instance._preferences!.setString(key.toString(), value);
  }

  String? getStringValue(PreferencesKeys key) =>
      _instance._preferences!.getString(key.toString());

  bool getBoolValue(String key) =>
      _instance._preferences!.getBool(key) ?? false;

  Future<void> removeKey(PreferencesKeys key) async {
    var res = await _instance._preferences!.remove(key.toString());
    print(res);
  }
}
