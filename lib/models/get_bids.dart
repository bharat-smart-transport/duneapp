class GetBids {
  GetBids({
    required this.message,
    required this.requests,
  });
  late final String message;
  late final List<Requests> requests;

  GetBids.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    requests =
        List.from(json['requests']).map((e) => Requests.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['requests'] = requests.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Requests {
  Requests({
    required this.id,
    required this.vehicleId,
    required this.customerId,
    required this.toBeShownTo,
    required this.requestStatus,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final dynamic id;
  late final dynamic vehicleId;
  late final dynamic customerId;
  late final dynamic toBeShownTo;
  late final dynamic requestStatus;
  late final dynamic price;
  late final dynamic createdAt;
  late final dynamic updatedAt;
  late final dynamic V;

  Requests.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    vehicleId = json['vehicleId'];
    customerId = json['customerId'];
    toBeShownTo = List.castFrom<dynamic, String>(json['toBeShownTo']);
    requestStatus = json['requestStatus'];
    price = json['price'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['vehicleId'] = vehicleId;
    _data['customerId'] = customerId;
    _data['toBeShownTo'] = toBeShownTo;
    _data['requestStatus'] = requestStatus;
    _data['price'] = price;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}
