
import '../../domain/entities/emergency.dart';

class EmergencyModel extends Emergency{
  EmergencyModel(super.id,super.name, super.phone);

  factory EmergencyModel.fromJson(Map<String, dynamic> json) {
    return EmergencyModel(json['id'],json['name'], json['phone'],);
  }

  Map<String,dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['id']=id;
    json['name']=name;
    json['phone']=phone;
    return json;
  }

}