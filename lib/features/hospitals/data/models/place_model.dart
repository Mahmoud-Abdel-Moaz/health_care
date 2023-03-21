
import '../../domain/entities/place.dart';

class PlaceModel extends Place{
 const PlaceModel(super.name, super.number, super.address, super.availability, super.location, super.latitude, super.longitude);


 factory PlaceModel.fromJson(Map<String, dynamic> json) {
  return PlaceModel(
      json['name'], json['number'], json['address'], json['availability'], json['location'], json['latitude'], json['longitude']);
 }

 Map<String, dynamic> toJson() {
  final Map<String, dynamic> json = <String, dynamic>{};
  json['name'] = name;
  json['number'] = number;
  json['address'] = address;
  json['availability'] = availability;
  json['location'] = location;
  json['latitude'] = latitude;
  json['longitude'] = longitude;
  return json;
 }

}