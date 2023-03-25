import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants.dart';
import '../../data/models/emergency_model.dart';
import '../../domain/entities/emergency.dart';

part 'emergency_state.dart';

class EmergencyCubit extends Cubit<EmergencyState> {
  EmergencyCubit() : super(EmergencyInitial());

  static EmergencyCubit get(context) => BlocProvider.of(context);
  List<Emergency>? emergencies;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> getEmergencies() async {
    try {
      emit(LoadingEmergenciesState());
      QuerySnapshot querySnapshot =
      await _firestore.collection('emergencies').doc(userId).collection('emergencies').get();
      emergencies = [];
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> map = doc.data()! as Map<String, dynamic>;
        emergencies!.add(EmergencyModel.fromJson(map));
      }
      emit(LoadedEmergenciesState(emergencies!));
    } catch (e) {
      emit(ErrorEmergenciesState(e.toString()));
      print('Error getEmergencies: $e');
    }
  }


  addEmergency({
    required String name,
    required String phone,
  }) async {
    try {
      emit(LoadingAddEmergencyState());
      final CollectionReference myCollection =
      _firestore.collection('emergencies').doc(userId).collection('emergencies');
      final DocumentReference newDocRef = myCollection.doc();
      final String newDocId = newDocRef.id;
      await _firestore.collection('emergencies').doc(userId).collection('emergencies').doc(newDocId).set(
          EmergencyModel(newDocId, name, phone,)
              .toJson());
      emit(LoadedAddEmergencyState());
    } catch (e) {
      emit(ErrorAddEmergencyState(e.toString()));
      print('Error addEmergency $e');
    }
  }
  
}
