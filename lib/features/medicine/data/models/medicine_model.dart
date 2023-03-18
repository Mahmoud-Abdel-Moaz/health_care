
import '../../domain/entities/medicine.dart';

class MedicineModel extends Medicine{
  const MedicineModel(super.id,super.name, super.shape, super.dose, super.hour, super.minute, super.userId, super.notificationId);

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(json['id'],json['name'], json['shape'], json['dose'],json['hour'],json['minute'],json['user_id'],json['notification_id'],);
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> json={};
    json['id']=id;
    json['name']=name;
    json['shape']=shape;
    json['dose']=dose;
    json['hour']=hour;
    json['minute']=minute;
    json['user_id']=userId;
    json['notification_id']=notificationId;
    return json;
  }

}