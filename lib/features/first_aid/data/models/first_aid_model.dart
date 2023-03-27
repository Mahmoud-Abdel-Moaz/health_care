
import '../../domain/entities/first_aid.dart';

class FirstAidModel extends FirstAid{
  FirstAidModel(super.title, super.body);
  factory FirstAidModel.fromJson(Map<String, dynamic> json) {
    return FirstAidModel(json['title'], json['body']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['title'] = title;
    json['body'] = body;
    return json;
  }
}