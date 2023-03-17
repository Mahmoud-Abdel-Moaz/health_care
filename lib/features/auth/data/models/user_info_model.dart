
import '../../domain/entities/user_info.dart';

class UserInfoModel extends FullUserInfo{
  const UserInfoModel(super.id, super.name, super.nationalId, super.gender, super.birthDate, super.phoneNumber, super.email, super.address, super.governorate, super.city, super.infectionState, super.takingVaccine, super.vaccineDate, super.vaccineDose, super.bloodType, super.chronicDisease, super.vaccineType);

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(json['id'], json['name'], json['national_id'],json['gender'],json['birth_date'],json['phone_number'],json['email'],json['address'],json['governorate'],json['city'],json['infection_state'],json['taking_vaccine'],json['vaccine_date'],json['vaccine_dose'],json['blood_type'],json['chronic_disease'],json['vaccine_type'],);
  }

  Map<String,dynamic> toJson(){
    Map<String,dynamic> json={};
    json['id']=id;
    json['name']=name;
    json['national_id']=nationalId;
    json['gender']=gender;
    json['birth_date']=birthDate;
    json['phone_number']=phoneNumber;
    json['email']=email;
    json['address']=address;
    json['governorate']=governorate;
    json['city']=city;
    json['infection_state']=infectionState;
    json['taking_vaccine']=takingVaccine;
    json['vaccine_date']=vaccineDate;
    json['vaccine_dose']=vaccineDose;
    json['blood_type']=bloodType;
    json['chronic_disease']=chronicDisease;
    json['vaccine_type']=vaccineType;

    return json;
  }
}