import 'package:flutter/foundation.dart';
import 'package:google_place/src/search/search_result.dart';
import 'package:sellthedwell/models/login_response.dart';
import 'package:sellthedwell/models/property_model.dart';
import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  int navBarIndex = 0;
  bool showMapInExplore = false;
  String appBarTitle = Strings.appName;
  double selectedLat = 0;
  double selectedLong = 0;
  String selectedCategory = "All";

  final List<PropertyModel> allProperties = [];

  UserLoginResponse? _loginResponse;
  UserLoginResponse? get loginResponse => _loginResponse;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  String _token = "";
  String get getToken => _token;

  Future<void> logout() async {
    //setNavBarIndex(0);
    _isLoggedIn = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Konstants.keyEmail, "");
    await prefs.setString(Konstants.keyPassword, "");
    await prefs.setString(Konstants.keyToken, "");
    notifyListeners();
  }

  void setLoginResponse(result) {
    if (result != null) {
      try {
        _token = result['token'];
        _loginResponse = UserLoginResponse.fromJson(result['user_data']);
      } catch (e) {
        throw Exception("Error in parsing user login information");
      }
      notifyListeners();
    }
  }

  Future<void> saveLocalLogin({
    required String email,
    required String password,
    required String token,
    required String id,
    required String package_name,
    required String name
  }) async {
    print("Package name" + package_name);
    setNavBarIndex(0);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Konstants.keyEmail, email);
    await prefs.setString(Konstants.keyPassword, password);
    await prefs.setString(Konstants.keyToken, token);
    await prefs.setString(Konstants.uId, id);
    await prefs.setString("name", name);
    await prefs.setString("package_name", package_name);
  }

  Future<void> saveToRecentLocationName({
    required String location,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> locHist =
        prefs.getStringList(Konstants.locationHistory) ?? [];
    locHist.insert(0, location);
    await prefs.setStringList(Konstants.locationHistory, locHist);
  }

  void setNavBarIndex(int itemIndex) {
    navBarIndex = itemIndex;
    notifyListeners();
  }

  void setShowMapInExplore(bool value) {
    showMapInExplore = value;
    notifyListeners();
  }

  void setTitle(String title) {
    appBarTitle = title;
    notifyListeners();
  }

  saveToken({required token}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Konstants.keyToken, token);
  }

  saveLocation({String location = ""}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(Konstants.keyLocation, location);
    notifyListeners();
  }

  saveLatLng({double? lat, double? lng}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setDouble(Konstants.keyLat, lat ?? 0);
    await sharedPreferences.setDouble(Konstants.keyLng, lng ?? 0);
    notifyListeners();
  }

  void addProperties(List<PropertyModel> propsList) {
    allProperties.clear();
    allProperties.addAll(propsList);
    notifyListeners();
  }

  void setCategory(String? name) {
    if (name == null) return;
    if (name.isEmpty) {
      selectedCategory = "All";
    } else {
      selectedCategory = name;
    }
    notifyListeners();
  }
}
