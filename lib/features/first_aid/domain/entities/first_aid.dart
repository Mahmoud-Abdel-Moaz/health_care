
import 'package:equatable/equatable.dart';

class FirstAid extends Equatable{
  final String title,body;

  const FirstAid(this.title, this.body);

  @override
  // TODO: implement props
  List<Object?> get props => [title,body];
}