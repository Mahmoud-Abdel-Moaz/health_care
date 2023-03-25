
import 'package:equatable/equatable.dart';

class Emergency extends Equatable{
  final String id, name,phone;

  Emergency(this.id,this.name, this.phone);
  @override
  List<Object?> get props => [id,name,phone];

}