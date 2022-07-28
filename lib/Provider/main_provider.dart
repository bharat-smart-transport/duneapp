import 'dart:convert';
import 'package:dune/Pages/HomePage/add_vehicle.dart';
import 'package:dune/models/filter_model.dart';
import 'package:dune/models/get_bids.dart';
import 'package:dune/models/get_drivers.dart';
import 'package:dune/models/get_owners.dart';
import 'package:dune/models/login_model.dart';
import 'package:dune/models/perVehicle.dart';
import 'package:dune/models/specific_model.dart';
import 'package:dune/models/user_Details.dart';
import 'package:dune/prefs/shared_prefs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/vehicle_model.dart';

class MainProvider extends ChangeNotifier {
  String baseUrl = "http://52.91.212.169/api";

  // this is for testing purpose
  // https://tender-frost-20356.pktriot.net/api
  // This is Main Server
  // http://52.91.212.169/api

  // ignore: avoid_init_to_null
  LoginModel? loginModel = null;
  List<PerVehicle> sold = [];
  List<PerVehicle> loaded = [];
  List<PerVehicle> empty = [];
  String? location;
  String? location2;
  // ignore: avoid_init_to_null
  GetOwner? getOwner = null;
  String userType = "";

  void setUserType(String usertype) {
    userType = "";
    notifyListeners();
    userType = usertype;
    notifyListeners();
  }

  FilterModel? filterModel = null;

  Future<dynamic> filter(String vehicle, String vehicleType, String materialCat,
      String materialSubCat) async {
    emptyList();
    vehicleModel = null;
    notifyListeners();
    String token = await SharedPrefs.getData('token');
    var headersList = {
      'Accept': '*/*',
      'Authorization': token,
    };
    var url = Uri.parse(
      '$baseUrl/vehicle/get-all-active-vehicles?searchKey=[vehicleType,materialCategory,vehicleSubType,materialSubCategory]&searchString=[$vehicleType,$materialCat,$vehicleType,$materialSubCat]',
    );

    var req = http.Request('GET', url);
    req.headers.addAll(headersList);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    var resp = jsonDecode(resBody);
    print(resp);
    if (res.statusCode == 200) {
      vehicleModel = VehicleModel.fromJson(resp);
      for (var i = 0; i < vehicleModel!.data.length; i++) {
        if (vehicleModel!.data[i].dealStatus == "NOT_LOADED") {
          empty.add(PerVehicle.fromJson(resp['data'][i]));
          notifyListeners();
        } else if (vehicleModel!.data[i].dealStatus == "LOADED") {
          loaded.add(PerVehicle.fromJson(resp['data'][i]));
          notifyListeners();
        } else {
          sold.add(PerVehicle.fromJson(resp['data'][i]));
          notifyListeners();
        }
      }
      notifyListeners();
      return "Success";
    } else {
      return "Failed";
    }
  }

  Future<dynamic> ownerList() async {
    var response = await http.get(
      Uri.parse('$baseUrl/auth/get-owners-list'),
      headers: {
        'Authorization': loginModel!.token,
        'Content-Type': 'application/json',
      },
    );
    dynamic res = jsonDecode(response.body);
    if (response.statusCode == 200) {
      getOwner = GetOwner.fromJson(res);
      notifyListeners();
      getDriverList();
      return "Success";
    } else {
      return "Failed";
    }
  }

  GetDrivers? getDrivers = null;
  Future<dynamic> getDriverList() async {
    String token = await SharedPrefs.getData('token');
    var response = await http.get(
      Uri.parse('$baseUrl/auth/get-my-drivers-list'),
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json',
      },
    );
    dynamic res = jsonDecode(response.body);
    print(res);
    if (response.statusCode == 200) {
      getDrivers = GetDrivers.fromJson(res);
      notifyListeners();
      return "Success";
    } else {
      return "Failed";
    }
  }

  Future<dynamic> login(String firebaseId, String phone) async {
    try {
      String? token;
      var map = Map<String, dynamic>();
      await FirebaseMessaging.instance.getToken().then((value) {
        token = value;
        notifyListeners();
      });
      map['phone'] = phone;
      map['password'] = firebaseId;
      map['fcm'] = token;
      print(map);
      var response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        body: json.encode(map),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      dynamic res = jsonDecode(response.body);
      print(res);
      if (response.statusCode == 200) {
        loginModel = LoginModel.fromJson(res);
        SharedPrefs.setAccessToken(loginModel!.token);
        SharedPrefs.setId(loginModel!.data.id);
        await user_info(loginModel!.token);
        notifyListeners();
        await ownerList();
        userDetails!.data.userType == "DRIVER"
            ? getVehicleOnlyDriver(loginModel!.token)
            : getVehicle(loginModel!.token);
        if (loginModel!.message == "Login success") {
          ownerList();
          getDriverList();
          loginModel!.data.userType == null
              ? "DRIVER"
              : SharedPrefs.setUserType(loginModel!.data.userType);
          return "Login";
        } else if (loginModel!.message == "User registered success") {
          ownerList();
          getDriverList();
          return "Register";
        } else {
          return loginModel!.message;
        }
      } else {
        return "Failed";
      }
    } catch (e, stack) {
      print(stack);
    }
  }

  Future<dynamic> splashFun() async {
    String token = await SharedPrefs.getData('token');
    String userType = await SharedPrefs.getData('userType');
    var res = await user_info(token);
    return res;
  }

  Future<dynamic> updateProfile(
      String name,
      String email,
      String address,
      String mobileNum,
      String ownerId,
      String dharamKataName,
      String dharamKataAddress,
      String shopName,
      String shopAddress,
      String imageLink,
      String documentLink) async {
    var userOwner = <String, String>{};
    var userDriver = <String, String>{};
    userOwner = {
      "name": name,
      "email": email,
      "address": address,
      "userType": userType,
    };
    if (userType == "SHOP_KEEPER" || userType == "BROKER") {
      userOwner["userType"] = "CUSTOMER";
      userOwner["customerRole"] = userType;
      userOwner["phone"] = mobileNum;
      userOwner['dharmkataAddress'] = jsonEncode({
        'name': dharamKataName.toString(),
        "location": dharamKataAddress.toString()
      }).toString();
    }

    if (userType == "SHOP_KEEPER") {
      userOwner['shopAddress'] = jsonEncode(
              {'name': shopName.toString(), "location": shopAddress.toString()})
          .toString();
    }
    print(userOwner);
    var req = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/auth/edit'),
    );
    req.headers.addAll({
      'Content-Type': 'application/json',
      'Authorization': loginModel!.token,
    });
    req.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageLink,
      ),
    );
    if (userType == "BROKER") {
      req.files.add(
        await http.MultipartFile.fromPath(
          'document',
          documentLink,
        ),
      );
    }
    print(userOwner);
    var body = json.encode(userOwner);
    req.fields.addAll(userOwner);
    var res = await req.send();
    print(res.stream);
    final resBody = await res.stream.bytesToString();
    print(resBody);
    var res1 = json.decode(resBody);
    if (res1['message'] == "Request Successful") {
      SharedPrefs.setUserType(userType);
      user_info(loginModel!.token);
      loginModel!.data.userType == "DRIVER"
          ? getVehicleOnlyDriver(loginModel!.token)
          : getVehicle(loginModel!.token);
      location = "";
      location2 = "";
      notifyListeners();
      return "Success";
    } else {
      return "Failed";
    }
  }

  Future<dynamic> getVehicleOnlyDriver(String token) async {
    emptyList();
    vehicleModel = null;
    notifyListeners();
    var headersList = {
      'Authorization': token,
    };
    var url = Uri.parse('$baseUrl/vehicle/get-all-my-active-vehicles-driver');
    var response = await http.get(url, headers: headersList);
    dynamic res = jsonDecode(response.body);
    print("000000000000000 --------------- ooooooooooooooo");
    print(res);
    if (response.statusCode == 200) {
      vehicleModel = VehicleModel.fromJson(res);
      notifyListeners();
      for (var i = 0; i < vehicleModel!.data.length; i++) {
        if (vehicleModel!.data[i].dealStatus == "NOT_LOADED") {
          empty.add(PerVehicle.fromJson(res['data'][i]));
          print(empty.length);
          notifyListeners();
        } else if (vehicleModel!.data[i].dealStatus == "LOADED") {
          loaded.add(PerVehicle.fromJson(res['data'][i]));
          notifyListeners();
        } else {
          sold.add(PerVehicle.fromJson(res['data'][i]));
          notifyListeners();
        }
      }
      return "Success";
    } else if (res['message'] == "User session expired, Please log in again!") {
      return "Login Again";
    } else if (res['message'] == "Resource not found") {
      sold = [];
      loaded = [];
      empty = [];
      notifyListeners();
    } else {
      return "Failed";
    }
  }

  Future<dynamic> userOwnerApi(
    String name,
    String email,
    String address,
  ) async {
    var userOwner = {
      "name": name,
      "email": email,
      "address": address,
      "userType": userType,
    };
    var response = await http.post(
      Uri.parse('$baseUrl/auth/edit'),
      body: json.encode(userOwner),
      headers: {
        'Authorization': loginModel!.token,
        'Content-Type': 'application/json',
      },
    );
    dynamic res = jsonDecode(response.body);
    print(res);
    if (res['message'] == "Request Successful") {
      SharedPrefs.setUserType(userType);
      user_info(loginModel!.token);
      loginModel!.data.userType == "DRIVER"
          ? getVehicleOnlyDriver(loginModel!.token)
          : getVehicle(loginModel!.token);
      return "Success";
    } else {
      return "Failed";
    }
  }

  Future<dynamic> userDriver(
    String name,
    String email,
    String address,
    String ownerId,
  ) async {
    var userDriver = {
      "name": name,
      "email": email,
      "address": address.toString(),
      "userType": userType,
      "linkedWith": ownerId.toString(),
    };
    print(userDriver.toString());
    var response = await http.post(
      Uri.parse('$baseUrl/auth/edit'),
      body: json.encode(userDriver),
      headers: {
        'Authorization': loginModel!.token,
        'Content-Type': 'application/json',
      },
    );
    dynamic res = jsonDecode(response.body);
    print(res);
    if (res['message'] == "Request Successful") {
      SharedPrefs.setUserType(userType);

      loginModel!.data.userType == "DRIVER"
          ? getVehicleOnlyDriver(loginModel!.token)
          : getVehicle(loginModel!.token);
      user_info(loginModel!.token);
      return "Success";
    } else {
      return "Failed";
    }
  }

  UserDetails? userDetails = null;
  Future<dynamic> user_info(String token) async {
    userDetails = null;
    notifyListeners();
    print(token);
    var response = await http.get(
      Uri.parse('$baseUrl/auth/info'),
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json',
      },
    );
    print(response.body);
    dynamic res = jsonDecode(response.body);
    print(res);
    if (res['message'] != "User session expired, Please log in again!") {
      userDetails = UserDetails.fromJson(res);
      notifyListeners();
      userDetails!.data.userType == "DRIVER"
          ? getVehicleOnlyDriver(token)
          : getVehicle(token);
      getDriverList();
      print(userDetails!.data.name);
      return "Success";
    } else {
      return "Failed";
    }
  }

  // ignore: non_constant_identifier_names
  Future<dynamic> add_vehicle(
    String vehicleNo,
    String vehicleType,
    String loadCapacity,
    String loadCapacityUnit,
    String baseRouteFrom,
    String baseRouteTo,
    String materialCategory,
    String materialSubCategory,
    String driverId,
    String image,
    bool permission,
  ) async {
    String token = await SharedPrefs.getData('token');
    print(token);
    var headersList = {
      'Accept': '*/*',
      'Authorization': token,
    };
    var url = Uri.parse('$baseUrl/vehicle/add');
    print(driverId);
    Map<String, String> body = {
      "vehicleNo": vehicleNo,
      "vehicleType": vehicleType,
      "loadCapacity": int.parse(loadCapacity).toString(),
      "loadCapacityUnit": loadCapacityUnit,
      "baseRouteFrom": baseRouteFrom,
      "baseRouteTo": baseRouteTo,
      "materialCategory": materialCategory,
      "materialSubCategory": materialSubCategory,
      "driverId": driverId,
      "driverPermissionToSell": permission.toString(),
      "image": image.toString(),
    };
    Map<String, String> bodywithoutdriver = {
      "vehicleNo": vehicleNo,
      "vehicleType": vehicleType,
      "loadCapacity": int.parse(loadCapacity).toString(),
      "loadCapacityUnit": loadCapacityUnit,
      "baseRouteFrom": baseRouteFrom,
      "baseRouteTo": baseRouteTo,
      "materialCategory": materialCategory,
      "materialSubCategory": materialSubCategory,
      "driverPermissionToSell": permission.toString(),
      "image": image.toString(),
    };
    var req = http.MultipartRequest('POST', url);
    req.headers.addAll(headersList);
    req.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imagelink,
      ),
    );
    req.fields.addAll(driverId.isEmpty ? bodywithoutdriver : body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    var response = jsonDecode(resBody);
    if (res.statusCode == 200) {
      getVehicle(token);
      userDetails!.data.userType == "DRIVER"
          ? getVehicleOnlyDriver(loginModel!.token)
          : getVehicle(loginModel!.token);
      return "Success";
    } else {
      return "Failed";
    }
  }

  VehicleModel? vehicleModel = null;

  void emptyList() {
    sold = [];
    loaded = [];
    empty = [];
    notifyListeners();
  }

  Future<dynamic> getVehicle(String token) async {
    emptyList();
    vehicleModel = null;
    notifyListeners();
    var headersList = {
      'Authorization': token,
    };
    print(userDetails!.data.userType);
    var url;
    if (userDetails!.data.userType == "CUSTOMER") {
      url = Uri.parse('$baseUrl/vehicle/get-all-active-vehicles');
    } else {
      url = Uri.parse('$baseUrl/vehicle/get-all-my-active-vehicles');
    }
    var response = await http.get(url, headers: headersList);
    dynamic res = jsonDecode(response.body);
    print("--------------- ooooooooooooooo");
    print(res);
    if (response.statusCode == 200) {
      vehicleModel = VehicleModel.fromJson(res);
      notifyListeners();
      for (var i = 0; i < vehicleModel!.data.length; i++) {
        if (vehicleModel!.data[i].dealStatus == "NOT_LOADED") {
          empty.add(PerVehicle.fromJson(res['data'][i]));
          print(empty.length);
          notifyListeners();
        } else if (vehicleModel!.data[i].dealStatus == "LOADED") {
          loaded.add(PerVehicle.fromJson(res['data'][i]));
          notifyListeners();
        } else {
          sold.add(PerVehicle.fromJson(res['data'][i]));
          notifyListeners();
        }
      }
      return "Success";
    } else if (res['message'] == "User session expired, Please log in again!") {
      return "Login Again";
    } else if (res['message'] == "Resource not found") {
      sold = [];
      loaded = [];
      empty = [];
      notifyListeners();
    } else {
      return "Failed";
    }
  }

  SpecificVehicle? specificVehicle = null;

  Future<dynamic> getVehicleById(String id, String token) async {
    print(id);
    print(token);

    specificVehicle = null;
    notifyListeners();
    var headersList = {
      'Authorization': token,
    };
    var url = Uri.parse('$baseUrl/vehicle/get?id=$id');
    var response = await http.get(url, headers: headersList);
    dynamic res = jsonDecode(response.body);
    print(res);

    if (response.statusCode == 200) {
      if (res['message'] == "No token provided.") {
        return "Failed";
      } else {
        specificVehicle = SpecificVehicle.fromJson(res);
        notifyListeners();
        return "Success";
      }
    } else {
      return "Failed";
    }
  }

  Future<dynamic> edit_vehicle(
    String id,
    String vehicleNo,
    String vehicleType,
    String loadCapacity,
    String loadCapacityUnit,
    String baseRouteFrom,
    String baseRouteTo,
    String materialCategory,
    String materialSubCategory,
    String driverName,
    bool permission,
  ) async {
    String token = await SharedPrefs.getData('token');
    print(driverName);
    var response = await http.post(
      Uri.parse('$baseUrl/vehicle/edit'),
      body: json.encode(
        {
          "id": id,
          "vehicleNo": vehicleNo,
          "vehicleType": vehicleType,
          "loadCapacity": loadCapacity,
          "loadCapacityUnit": loadCapacityUnit,
          "baseRouteFrom": baseRouteFrom,
          "baseRouteTo": baseRouteTo,
          "materialCategory": materialCategory,
          "materialSubCategory": materialSubCategory,
          "driverId": driverName,
          "driverPermissionToSell": permission,
        },
      ),
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json',
      },
    );
    dynamic res = jsonDecode(response.body);
    print(res);
    if (res['message'] == "Request Successful") {
      userDetails!.data.userType == "DRIVER"
          ? getVehicleOnlyDriver(token)
          : getVehicle(token);
      return "Success";
    } else {
      return "Failed";
    }
  }

  Future<dynamic> loadVehicle(
      String id,
      String currentRouteFrom,
      String currentRouteTo,
      String dealStatus,
      String askPrice,
      String billLink,
      String materialLink) async {
    String token = await SharedPrefs.getData('token');
    print(token);
    var headersList = {
      'Accept': '*/*',
      'Authorization': token,
    };
    var url = Uri.parse('$baseUrl/vehicle/edit');
    Map<String, String> body = {
      "id": id,
      "currentRouteFrom": currentRouteFrom,
      "currentRouteTo": currentRouteTo,
      "askPrice": askPrice,
      "dealStatus": dealStatus,
    };
    var req = http.MultipartRequest('POST', url);
    req.headers.addAll(headersList);
    req.files.add(
      await http.MultipartFile.fromPath(
        'bill',
        billLink,
      ),
    );
    materialLink.isNotEmpty
        ? req.files.add(
            await http.MultipartFile.fromPath(
              'materialPhoto',
              materialLink,
            ),
          )
        : null;
    req.fields.addAll(body);
    var res = await req.send();
    final resBody = await res.stream.bytesToString();
    var response = jsonDecode(resBody);
    if (res.statusCode == 200) {
      getVehicle(token);
      userDetails!.data.userType == "DRIVER"
          ? getVehicleOnlyDriver(loginModel!.token)
          : getVehicle(loginModel!.token);
      return "Success";
    } else {
      return "Failed";
    }
  }

  Future<dynamic> createBid(
    String id,
    String price,
  ) async {
    print("Creating");
    String token = await SharedPrefs.getData('token');
    print(id);
    var response = await http.post(
      //edit
      Uri.parse('$baseUrl/requests/create-request'),
      body: json.encode(
        {
          "vehicleId": id,
          "price": price,
        },
      ),
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json',
      },
    );
    dynamic res = jsonDecode(response.body);
    print(res);
    if (response.statusCode == 200) {
      getBid(id);
      return "Success";
    } else {
      return "Failed";
    }
  }

  GetBids? getBids = null;
  String contain = "";
  Future<dynamic> getBid(String id) async {
    getBids = null;
    notifyListeners();
    String token = await SharedPrefs.getData('token');
    print(token);
    var response = await http.post(
      Uri.parse('$baseUrl/requests/get-requests'),
      body: json.encode(
        {
          "vehicleId": id,
        },
      ),
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json',
      },
    );
    dynamic res = jsonDecode(response.body);
    print(res);
    String Id = await SharedPrefs.getData("id");
    if (response.statusCode == 200) {
      getBids = GetBids.fromJson(res);
      notifyListeners();
      for (var i = 0; i < getBids!.requests.length; i++) {
        if (getBids!.requests[i].toBeShownTo.contains(Id)) {
          contain = "Contain";
        } else {
          contain = "NotContain";
        }
      }
      notifyListeners();
      return "Success";
    } else {
      return "Failed";
    }
  }

  Future<dynamic> acceptReqeust(String requestId, String vehicleId) async {
    String token = await SharedPrefs.getData('token');
    print(token);
    var response = await http.post(
      Uri.parse('$baseUrl/requests/accept-request'),
      body: json.encode(
        {
          "requestId": requestId,
        },
      ),
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json',
      },
    );
    dynamic res = jsonDecode(response.body);
    print(res);
    if (response.statusCode == 200) {
      if (res['message'] == "Updated Successfully") {
        getBid(vehicleId);
        return "Success";
      } else {
        getBid(vehicleId);
        return "Failed";
      }
    } else {
      return "Network error";
    }
  }

  Future<dynamic> rejectReqeust(String requestId, String vehicleId) async {
    String token = await SharedPrefs.getData('token');
    print(token);
    var response = await http.post(
      Uri.parse('$baseUrl/requests/reject-request'),
      body: json.encode(
        {
          "requestId": requestId,
        },
      ),
      headers: {
        'Authorization': token,
        'Content-Type': 'application/json',
      },
    );
    dynamic res = jsonDecode(response.body);
    print(res);
    if (response.statusCode == 200) {
      if (res['message'] == "Updated Successfully") {
        getBid(vehicleId);
        return "Success";
      } else {
        getBid(vehicleId);
        return "Failed";
      }
    }
  }
}
