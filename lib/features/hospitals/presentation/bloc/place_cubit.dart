import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/place_model.dart';
import '../../domain/entities/place.dart';

part 'place_state.dart';

class PlaceCubit extends Cubit<PlaceState> {
  PlaceCubit() : super(PlaceInitial());

  static PlaceCubit get(context) => BlocProvider.of(context);

  getPlaces(String type)async{
    try{
      emit(LoadingPlacesState());
      final String response = await rootBundle
          .loadString('assets/json/$type.json');
      print('getPlaces $response ');
      final List decodedJson = json.decode(response) as List;
      List<Place> places = decodedJson
          .map<PlaceModel>((jsonCategoryModel) =>
          PlaceModel.fromJson(jsonCategoryModel))
          .toList();

      print('places length ${places.length}');

      emit(LoadedPlacesState(places));

    }catch(e){
      if (kDebugMode) {
        print('Error getPlaces $e');
      }
      emit(const ErrorPlacesState('error'));
    }
  }

}
