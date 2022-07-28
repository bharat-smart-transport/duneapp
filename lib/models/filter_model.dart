class FilterModel {
  FilterModel({
    required this.data,
    required this.message,
  });
  late final List<Data> data;
  late final String message;

  FilterModel.fromJson(Map<String, dynamic> json) {
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e) => e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.image,
    required this.vehicleOwner,
    required this.vehicleNo,
    required this.vehicleType,
    required this.loadCapacity,
    required this.loadCapacityUnit,
    required this.baseRouteFrom,
    required this.baseRouteTo,
    required this.materialCategory,
    required this.materialSubCategory,
    required this.driverId,
    required this.dealStatus,
    required this.vehicleStatus,
    required this.driverPermissionToSell,
    required this.createdAt,
    required this.updatedAt,

    required this.askPrice,
    required this.soldPrice,
  });
  late final String id;
  late final String image;
  late final String vehicleOwner;
  late final String vehicleNo;
  late final String vehicleType;
  late final int loadCapacity;
  late final String loadCapacityUnit;
  late final String baseRouteFrom;
  late final String baseRouteTo;
  late final String materialCategory;
  late final String materialSubCategory;
  late final String driverId;
  late final String dealStatus;
  late final String vehicleStatus;
  late final bool driverPermissionToSell;
  late final String createdAt;
  late final String updatedAt;

  late final int askPrice;
  late final int soldPrice;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    image = json['image'];
    vehicleOwner = json['vehicleOwner'];
    vehicleNo = json['vehicleNo'];
    vehicleType = json['vehicleType'];
    loadCapacity = json['loadCapacity'];
    loadCapacityUnit = json['loadCapacityUnit'];
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
    askPrice = json['askPrice'];
    soldPrice = json['soldPrice'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['image'] = image;
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

    _data['askPrice'] = askPrice;
    _data['soldPrice'] = soldPrice;
    return _data;
  }
}
