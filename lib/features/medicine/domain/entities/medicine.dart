
import 'package:equatable/equatable.dart';

class Medicine extends Equatable{
  final String id, dose,name,shape,userId;
  final int hour,minute,notificationId;

  const Medicine(this.id,this.name, this.shape, this.dose, this.hour, this.minute, this.userId, this.notificationId);

  @override
  List<Object?> get props => [id,name,shape,dose,hour,minute,userId,notificationId];
}