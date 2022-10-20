import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sellthedwell/models/about_membership.dart';
import 'package:sellthedwell/models/about_model.dart';
import 'package:sellthedwell/models/aminities_model.dart';
import 'package:sellthedwell/models/category_model.dart';
import 'package:sellthedwell/models/feature_model.dart';
import 'package:sellthedwell/models/meeting_list_model.dart';
import 'package:sellthedwell/models/membership_plan_response.dart';
import 'package:sellthedwell/models/property_model.dart';
import 'package:sellthedwell/screens/membership_plan.dart';

import 'package:sellthedwell/utils/konstants.dart';
import 'package:sellthedwell/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../chat/ChatUsers.dart';

class NetworkService {
  NetworkService._();
  static const String _baseUrl = Konstants.baseUrl;

  static const String _createmeeting = "/createmeeting";
  static const String _loginUrl = "/user/login";
  static const String _deleteProperty = "/users/property/delete";
  static const String _categoryUrl = "/categories";
  static const String _savedPropertiesUrl = "/getfavoriteproperties";
  static const String _allPropertiesUrl = "/all_property_list";
  static const String _myProperties = "/users/propertylist";
  static const String _makeFavorite = "/makefavorite";
  static const String _registerUrl = "/user/register";
  static const String _aboutUs = "/site_info";
  static const String _aboutMembership = "/meambership_info";
  static const String _membershipPlanDetails = "/users/getpackagedetails";
  static const String _recentlyViewdProperties = "/getrecentlyviewproperties";
  static const String _activeViewdProperties = "/propertiesbytype/Active";
  static const String _closedViewdProperties = "/propertiesbytype/Closed";
  static const String _scheduledViewdProperties = "/propertiesbytype/Scheduled";
  static const String _modifyViewdProperties = "/propertiesbytype/Modify";
  static const String _updateProfileUrl = "/users/edit_profile";
  static const String _updateProfilePic = "/users/update_profile_pic";
  static const String _updatePasswordeUrl = "/users/change_password";
  static const String _addListing = "/users/property/save";
  static const String _allActivePropertiesUrl = "/propertiesbytype_by_status/Active";
  static const String _allScheduledPropetiesUrl = "/propertiesbytype_by_status/Scheduled";
  static const String _sendMeetingList = "/sendmeetinglist";
  static const String _recieveMeetingList = "/receivemeetinglist";
  static const String _featureList = "/getfeatures";
  static const String _aminitesList = "/getaminities";

  static const String _get_chat_message = "/get_chat_message";
  static const String _add_chat_message = "/add_chat_message";
  static const String _chat_conversations = "/chat_conversations";

  static getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Konstants.keyToken) ?? "";
    print(token);
    return <String, String>{
      "Authorizations": "Bearer $token",
    };
  }

  static getHeaders2() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(Konstants.keyToken) ?? "";
    return <String, String>{
      "Authorizations": "Bearer $token",
      "Content-Type": "multipart/form-data",
    };
  }

  /// Login API calls
  /// @param username, password
  static login({
    String email = "",
    String password = "",
    String devicetype = "android",
  }) async {
    log("Username: $email , Password: $password");
    final response = await http.post(
      Uri.parse(_baseUrl + _loginUrl),
      body: {
        "email": email,
        "password": password,
        "device_type": devicetype,
      },
    );
    // log(response.body);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['status']) {
        return result['data'];
      } else {
        throw Exception(result['message']);
      }
    } else {
      throw Exception(Strings.somethingWentWrong);
    }
  }

  static register({
    required String name,
    required String password,
    required String phone,
    required String address,
    required String email,
    required String devicetype,
  }) async {
    log("Username: $email , Password: $password");
    final response = await http.post(
      Uri.parse(_baseUrl + _registerUrl),
      body: {
        "name": email,
        "password": password,
        "phone": phone,
        "address": address,
        "email": email,
        "device_type": devicetype,
      },
    );
    // log(response.body);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['status']) {
        toast(result['message']);
        return result['data'];
      } else {
        throw Exception(result['message']);
      }
    } else {
      throw Exception(Strings.somethingWentWrong);
    }
  }

  static getCategories() async {
    final response = await http.get(
      Uri.parse(_baseUrl + _categoryUrl),
      headers: await getHeaders(),
    );
    // log(response.body);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final List<CategoryModel> list = [];
      if (result['status']) {
        final cats = result['data']['userdata'];
        for (var item in cats) {
          list.add(CategoryModel.fromJson(item));
        }
        log("List of categories : ${list.map((e) => e.name)}");
        return list;
      } else {
        throw Exception(result['message']);
      }
    } else {
      throw Exception(Strings.somethingWentWrong);
    }
  }

  // Make favourite
  static makeFavourite({required String propId, required String status}) async {
    final response = await http.post(
      Uri.parse(_baseUrl + _makeFavorite),
      body: {
        "property_id": propId,
        "status": status,
      },
      headers: await getHeaders(),
    );
    log("IN enetwer");
    // log(response.body);
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['status']) {
        toast(result['message']);
      } else {
        throw Exception(result['message']);
      }
    } else {
      throw Exception(Strings.somethingWentWrong);
    }
  }

  // Get saved properties
  static getSavedProperties() async {
    final response = await http.get(
      Uri.parse(_baseUrl + _savedPropertiesUrl),
      headers: await getHeaders(),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print(result.toString());
      final List<PropertyModel> list = [];
      if (result['status']) {
        final cats = result['data']['properties'];
        for (var item in cats) {
          list.add(PropertyModel.fromJson(item));
        }
        log("List of categories : ${list.map((e) => e.name)}");
        print(list);
        return list;
      } else {
        throw Exception(result['message']);

      }
    } else {
      throw Exception(Strings.somethingWentWrong);
    }
  }

  // Get all properties
  static getAllProperties() async {
    final response = await http.get(
      Uri.parse(_baseUrl + _allPropertiesUrl),
      headers: await getHeaders(),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print(result);
      final List<PropertyModel> list = [];
      if (result['status']) {
        final cats = result['data']['properties'];
        for (var item in cats) {
          list.add(PropertyModel.fromJson(item));
        }
        log("List of categories : ${list.map((e) => e.name)}");
        return list;
      } else {
        throw Exception(result['message']);
      }
    } else {
      throw Exception(Strings.somethingWentWrong);
    }
  }

  static getAllFeature() async {
    final response = await http.get(
      Uri.parse(_baseUrl + _featureList),
      headers: await getHeaders(),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print(result);
      final List<Features> list = [];
      if (result['status']) {
        final cats = result['data']['features'];
        for (var item in cats) {
          list.add(Features.fromJson(item));
        }
        return list;
      } else {
        throw Exception(result['message']);
      }
    } else {
      throw Exception(Strings.somethingWentWrong);
    }
  }

  static getAllAminities() async {
    final response = await http.get(
      Uri.parse(_baseUrl + _aminitesList),
      headers: await getHeaders(),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print(result);
      final List<Aminities> list = [];
      if (result['status']) {
        final cats = result['data']['aminities'];
        for (var item in cats) {
          list.add(Aminities.fromJson(item));
        }
        return list;
      } else {
        throw Exception(result['message']);
      }
    } else {
      throw Exception(Strings.somethingWentWrong);
    }
  }

  // Get all properties
  static getActiveOpenProperties() async {
    final response = await http.get(
      Uri.parse(_baseUrl + _allActivePropertiesUrl),
      headers: await getHeaders(),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final List<PropertyModel> list = [];
      if (result['status']) {
        final cats = result['data']['properties'];
        for (var item in cats) {
          list.add(PropertyModel.fromJson(item));
        }
        log("List of categories : ${list.map((e) => e.name)}");
        return list;
      } else {
        throw Exception(result['message']);
      }
    } else {
      throw Exception(Strings.somethingWentWrong);
    }
  }

  // Get schedule open properties
  static getScheduleOpenProperties() async {
    final response = await http.get(
      Uri.parse(_baseUrl + _allScheduledPropetiesUrl),
      headers: await getHeaders(),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final List<PropertyModel> list = [];
      if (result['status']) {
        final cats = result['data']['properties'];
        for (var item in cats) {
          list.add(PropertyModel.fromJson(item));
        }
        log("List of categories : ${list.map((e) => e.name)}");
        return list;
      } else {
        throw Exception(result['message']);
      }
    } else {
      throw Exception(Strings.somethingWentWrong);
    }
  }

// About
  static Future<AboutResponseModel> getAboutDetails() async {
    final response = await http.get(
      Uri.parse(_baseUrl + _aboutUs),
      headers: await getHeaders(),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return AboutResponseModel.fromJson(result);
    } else {
      throw Exception(Strings.somethingWentWrong);
    }
  }

// About membership
  static Future<AboutMembershipResponse> getAboutMembershipDetails() async {
    final response = await http.get(
      Uri.parse(_baseUrl + _aboutMembership),
      headers: await getHeaders(),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return AboutMembershipResponse.fromJson(result['membership_page']);
    } else {
      throw Exception(Strings.somethingWentWrong);
    }
  }

  // Get my properties
  /// possible type = 'all' , 'Commercial', 'Residential', ''
  static getMyActiveProperties({
    String type = Konstants.listTypeAll,
  }) async {
    final response = await http.post(
      Uri.parse("$_baseUrl$_myProperties"),
      body: {"type": type},
      headers: await getHeaders(),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print(result.toString());
      final List<PropertyModel> list = [];
      if (result['status']) {
        final cats = result['data']['propertylist'];
        for (var item in cats) {
          list.add(PropertyModel.fromJson(item));
        }
        log("List of categories : ${list.map((e) => e.name)}");
        return list;
      } else {
        throw Exception(result['message']);
      }
    } else {
      throw Exception(Strings.somethingWentWrong);
    }
  }

  static Future getMembershipplanDetails() async {
    final response = await http.get(
      Uri.parse(_baseUrl + _membershipPlanDetails),
      headers: await getHeaders(),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return MembershipPlanResponse.fromJson(result['data']['packagedetails']);
    } else {
      throw Exception(Strings.somethingWentWrong);
    }
  }

  static Future getrecentlyviewproperties() async {
    final response = await http.get(
      Uri.parse(_baseUrl+_recentlyViewdProperties),
      headers: await getHeaders(),
    );
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final List<PropertyModel> list = [];
      if (result['status']) {
        final cats = result['data']['properties'];
        for (var item in cats) {
          list.add(PropertyModel.fromJson(item));
        }
        log("List of categories : ${list.map((e) => e.name)}");
        return list;
      } else {
        throw Exception(result['message']);
      }
    } else {
      print(response.body.toString());
      throw Exception(response.body.toString());

    }
  }

  static Future getactiveviewproperties() async {
    final response = await http.get(
      Uri.parse(_baseUrl+_activeViewdProperties),
      headers: await getHeaders(),
    );
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final List<PropertyModel> list = [];
      if (result['status']) {
        final cats = result['data']['properties'];
        for (var item in cats) {
          list.add(PropertyModel.fromJson(item));
        }
        log("List of categories : ${list.map((e) => e.name)}");
        return list;
      } else {
        throw Exception(result['message']);
      }
    } else {
      print(response.body.toString());
      throw Exception(response.body.toString());

    }
  }

  static Future getclosedviewproperties() async {
    final response = await http.get(
      Uri.parse(_baseUrl+_closedViewdProperties),
      headers: await getHeaders(),
    );
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final List<PropertyModel> list = [];
      if (result['status']) {
        final cats = result['data']['properties'];
        for (var item in cats) {
          list.add(PropertyModel.fromJson(item));
        }
        log("List of categories : ${list.map((e) => e.name)}");
        return list;
      } else {
        throw Exception(result['message']);
      }
    } else {
      print(response.body.toString());
      throw Exception(response.body.toString());

    }
  }

  static Future getscheduledviewproperties() async {
    final response = await http.get(
      Uri.parse(_baseUrl+_scheduledViewdProperties),
      headers: await getHeaders(),
    );
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final List<PropertyModel> list = [];
      if (result['status']) {
        final cats = result['data']['properties'];
        for (var item in cats) {
          list.add(PropertyModel.fromJson(item));
        }
        log("List of categories : ${list.map((e) => e.name)}");
        return list;
      } else {
        throw Exception(result['message']);
      }
    } else {
      print(response.body.toString());
      throw Exception(response.body.toString());

    }
  }

  static Future getmoifyviewproperties() async {
    final response = await http.get(
      Uri.parse(_baseUrl+_modifyViewdProperties),
      headers: await getHeaders(),
    );
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final List<PropertyModel> list = [];
      if (result['status']) {
        final cats = result['data']['properties'];
        for (var item in cats) {
          list.add(PropertyModel.fromJson(item));
        }
        log("List of categories : ${list.map((e) => e.name)}");
        return list;
      } else {
        throw Exception(result['message']);
      }
    } else {
      print(response.body.toString());
      throw Exception(response.body.toString());

    }
  }

  static Future updateProfile({
    required String name,
    required String mobile,
    required String email,
    required String address,
    required String city,
    required String state,
    required String country,
    required XFile profilePic,
  }) async {
    try {
      if(profilePic.toString().length > 0 ) {
        var request = http.MultipartRequest('POST', Uri.parse("$_baseUrl$_updateProfilePic"));
        request.files.add(await http.MultipartFile.fromPath('profile_pic', profilePic.path));
        request.headers.addAll(await getHeaders());
        await request.send();
      }
      final response = await http.post(
        Uri.parse("$_baseUrl$_updateProfileUrl"),
        body: {
          "name" : name,
          "address" : address,
          "city" : city,
          "state":state,
          "country":country,
          "zipcode":"545454",
          "phone":mobile
        },
        headers: await getHeaders(),
      );


      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print(response.body);
        if (result['status']) {
          return result;
        } else {
          throw Exception(result['message']);
        }
      } else {
        throw Exception(Strings.somethingWentWrong);
      }
    } catch (e) {
      rethrow;
    }
  }


  static Future updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$_baseUrl$_updatePasswordeUrl"),
        body: {
          "old_password" : currentPassword,
          "new_password" : newPassword
        },
        headers: await getHeaders(),
      );
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        print(response.body);
        if (result['status']) {
          return result;
        } else {
          throw Exception(result['message']);
        }
      } else {
        throw Exception(Strings.somethingWentWrong);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> addProperty(
      Map<String, String> map,List<String> activeDate, List<XFile> imagePaths, List<XFile> videoPaths,List<XFile> vr_imagePaths, List<XFile> vr_videoPaths,
      String filePath,
      {bool edit = false, int? id}) async {
    try {
      var request =
          http.MultipartRequest('POST', Uri.parse("$_baseUrl$_addListing"));
      request.fields.addAll(map);
      if (edit) {
        request.fields.addAll({'id': "$id"});
      }

      print(activeDate);
      for (String item in activeDate) {
        request.files.add(http.MultipartFile.fromString('active_dates[]', item));
        print(request.files[0]);
      }

      for (var element in videoPaths) {
        request.files
            .add(await http.MultipartFile.fromPath('video_file', element.path));
      }

      for (var element in imagePaths) {
        request.files
            .add(await http.MultipartFile.fromPath('images[]', element.path));
      }

      for (var element in vr_videoPaths) {
        print("mk");
        print(element.path);
        request.files
            .add(await http.MultipartFile.fromPath('video_vr', element.path));
      }

      for (var element in vr_imagePaths) {
        request.files
            .add(await http.MultipartFile.fromPath('images_vr[]', element.path));
      }
print("123");
      !edit ? filePath.isNotEmpty ? request.files
            .add(await http.MultipartFile.fromPath('modal_assets', filePath.replaceAll("[", "").replaceAll("]", "")??"")):null : null;


      request.headers.addAll(
        await getHeaders2(),
      );

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        final data = await response.stream.bytesToString();
        final resp = jsonDecode(data);
        return true;
        if (!resp['status']) {
          toast(resp['message'] ?? "", duration: Toast.LENGTH_LONG);
        }
        log(data);
        toast("Success");
        print(data);
        return true;
      } else {
        toast(response.reasonPhrase.toString(), duration: Toast.LENGTH_LONG);
        print(response.stream);
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

// send
  static Future<List<MeetingListModel>> getSendMeetingsList() async {
    final response = await http.get(
      Uri.parse("$_baseUrl$_sendMeetingList"),
      headers: await getHeaders(),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final List<MeetingListModel> list = [];
      if (result['status']) {
        final cats = result['data']['meeting'];

        for (var item in cats) {
          if (item['property_details'] is List) {
            continue;
          }
          list.add(MeetingListModel.fromJson(item));
        }
        return list;
      } else {
        throw Exception(result['message']);
      }
    } else {
      throw Exception(Strings.somethingWentWrong);
    }
  }

// send
  static Future<List<MeetingListModel>> getRecieveMeetingsList() async {
    var data = {
      "type" : '2',
    };
    final response = await http.post(
      Uri.parse("$_baseUrl$_recieveMeetingList"),
      body: data,
      headers: await getHeaders(),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final List<MeetingListModel> list = [];
      if (result['status']) {
        final cats = result['data']['meeting'];
        for (var item in cats) {
          list.add(MeetingListModel.fromJson(item));
        }
        return list;
      } else {
        throw Exception(result['message']);
      }
    } else {
      throw Exception(Strings.somethingWentWrong);
    }
  }

  static deleteProperty(PropertyModel prop) async {
    final response = await http.post(
      Uri.parse("$_baseUrl$_deleteProperty"),
      body: {
        "id": "${prop.id}",
      },
      headers: await getHeaders(),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['status']) {
        return true;
      } else {
        throw Exception(result['message']);
      }
    } else {
      throw Exception(Strings.somethingWentWrong);
    }
  }

  static Future<bool> crateRequest(
    Map<String, String> map,
  ) async {
    try {
      print(map);
      var request =
          http.MultipartRequest('POST', Uri.parse('$_baseUrl$_createmeeting'));
      request.fields.addAll(map);

      request.headers.addAll(await getHeaders());

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        toast("Request sent Successfully!");
        return true;
      } else {
        toast("Request sent failed!");

        return false;
      }
    } catch (e) {
      toast(e.toString());
      return false;
    } finally {}
  }

  static getCovertionData() async {
    final response = await http.post(
      Uri.parse("$_baseUrl$_chat_conversations"),
      body: {},
      headers: await getHeaders(),
    );
    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      final List<ChatUsers> list = [];
      if (result['status']) {
        final cats = result['data'];
        debugPrint('movieTitle: $cats');
        // for (var item in cats) {
        //   list.add(ChatUsers.fromJson(item));
        // }

        return list;
      } else {
        throw Exception(result['message']);
      }
    } else {
      throw Exception(Strings.somethingWentWrong);
    }
  }
}
