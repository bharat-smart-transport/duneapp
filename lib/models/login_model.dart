class LoginModel {
  LoginModel({
    required this.message,
    required this.data,
    required this.token,
  });
  late final String message;
  late final Data data;
  late final String token;

  LoginModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = Data.fromJson(json['data']);
    token = json['token'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['data'] = data.toJson();
    _data['token'] = token;
    return _data;
  }
}

class Data {
  Data({
    required this.shopAddress,
    required this.dharmkataAddress,
    required this.id,
    this.name,
    this.email,
    required this.password,
    required this.userType,
    required this.phone,
    this.address,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final ShopAddress shopAddress;
  late final DharmkataAddress dharmkataAddress;
  late final dynamic id;
  late final dynamic name;
  late final dynamic email;
  late final dynamic password;
  late final dynamic phone;
  late final dynamic userType;
  late final dynamic address;
  late final dynamic status;
  late final dynamic createdAt;
  late final dynamic updatedAt;
  late final dynamic V;

  Data.fromJson(Map<String, dynamic> json) {
    shopAddress = ShopAddress.fromJson(json['shopAddress']);
    dharmkataAddress = DharmkataAddress.fromJson(json['dharmkataAddress']);
    id = json['_id'];
    userType = json['userType'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    address = json['address'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
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
