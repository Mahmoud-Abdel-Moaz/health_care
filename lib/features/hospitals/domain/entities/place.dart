
import 'package:equatable/equatable.dart';

class Place extends Equatable{
  final String name,number,address,availability,location;
  final double latitude,longitude;

  const Place(this.name, this.number, this.address, this.availability, this.location, this.latitude, this.longitude);

  @override
  List<Object?> get props => [name,number,address,availability,location,latitude,longitude];

}

