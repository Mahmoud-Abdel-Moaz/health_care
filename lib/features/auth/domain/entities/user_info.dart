import 'package:equatable/equatable.dart';

class FullUserInfo extends Equatable {
  final String? id,
      name,
      nationalId,
      gender,
      birthDate,
      phoneNumber,
      email,
      address,
      governorate,
      city,
      infectionState,
      takingVaccine,
      vaccineDate,
      vaccineDose,
      bloodType,
      chronicDisease,vaccineType;

  const FullUserInfo(
      this.id,
      this.name,
      this.nationalId,
      this.gender,
      this.birthDate,
      this.phoneNumber,
      this.email,
      this.address,
      this.governorate,
      this.city,
      this.infectionState,
      this.takingVaccine,
      this.vaccineDate,
      this.vaccineDose,
      this.bloodType,
      this.chronicDisease,this.vaccineType);

  @override
  List<Object?> get props => [
        id,
        name,
        nationalId,
        gender,
        birthDate,
        phoneNumber,
        email,
        address,
        governorate,
        city,
        infectionState,
        takingVaccine,
        vaccineDate,
        vaccineDose,
        bloodType,
        chronicDisease,vaccineType
      ];
}
