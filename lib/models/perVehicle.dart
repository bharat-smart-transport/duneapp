class PerVehicle {
  PerVehicle({
    required this.id,
    required this.vehicleOwner,
    required this.vehicleNo,
    required this.vehicleType,
    required this.loadCapacity,
    required this.loadCapacityUnit,
    required this.baseRouteFrom,
    required this.askPrice,
    required this.baseRouteTo,
    required this.materialCategory,
    required this.image,
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
  late final String? id;
  late final String? vehicleOwner;
  late final String? vehicleNo;
  late final int? askPrice;
  late final String? vehicleType;
  late final String? image;
  late final int? loadCapacity;
  late final String? loadCapacityUnit;
  late final String? baseRouteFrom;
  late final String? baseRouteTo;
  late final String? materialCategory;
  late final String? materialSubCategory;
  late final String? driverId;
  late final String? dealStatus;
  late final String? vehicleStatus;
  late final bool? driverPermissionToSell;
  late final String? createdAt;
  late final String? updatedAt;
  late final int? V;
  late final Driver? driver;
  late final Owner? owner;

  PerVehicle.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    vehicleOwner = json['vehicleOwner'];
    vehicleNo = json['vehicleNo'];
    askPrice = json['askPrice'];
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
    V = json['__v'];
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
    _data['__v'] = V;
    _data['driver'] = driver!.toJson();
    _data['owner'] = owner!.toJson();
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
  late final ShopAddress? shopAddress;
  late final DharmkataAddress? dharmkataAddress;
  late final dynamic? id;
  late final dynamic? name;
  late final dynamic? email;
  late final dynamic? password;
  late final dynamic? phone;
  late final dynamic? address;
  late final dynamic? status;
  late final dynamic? createdAt;
  late final dynamic? updatedAt;
  late final dynamic? V;
  late final dynamic? linkedWith;
  late final dynamic? userType;

  Driver.fromJson(Map<String, dynamic> json) {
    shopAddress = json['shopAddress'] == null
        ? ShopAddress.fromJson({})
        : ShopAddress.fromJson(json['shopAddress']);
    dharmkataAddress = json['dharmkataAddress'] == null
        ? DharmkataAddress.fromJson({})
        : DharmkataAddress.fromJson(json['dharmkataAddress']);
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    address = json['address'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
    linkedWith = json['linkedWith'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['shopAddress'] = shopAddress!.toJson();
    _data['dharmkataAddress'] = dharmkataAddress!.toJson();
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
  late final ShopAddress? shopAddress;
  late final DharmkataAddress? dharmkataAddress;
  late final String? id;
  late final String? name;
  late final String? email;
  late final String? password;
  late final String? phone;
  late final String? address;
  late final String? status;
  late final String? createdAt;
  late final String? updatedAt;
  late final int? V;
  late final String? userType;

  Owner.fromJson(Map<String, dynamic> json) {
    shopAddress = json['shopAddress'] == null
        ? ShopAddress.fromJson({})
        : ShopAddress.fromJson(json['shopAddress']);
    dharmkataAddress = json['dharmkataAddress'] == null
        ? DharmkataAddress.fromJson({})
        : DharmkataAddress.fromJson(json['dharmkataAddress']);
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    address = json['address'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['shopAddress'] = shopAddress!.toJson();
    _data['dharmkataAddress'] = dharmkataAddress!.toJson();
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
