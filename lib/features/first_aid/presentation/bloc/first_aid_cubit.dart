import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/first_aid_model.dart';
import '../../domain/entities/first_aid.dart';

part 'first_aid_state.dart';

class FirstAidCubit extends Cubit<FirstAidState> {
  FirstAidCubit() : super(FirstAidInitial());

  static FirstAidCubit get(context) => BlocProvider.of(context);

  getFirstAids()async{
    try{
      emit(LoadingFirstAidsState());
      final String response = await rootBundle
          .loadString('assets/json/first_aid.json');
      print('getPlaces $response ');
      final List decodedJson = json.decode(response) as List;
      List<FirstAid> firstAids = decodedJson
          .map<FirstAidModel>((jsonCategoryModel) =>
          FirstAidModel.fromJson(jsonCategoryModel))
          .toList();
      emit(LoadedFirstAidsState(firstAids));

    }catch(e){
      if (kDebugMode) {
        print('Error getPlaces $e');
      }
      emit(const ErrorFirstAidsState('error'));
    }
  }
}
