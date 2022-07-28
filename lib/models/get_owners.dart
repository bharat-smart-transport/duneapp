class GetOwner {
  GetOwner({
    required this.message,
    required this.owners,
  });
  late final String message;
  late final List<Owners> owners;

  GetOwner.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    owners = List.from(json['owners']).map((e) => Owners.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['owners'] = owners.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Owners {
  Owners({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
  });
  late final dynamic id;
  late final dynamic name;
  late final dynamic phone;
  late final dynamic address;

  Owners.fromJson(Map<String, dynamic> json) {
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
