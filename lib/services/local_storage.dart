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

  Future<void> addToStringList(PreferencesKeys key, String value) async {
    var list = _instance._preferences!.getStringList(key.name);
    if (list == null) {
      List<String> newList = [];
      newList.add(value);
      _instance._preferences!.setStringList(key.name, newList);
    } else {
      list.add(value);
      _instance._preferences!.setStringList(key.name, list);
    }
  }

  List<String> getStringList(PreferencesKeys key) {
    List<String> list = [];
    List<String>? storageList = _instance._preferences!.getStringList(key.name);
    if (storageList != null) {
      list = storageList;
    }
    return list;
  }

  String? getStringValue(PreferencesKeys key) =>
      _instance._preferences!.getString(key.name);

  bool getBoolValue(String key) =>
      _instance._preferences!.getBool(key) ?? false;

  Future<void> removeKey(PreferencesKeys key) async {
    preferencesInit();
    await _instance._preferences!.remove(key.name);
  }
}
