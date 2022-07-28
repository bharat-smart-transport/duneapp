class UserDetails {
  UserDetails({
    required this.message,
    required this.data,
  });
  late final String message;
  late final Data data;

  UserDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
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
    required this.shopAddress,
    required this.dharmkataAddress,
    required this.id,
    required this.password,
    required this.phone,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
    required this.userType,
    required this.name,
    required this.address,
    required this.email,
  });
  late final ShopAddress shopAddress;
  late final DharmkataAddress dharmkataAddress;
  late final dynamic id;
  late final dynamic password;
  late final dynamic phone;
  late final dynamic status;
  late final dynamic createdAt;
  late final dynamic updatedAt;
  late final dynamic V;
  late final dynamic userType;
  late final dynamic name;
  late final dynamic address;
  late final dynamic email;

  Data.fromJson(Map<String, dynamic> json) {
    shopAddress = ShopAddress.fromJson(json['shopAddress']);
    dharmkataAddress = DharmkataAddress.fromJson(json['dharmkataAddress']);
    id = json['_id'];
    password = json['password'];
    phone = json['phone'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
    userType = json['userType'];
    name = json['name'];
    address = json['address'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['shopAddress'] = shopAddress.toJson();
    _data['dharmkataAddress'] = dharmkataAddress.toJson();
    _data['_id'] = id;
    _data['password'] = password;
    _data['phone'] = phone;
    _data['status'] = status;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    _data['userType'] = userType;
    _data['name'] = name;
    _data['address'] = address;
    _data['email'] = email;
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
