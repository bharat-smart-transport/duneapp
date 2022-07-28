class GetDrivers {
  GetDrivers({
    required this.message,
    required this.drivers,
  });
  late final String message;
  late final List<Driver> drivers;

  GetDrivers.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    drivers = List.from(json['drivers']).map((e) => Driver.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['drivers'] = drivers.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Driver {
  Driver({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
  });
  late final dynamic id;
  late final dynamic name;
  late final dynamic phone;
  late final dynamic address;

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['name'] = name;
    _data['phone'] = phone;
    _data['address'] = address;
    return _data;
  }
}
