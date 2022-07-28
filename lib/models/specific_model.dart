class SpecificVehicle {
  SpecificVehicle({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;

  SpecificVehicle.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data =
        json['data'] == null ? Data.fromJson({}) : Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.vehicleOwner,
    required this.vehicleNo,
    required this.vehicleType,
    required this.loadCapacity,
    required this.loadCapacityUnit,
    required this.baseRouteFrom,
    required this.baseRouteTo,
    required this.image,
    required this.materialCategory,
    required this.materialSubCategory,
    required this.driverId,
    required this.dealStatus,
    required this.vehicleStatus,
    required this.driverPermissionToSell,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
    required this.driver,
    required this.owner,
  });
  late final dynamic id;
  late final dynamic vehicleOwner;
  late final dynamic vehicleNo;
  late final dynamic vehicleType;
  late final dynamic loadCapacity;
  late final dynamic loadCapacityUnit;
  late final dynamic baseRouteFrom;
  late final dynamic image;
  late final dynamic baseRouteTo;
  late final dynamic materialCategory;
  late final dynamic materialSubCategory;
  late final dynamic driverId;
  late final dynamic dealStatus;
  late final dynamic vehicleStatus;
  late final dynamic driverPermissionToSell;
  late final dynamic createdAt;
  late final dynamic updatedAt;
  late final dynamic V;
  late final dynamic driver;
  late final dynamic owner;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    vehicleOwner = json['vehicleOwner'];
    vehicleNo = json['vehicleNo'];
    vehicleType = json['vehicleType'];
    loadCapacity = json['loadCapacity'];
    loadCapacityUnit = json['loadCapacityUnit'];
    image = json['image'];
    baseRouteFrom = json['baseRouteFrom'];
    baseRouteTo = json['baseRouteTo'];
    materialCategory = json['materialCategory'];
    materialSubCategory = json['materialSubCategory'];
    driverId = json['driverId'];
    dealStatus = json['dealStatus'];
    vehicleStatus = json['vehicleStatus'];
    driverPermissionToSell = json['driverPermissionToSell'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    driver = json['driver'] == null
        ? Driver.fromJson({})
        : Driver.fromJson(json['driver']);
    owner = json['owner'] == null
        ? Owner.fromJson({})
        : Owner.fromJson(json['owner']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['vehicleOwner'] = vehicleOwner;
    _data['vehicleNo'] = vehicleNo;
    _data['vehicleType'] = vehicleType;
    _data['loadCapacity'] = loadCapacity;
    _data['loadCapacityUnit'] = loadCapacityUnit;
    _data['baseRouteFrom'] = baseRouteFrom;
    _data['baseRouteTo'] = baseRouteTo;
    _data['materialCategory'] = materialCategory;
    _data['materialSubCategory'] = materialSubCategory;
    _data['driverId'] = driverId;
    _data['dealStatus'] = dealStatus;
    _data['vehicleStatus'] = vehicleStatus;
    _data['driverPermissionToSell'] = driverPermissionToSell;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['driver'] = driver.toJson();
    _data['owner'] = owner.toJson();
    return _data;
  }
}

class Driver {
  Driver({
    required this.shopAddress,
    required this.dharmkataAddress,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
    required this.linkedWith,
    required this.userType,
  });
  late final ShopAddress shopAddress;
  late final DharmkataAddress dharmkataAddress;
  late final String id;
  late final String name;
  late final String email;
  late final String password;
  late final String phone;
  late final String address;
  late final String status;
  late final String createdAt;
  late final String updatedAt;
  late final int V;
  late final String linkedWith;
  late final String userType;

  Driver.fromJson(Map<String, dynamic> json) {
    shopAddress = json['shopAddress'] == null
        ? ShopAddress.fromJson({})
        : ShopAddress.fromJson(json['shopAddress']);
    dharmkataAddress = json['dharmkataAddress'] == null
        ? DharmkataAddress.fromJson({})
        : DharmkataAddress.fromJson(json['dharmkataAddress']);
    id = json['_id'] ?? "";
    name = json['name'] ?? "";
    email = json['email'] ?? "";
    password = json['password'] ?? "";
    phone = json['phone'] ?? "";
    address = json['address'] ?? "";
    status = json['status'] ?? "";
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    linkedWith = json['linkedWith'] ?? "";
    userType = json['userType'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['shopAddress'] = shopAddress.toJson();
    _data['dharmkataAddress'] = dharmkataAddress.toJson();
    _data['_id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['password'] = password;
    _data['phone'] = phone;
    _data['address'] = address;
    _data['status'] = status;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['linkedWith'] = linkedWith;
    _data['userType'] = userType;
    return _data;
  }
}

class ShopAddress {
  ShopAddress();

  ShopAddress.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}

class DharmkataAddress {
  DharmkataAddress();

  DharmkataAddress.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}

class Owner {
  Owner({
    required this.shopAddress,
    required this.dharmkataAddress,
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.address,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
    required this.userType,
  });
  late final ShopAddress shopAddress;
  late final DharmkataAddress dharmkataAddress;
  late final String id;
  late final String name;
  late final String email;
  late final String password;
  late final String phone;
  late final String address;
  late final String status;
  late final String createdAt;
  late final String updatedAt;
  late final dynamic V;
  late final String userType;

  Owner.fromJson(Map<String, dynamic> json) {
    shopAddress = json['shopAddress'] == null
        ? ShopAddress.fromJson({})
        : ShopAddress.fromJson(json['shopAddress']);
    dharmkataAddress = json['dharmkataAddress'] == null
        ? DharmkataAddress.fromJson({})
        : DharmkataAddress.fromJson(json['dharmkataAddress']);
    id = json['_id'] ?? "";
    name = json['name'] ?? "";
    email = json['email'] ?? "";
    password = json['password'] ?? "";
    phone = json['phone'] ?? "";
    address = json['address'] ?? "";
    status = json['status'] ?? "";
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    V = json['__v'] ?? "";
    userType = json['userType'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['shopAddress'] = shopAddress.toJson();
    _data['dharmkataAddress'] = dharmkataAddress.toJson();
    _data['_id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['password'] = password;
    _data['phone'] = phone;
    _data['address'] = address;
    _data['status'] = status;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    _data['userType'] = userType;
    return _data;
  }
}
