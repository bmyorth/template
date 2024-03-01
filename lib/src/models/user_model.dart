import 'geo_address_model.dart';

class UserModel {
  int? id;
  String? username;
  String? name;
  String? ci;
  String? email;
  String? phone;
  String? address;
  String? password;
  String? dateJoined;
  String? lastLogin;
  bool? isActive;
  String? tokendevice;
  String? urlPicture;
  bool? isLocal;
  GeoAddressModel? geo;
  bool enableNotif;

  UserModel({
    this.id = 0,
    this.username,
    this.name,
    this.ci,
    this.email,
    this.phone,
    this.address,
    this.password,
    this.dateJoined,
    this.lastLogin,
    this.isActive,
    this.tokendevice,
    this.urlPicture,
    this.isLocal = false,
    this.geo,
    this.enableNotif = true,
  });

  UserModel copyWith({
    int? userId,
    int? profileId,
    bool? isSuperAdmin,
    String? username,
    String? name,
    String? ci,
    String? email,
    String? phone,
    String? address,
    String? birthDate,
    String? password,
    String? dateJoined,
    String? lastLogin,
    String? zipCode,
    bool? isActive,
    String? tokendevice,
    String? urlPicture,
    bool? isLocal,
    GeoAddressModel? geo,
    bool? enableNotif,
  }) {
    return UserModel(
      id: userId ?? id,
      username: username ?? this.username,
      name: name ?? this.name,
      ci: ci ?? this.ci,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      password: password ?? this.password,
      dateJoined: dateJoined ?? this.dateJoined,
      lastLogin: lastLogin ?? this.lastLogin,
      isActive: isActive ?? this.isActive,
      tokendevice: tokendevice ?? this.tokendevice,
      urlPicture: urlPicture ?? this.urlPicture,
      isLocal: isLocal ?? this.isLocal,
      geo: geo ?? this.geo,
      enableNotif: enableNotif ?? this.enableNotif,
    );
  }

  @override
  String toString() {
    return 'username: $username';
  }

  String fullName() {
    return name!;
  }

  bool isAuthenticate() {
    return id != 0;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    UserModel user = UserModel(
        id: int.tryParse(json['user']['id'].toString()) ?? 0,
        phone: json['user']['phone'] ?? "",
        address: json['user']['address'] ?? "",
        username: json['user']['username'] ?? "",
        name: json['user']['name'] ?? "",
        ci: json['user']['ci'] ?? "",
        email: json['user']['email'] ?? "",
        lastLogin: json['user']['lastLogin'] ?? "",
        dateJoined: json['user']['dateJoined'] ?? "",
        password: json['user']['password'] ?? "",
        isActive: json['user']['isActive'] ?? false,
        urlPicture: json['user']['urlPicture'] ?? "assets/pedro.png",
        isLocal: json['user']['urlPicture'] == null ||
            json['user']['urlPicture'] == "");

    return user;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "id": id,
      "name": name,
      "ci": ci,
      "email": email,
      "phone": phone,
      "address": address,
      "dateJoined": dateJoined,
      "lastLogin": lastLogin,
      "isActive": isActive,
      "password": password,
      "tokendevice": tokendevice,
      "url_picture": urlPicture,
      "enableNotif": enableNotif,
    };
    map.removeWhere((key, value) => value == "" || value == null);
    return map;
  }
}
