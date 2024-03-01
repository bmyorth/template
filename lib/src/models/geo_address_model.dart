import 'package:get/utils.dart';
import 'package:latlong2/latlong.dart';

class GeoAddressModel {
  AddressModel? placemark;
  LatLng? position;

  GeoAddressModel({this.placemark, this.position});

  @override
  String toString() {
    return placemark == null ? 'unknown'.tr : placemark.toString();
  }

  factory GeoAddressModel.fromPhotonAPI(Map data) => GeoAddressModel(
      position: LatLng(data["geometry"]["coordinates"][1],
          data["geometry"]["coordinates"][0]),
      placemark: AddressModel.fromPhotonAPI(data["properties"]));
  // address = Address.fromPhotonAPI(data["properties"])
}

class AddressModel {
  final String? postcode;
  final String? name;
  final String? street;
  final String? city;
  final String? state;
  final String? country;

  AddressModel({
    this.postcode,
    this.street,
    this.city,
    this.name,
    this.state,
    this.country,
  });

  factory AddressModel.fromPhotonAPI(Map data) => AddressModel(
      postcode: data["postcode"],
      street: data["street"],
      name: data["name"],
      city: data["city"],
      state: data["state"],
      country: data["country"]);

  @override
  String toString() {
    String addr = "";
    if (name != null && name!.isNotEmpty) {
      addr = "$addr$name, ";
    }
    if (street != null && street!.isNotEmpty) {
      addr = "$addr$street, ";
    }
    // if (postcode != null && postcode!.isNotEmpty) {
    //   addr = "$addr$postcode, ";
    // }
    if (city != null && city!.isNotEmpty) {
      addr = "$addr$city, ";
    }
    if (state != null && state!.isNotEmpty) {
      addr = "$addr$state, ";
    }
    if (country != null && country!.isNotEmpty) {
      addr = "$addr$country";
    }

    return addr;
  }
}
